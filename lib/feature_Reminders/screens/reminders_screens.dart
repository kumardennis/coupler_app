import 'package:coupler_app/color_scheme.dart';
import 'package:coupler_app/feature_Reminders/screens/first_survey.dart';
import 'package:coupler_app/feature_Reminders/screens/questionnaire_intro.dart';
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
              default:
                return Container();
            }
          }),
          // bottomNavigationBar: Obx(() => BottomNavigationBar(
          //       currentIndex: controller.currentIndex.value,
          //       selectedItemColor: Theme.of(context).colorScheme.darkPink,
          //       unselectedItemColor: Theme.of(context).colorScheme.dark,
          //       onTap: (index) {
          //         controller.changeIndex(index);
          //       },
          //       items: <BottomNavigationBarItem>[
          //         BottomNavigationBarItem(
          //             icon: const FaIcon(FontAwesomeIcons.house),
          //             label: 'hd_Dashboard'.tr),
          //         BottomNavigationBarItem(
          //             icon: const FaIcon(FontAwesomeIcons.listCheck),
          //             label: 'hd_Reminders'.tr),
          //       ],
          //     )),
        );
      },
    );
  }
}
