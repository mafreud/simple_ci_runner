import 'package:process_run/process_run.dart';

Future<void> deletePreviousVM() async {
  final shell = Shell();

  try {
    await shell.run('tart delete vf6');
    await Future.delayed(Duration(seconds: 1));
  } catch (e) {
    print(e);
  }
}

Future<void> cloneVM() async {
  final shell = Shell();

  try {
    await shell.run('tart clone vf5 vf6');
    await Future.delayed(Duration(seconds: 1));
  } catch (e) {
    print(e);
  }
}

Future<void> launchVM() async {
  final shell = Shell();

  try {
    await shell.run('tart run vf6');
  } catch (e) {
    print(e);
  }
}
