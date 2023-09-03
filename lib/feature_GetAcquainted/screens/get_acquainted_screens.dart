import 'package:coupler_app/color_scheme.dart';
import 'package:coupler_app/feature_GetAcquainted/getxControllers/GetAcquaintedNavigationController.dart';
import 'package:coupler_app/feature_GetAcquainted/screens/instruction_assess_screen.dart';
import 'package:coupler_app/feature_GetAcquainted/screens/instruction_listen_screen.dart';
import 'package:coupler_app/feature_GetAcquainted/screens/instruction_respond_screen.dart';
import 'package:coupler_app/feature_GetAcquainted/screens/intro_screen.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../feature_Navigation/getxControllers/navigation_controller.dart';
import 'home_screen.dart';
import 'instruction_speak_screen.dart';

class GetAcquaintedScreens extends StatelessWidget {
  final GetAcquaintedNavigationController _remindersController =
      Get.put(GetAcquaintedNavigationController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NavigationController>(
      init: NavigationController(),
      builder: (controller) {
        return Scaffold(
          body: Obx(() {
            switch (_remindersController.currentRoute.value) {
              case GetAcquaintedRoutes.homeScreen:
                return GetAcquaintedHomeScreen();

              case GetAcquaintedRoutes.introScreen:
                return IntroScreen();

              case GetAcquaintedRoutes.instructionListen:
                return InstructionListenScreen();

              case GetAcquaintedRoutes.instructionSpeak:
                return InstructionSpeakScreen();

              case GetAcquaintedRoutes.instructionRespond:
                return InstructionRespondScreen();

              case GetAcquaintedRoutes.instructionAssessResponse:
                return InstructionAssessScreen();

              default:
                return Container();
            }
          }),
        );
      },
    );
  }
}
