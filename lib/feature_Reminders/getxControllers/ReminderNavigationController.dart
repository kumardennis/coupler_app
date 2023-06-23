import 'package:get/get.dart';

enum RemindersRoutes {
  firstSurvey,
  questionnaireIntro,
}

class RemindersNavigationController extends GetxController {
  Rx<RemindersRoutes> currentRoute = RemindersRoutes.firstSurvey.obs;

  void changeReminderRoute(RemindersRoutes route) {
    currentRoute.value = route;
  }
}
