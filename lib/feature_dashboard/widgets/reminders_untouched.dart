import 'package:coupler_app/color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';

import '../../feature_Navigation/getxControllers/navigation_controller.dart';
import '../../feature_Reminders/getxControllers/ReminderNavigationController.dart';
import '../../feature_Reminders/utils/getSetReminderNeeds.dart';
import '../../shared_widgets/bubble_container.dart';
import '../../shared_widgets/forward_button.dart';

class RemindersUntouched extends HookWidget {
  const RemindersUntouched({super.key});

  @override
  Widget build(BuildContext context) {
    final getSetReminders = GetSetReminderNeeds();

    final RemindersNavigationController remindersController = Get.find();
    final NavigationController navigationController = Get.find();

    return Column(children: [
      Text(
        'inf_Welcome'.tr,
        style: Theme.of(context).textTheme.displayLarge,
      ),
      const SizedBox(
        height: 50,
      ),
      BubbleContainer(position: 'START', children: [
        Text(
          'inf_ReminderNotTouched'.tr,
          style: Theme.of(context)
              .textTheme
              .displayMedium
              ?.copyWith(color: Theme.of(context).colorScheme.dark),
        ),
      ]),
      const SizedBox(
        height: 50,
      ),
      ForwardButton(
        label: 'hd_Reminders'.tr,
        onTap: () {
          navigationController.changeIndex(1);

          remindersController.changeReminderRoute(RemindersRoutes.firstSurvey);
        },
      )
    ]);
  }
}
