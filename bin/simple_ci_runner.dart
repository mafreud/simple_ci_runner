import 'package:supabase/supabase.dart';

import 'api_keys.dart';
import 'service/ssh/ssh_service.dart';
import 'service/vm/vm_service.dart';

void main(List<String> arguments) async {
  while (true) {
    // TODO(mafreud): refactor with Isolate.
    await deletePreviousVM();
    await cloneVM();
    launchVM();
    await Future.delayed(Duration(seconds: 20));
    await sshToServer();
    final supabase = SupabaseClient(supabaseUrl, supabaseKey);

    final data = await supabase.from('tasks').select();
    print(data);
    await Future.delayed(Duration(seconds: 10));
  }
}
