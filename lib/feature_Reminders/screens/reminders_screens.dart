import 'package:coupler_app/color_scheme.dart';
import 'package:coupler_app/feature_Reminders/screens/first_survey.dart';
import 'package:coupler_app/feature_Reminders/screens/questionnaire_intro.dart';
import 'package:coupler_app/feature_Reminders/screens/questionnaire_questions.dart';
import 'package:coupler_app/feature_Reminders/screens/reminders_summary.dart';
import 'package:coupler_app/feature_Reminders/screens/survey_summary.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../feature_Navigation/getxControllers/navigation_controller.dart';
import '../getxControllers/ReminderNavigationController.dart';

class RemindersScreens extends StatelessWidget {
  final RemindersNavigationController _remindersController =
      Get.put(RemindersNavigationController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NavigationController>(
      init: NavigationController(),
      builder: (controller) {
        return Scaffold(
          body: Obx(() {
            switch (_remindersController.currentRoute.value) {
              case RemindersRoutes.firstSurvey:
                return FirstSurvey();
              case RemindersRoutes.questionnaireIntro:
                return QuestionnaireIntro();
              case RemindersRoutes.questionnaireQuestions:
                return QuestionnaireQuestions();

              case RemindersRoutes.remindersSummary:
                return RemindersSummary();

              case RemindersRoutes.surveySummary:
                return SurveySummary();
              default:
                return Container();
            }
          }),
        );
      },
    );
  }
}
