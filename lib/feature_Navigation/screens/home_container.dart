import 'package:coupler_app/color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../../feature_Dashboard/screens/dashboard.dart';
import '../../feature_Reminders/screens/first_survey.dart';
import '../../feature_Reminders/screens/reminders_screens.dart';
import '../getxControllers/navigation_controller.dart';

class HomeContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                },
                items: <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                      icon: const FaIcon(FontAwesomeIcons.house),
                      label: 'hd_Dashboard'.tr),
                  BottomNavigationBarItem(
                      icon: const FaIcon(FontAwesomeIcons.listCheck),
                      label: 'hd_Reminders'.tr),
                ],
              )),
        );
      },
    );
  }
}
