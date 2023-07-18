import 'package:coupler_app/color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../feature_Auth/getx_controllers/couple_controller.dart';
import '../../feature_Auth/getx_controllers/user_controller.dart';
import '../../shared_widgets/bubble_container.dart';
import '../../shared_widgets/forward_button.dart';
import '../getxControllers/ReminderNavigationController.dart';
import '../models/CoupleReminderNeeds.dart';
import '../utils/getSetReminderNeeds.dart';

class QuestionnaireSummaryBox extends HookWidget {
  final String questionText;
  final int timePeriod;
  final int frequency;

  const QuestionnaireSummaryBox({
    super.key,
    required this.questionText,
    required this.timePeriod,
    required this.frequency,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                frequency == 1
                    ? 'lbl_Once'.tr
                    : frequency == 2
                        ? 'lbl_Twice'.tr
                        : 'lbl_FrequencyTimes'
                            .trParams({'count': frequency.toString()}),
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    color: Theme.of(context).colorScheme.brightPink,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                  timePeriod == 1
                      ? 'lbl_InADay'.tr
                      : timePeriod == 7
                          ? 'lbl_InAWeek'.tr
                          : 'lbl_InAMonth'.tr,
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      color: Theme.of(context).colorScheme.brightPink,
                      fontWeight: FontWeight.w500)),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          BubbleContainer(
            position: 'START',
            children: [
              Text(
                questionText,
                style: Theme.of(context).textTheme.headlineSmall,
                textAlign: TextAlign.end,
              ),
            ],
          ),
          const SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }
}
