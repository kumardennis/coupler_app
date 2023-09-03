import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

enum GetAcquaintedRoutes {
  surveyScreen,
  homeScreen,
  introScreen,
  instructionListen,
  instructionRespond,
  instructionAssessResponse,
  instructionSpeak,
  surveySummary,
  advices
}

class GetAcquaintedNavigationController extends GetxController {
  Rx<GetAcquaintedRoutes> currentRoute = GetAcquaintedRoutes.homeScreen.obs;

  void changeReminderRoute(GetAcquaintedRoutes route) {
    currentRoute.value = route;
  }
}
