import 'package:process_run/process_run.dart';

Future<void> runCommand(String command) async {
  final shell = Shell();

  try {
    await shell.run(command);
  } catch (e) {
    print(e);
  }
}
