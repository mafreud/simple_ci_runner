// ignore_for_file: non_constant_identifier_names

import 'package:dartssh2/dartssh2.dart';
import 'package:supabase/supabase.dart';

import 'api_keys.dart';
import 'constant/directory_path.dart';
import 'domain/build/build_data.dart';
import 'service/ssh/ssh_service.dart';
import 'service/vm/vm_service.dart';

void main(List<String> arguments) async {
  while (true) {
    // TODO(mafreud): refactor with Isolate.
    await deletePreviousVM();
    await cloneVM();
    launchVM();
    await Future.delayed(Duration(seconds: 20));
    final sshClient = await sshToServer();
    if (sshClient == null) {
      print('ssh client is null');
      continue;
    }
    await cleaningWorkingDirectory(sshClient);
    // supabase
    final supabase = SupabaseClient(supabaseUrl, supabaseKey);
    final response = await supabase.from('tasks').select();
    final data = response.first as Map<String, dynamic>;
    final buildData = BuildData.fromMap(data);

    await createCertificates(
      sshClient: sshClient,
      buildData: buildData,
    );
    await cloneRepository(
      sshClient: sshClient,
      buildData: buildData,
    );

    await importCertificates(sshClient);
    await buildIpa(sshClient: sshClient, buildData: buildData);
    await uploadIpaToFad(sshClient: sshClient, buildData: buildData);
    await stopVM();

    await Future.delayed(Duration(seconds: 10));
  }
}

Future<void> cleaningWorkingDirectory(SSHClient sshClient) async {
  try {
    await sshShell(
        sshClient: sshClient, command: 'echo start directory cleaning.');
    await sshShell(
        sshClient: sshClient, command: 'rm -rf $certificateDirectory;');
    await sshShell(
        sshClient: sshClient,
        command: 'rm -rf ~/Downloads/simple_runner_mobile;');
    await sshShell(
      sshClient: sshClient,
      command: """
     security delete-keychain ~/Users/admin/certificates/app-signing.keychain-db;
     rm ~/Library/MobileDevice/Provisioning\\ Profiles/build_pp.mobileprovision;
    """,
    );
    await sshShell(
        sshClient: sshClient, command: 'echo "finish directory cleaning."');
  } catch (e) {
    print(e);
  }
}

Future<void> createCertificates({
  required SSHClient sshClient,
  required BuildData buildData,
}) async {
  try {
    await sshShell(
        sshClient: sshClient, command: 'echo "start creating certificates."');
    await sshShell(sshClient: sshClient, command: """
mkdir $certificateDirectory;
echo -n ${buildData.build_certificate_base64} | base64 --decode -o $p12;
echo -n ${buildData.build_provision_profile_base64} | base64 --decode -o $mobileprovisionPath;
""");
    await sshShell(
        sshClient: sshClient, command: 'echo "finish creating certificates."');
  } catch (e) {
    print(e);
  }
}

Future<void> cloneRepository({
  required SSHClient sshClient,
  required BuildData buildData,
}) async {
  try {
    await sshShell(
        sshClient: sshClient, command: 'echo "start cloning repository."');
    await sshShell(sshClient: sshClient, command: """
cd ~/Downloads;
git clone https://${buildData.pat}@github.com/${buildData.repository_url};
""");
    await sshShell(
        sshClient: sshClient, command: 'echo "finish cloning repository."');
  } catch (e) {
    print(e);
  }
}

Future<void> importCertificates(SSHClient sshClient) async {
  try {
    await sshShell(
        sshClient: sshClient, command: 'echo "start importing certificates."');
    await sshShell(sshClient: sshClient, command: """
cd ~/Downloads/certificates;
          security create-keychain -p $password $keychainPath;
          security default-keychain -s $keychainPath;
          security unlock-keychain -p $password $keychainPath;
          security set-keychain-settings -lut 21600 $keychainPath;
          security import $p12 -P $password -A -t cert -f pkcs12 -k $keychainPath;
          security list-keychain -d user -s $keychainPath;
          mkdir -p ~/Library/MobileDevice/Provisioning\\ Profiles;
          cp $mobileprovisionPath ~/Library/MobileDevice/Provisioning\\ Profiles;
""");
    await sshShell(
        sshClient: sshClient, command: 'echo "finish importing certificates."');
  } catch (e) {
    print(e);
  }
}

Future<void> buildIpa({
  required SSHClient sshClient,
  required BuildData buildData,
}) async {
  try {
    await sshShell(sshClient: sshClient, command: 'echo "start building ipa."');
    await sshShell(sshClient: sshClient, command: """
source ~/.zshrc;
cd ~/Downloads/simple_runner_mobile;
flutter build ipa --build-number=${buildData.build_number} --export-options-plist=ios/exportOptions.plist;
""");
    await sshShell(
        sshClient: sshClient, command: 'echo "finish building ipa."');
  } catch (e) {
    print(e);
  }
}

Future<void> uploadIpaToFad({
  required SSHClient sshClient,
  required BuildData buildData,
}) async {
  try {
    await sshShell(
        sshClient: sshClient, command: 'echo "start uploading ipa."');
    await sshShell(sshClient: sshClient, command: """
source ~/.zshrc;
firebase --token ${buildData.firebase_cli_token} appdistribution:distribute ${buildPath()} --app $firebaseAppId --release-notes "This is a first build."
""");
    await sshShell(
        sshClient: sshClient, command: 'echo "finish uploading ipa."');
  } catch (e) {
    print(e);
  }
}
