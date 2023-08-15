import 'dart:convert';

import 'package:dartssh2/dartssh2.dart';

Future<SSHClient?> sshToServer() async {
  try {
    return SSHClient(
      await SSHSocket.connect('192.168.64.100', 22),
      username: 'admin',
      onPasswordRequest: () => 'admin',
    );
  } catch (e) {
    return null;
  }
}

Future<void> sshShell({
  required SSHClient sshClient,
  required String command,
}) async {
  try {
    final res = await sshClient.run(command);
    print(utf8.decode(res));
  } catch (e) {
    print(e);
  }
}
