
import 'dart:convert';

import 'package:shaoni/features/my-requests/domain/entities/all_requests_with_stages.dart';

import '../../../domain/use_cases/get_all_user_requests_use_case.dart';

abstract class MyRequestsLocalDataSources{
  Future cacheAllMyRequests({required AllRequestsWithStages requests});
}

class MyRequestsLocalDataSourcesImp implements MyRequestsLocalDataSources {
  @override
  Future cacheAllMyRequests({required AllRequestsWithStages requests}) async{
    final String myRequestsString = jsonEncode(AllRequestsWithStages);
  }
}