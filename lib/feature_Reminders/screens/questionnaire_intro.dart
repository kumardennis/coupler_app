import 'package:coupler_app/color_scheme.dart';
import 'package:coupler_app/feature_Reminders/utils/getSetReminderSurvey.dart';
import 'package:coupler_app/shared_widgets/bubble_container.dart';
import 'package:coupler_app/shared_widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../feature_Navigation/getxControllers/navigation_controller.dart';
import '../../feature_UsSettings/getXControllers/user_settings_controller.dart';
import '../../shared_widgets/background.dart';
import '../../shared_widgets/forward_button.dart';
import '../getxControllers/ReminderNavigationController.dart';

class QuestionnaireIntro extends HookWidget {
  const QuestionnaireIntro({super.key});

  @override
  Widget build(BuildContext context) {
    final RemindersNavigationController remindersController = Get.find();

    final UserSettingsController userSettingsController = Get.find();

    return (Scaffold(
      appBar: CustomAppbar(
        title: 'hd_Reminders',
        subtitle: 'hd_Questionnaire',
        appbarIcon: FaIcon(
          FontAwesomeIcons.listCheck,
          color: userSettingsController.user.value.darkMode
              ? Theme.of(context).colorScheme.lightPink
              : Theme.of(context).colorScheme.darkPink,
        ),
      ),
      body: Stack(
        children: [
          Background(),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(
                  right: 20.0, left: 20.0, top: 50.0, bottom: 30.0),
              child: Column(
                children: [
                  BubbleContainer(
                      imageUrl:
                          'assets/images/first_survey_unsplash_trent_bradley.jpg',
                      icon: FaIcon(
                        FontAwesomeIcons.gear,
                        color: Theme.of(context).colorScheme.light,
                      ),
                      position: 'START',
                      children: [
                        Text(
                          'inf_QuestionnaireFirstGear'.tr,
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge
                              ?.copyWith(
                                  color: Theme.of(context).colorScheme.light),
                          textAlign: TextAlign.center,
                        ),
                      ]),
                  const SizedBox(
                    height: 50,
                  ),
                  BubbleContainer(position: 'END', children: [
                    Text(
                      'lbl_QuestionnaireYourNeedsPart1'.tr,
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(color: Theme.of(context).colorScheme.dark),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      'lbl_QuestionnaireYourNeedsPart2'.tr,
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).colorScheme.dark),
                      textAlign: TextAlign.center,
                    ),
                  ]),
                  const SizedBox(
                    height: 50,
                  ),
                  ForwardButton(
                    label: 'btn_LetsBegin'.tr,
                    onTap: () {
                      remindersController.changeReminderRoute(
                          RemindersRoutes.questionnaireQuestions);
                    },
                  )
                ],
              ),
            ),
          )
        ],
      ),
    ));
  }
}
