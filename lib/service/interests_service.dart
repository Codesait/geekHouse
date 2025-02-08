import 'package:projects/utils/exception_handler.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class InterestServices {
  final supabase = Supabase.instance.client;

  Future<List<dynamic>?> fetchInterests() async {
    List<dynamic>? res;

    await SupabaseExceptionHandlerService.handleExceptions(() async {
      res = await supabase.rpc('get_sorted_interests');
    });

    return res;
  }

  Future<List<dynamic>?> fetchCommunitiesByInterests() async {
    // final user = supabase.auth.currentSession!.user;

    List<dynamic>? res;

    await SupabaseExceptionHandlerService.handleExceptions(() async {
      res = await supabase.rpc('get_communities_sorted_by_category',);
    });

    return res;
  }

  Future<dynamic> saveInterests({required List<int> userInterest}) async {
    final user = supabase.auth.currentSession!.user;

    // Prepare data for batch insert
    final data = {
      'p_user_id': user.id,
      'p_interest_ids': userInterest,
    };

    dynamic res;
    await SupabaseExceptionHandlerService.handleExceptions(() async {
      res = await supabase.rpc<dynamic>('add_user_interests', params: data);
    });

    return res;
  }

  
}
