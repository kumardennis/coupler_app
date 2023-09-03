import 'package:coupler_app/color_scheme.dart';
import 'package:coupler_app/feature_GetAcquainted/screens/get_acquainted_screens.dart';
import 'package:coupler_app/feature_Reminders/utils/getSetReminderNeeds.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../../feature_Dashboard/screens/dashboard.dart';
import '../../feature_Reminders/getxControllers/ReminderNavigationController.dart';
import '../../feature_Reminders/screens/first_survey.dart';
import '../../feature_Reminders/screens/reminders_screens.dart';
import '../../feature_UsSettings/screens/us_settings.dart';
import '../getxControllers/navigation_controller.dart';

class HomeContainer extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final RemindersNavigationController remindersController =
        Get.put(RemindersNavigationController());

    return GetBuilder<NavigationController>(
      init: NavigationController(),
      builder: (controller) {
        return Scaffold(
          body: Obx(() {
            switch (controller.currentIndex.value) {
              case 0:
                return Dashboard();
              case 1:
                return RemindersScreens();

              case 2:
                return GetAcquaintedScreens();

              case 3:
                return UsSettings();
              default:
                return Container();
            }
          }),
          bottomNavigationBar: Obx(() => BottomNavigationBar(
                currentIndex: controller.currentIndex.value,
                selectedItemColor: Theme.of(context).colorScheme.darkPink,
                unselectedItemColor: Theme.of(context).colorScheme.dark,
                onTap: (index) {
                  controller.changeIndex(index);

                  if (index == 1) {
                    remindersController
                        .changeReminderRoute(RemindersRoutes.remindersSummary);
                  }
                },
                items: <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                      icon: const FaIcon(FontAwesomeIcons.house),
                      label: 'hd_Dashboard'.tr),
                  BottomNavigationBarItem(
                      icon: const FaIcon(FontAwesomeIcons.listCheck),
                      label: 'hd_Reminders'.tr),
                  BottomNavigationBarItem(
                      icon: const FaIcon(FontAwesomeIcons.heartCircleBolt),
                      label: 'hd_GetAcquainted'.tr),
                  BottomNavigationBarItem(
                      icon: const FaIcon(FontAwesomeIcons.handshakeAngle),
                      label: 'hd_Us'.tr),
                ],
              )),
        );
      },
    );
  }
}
