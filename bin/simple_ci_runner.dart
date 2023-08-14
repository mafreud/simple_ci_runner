import 'package:supabase/supabase.dart';

import 'api_keys.dart';

void main(List<String> arguments) async {
  final supabase = SupabaseClient(supabaseUrl, supabaseKey);

  final data = await supabase.from('tasks').select();
  print(data);
}
