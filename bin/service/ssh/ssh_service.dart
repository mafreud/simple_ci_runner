import 'package:dartssh2/dartssh2.dart';

Future<void> sshToServer() async {
  try {
    SSHClient(
      await SSHSocket.connect('192.168.64.100', 22),
      username: 'admin',
      onPasswordRequest: () => 'admin',
    );
  } catch (e) {
    print(e);
  }
}
