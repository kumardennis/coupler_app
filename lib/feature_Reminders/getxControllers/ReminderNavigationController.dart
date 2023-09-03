import 'package:get/get.dart';

enum RemindersRoutes {
  remindersSummary,
  firstSurvey,
  questionnaireIntro,
  questionnaireQuestions,
  reminderSurvey,
  surveySummary
}

class RemindersNavigationController extends GetxController {
  Rx<RemindersRoutes> currentRoute = RemindersRoutes.firstSurvey.obs;

  void changeReminderRoute(RemindersRoutes route) {
    currentRoute.value = route;
  }
}
