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

class QuestionnaireQuestionBox extends HookWidget {
  final String questionText;
  final int currentPage;

  const QuestionnaireQuestionBox(
      {super.key, required this.questionText, required this.currentPage});

  @override
  Widget build(BuildContext context) {
    ValueNotifier<int> timePeriod = useState(1);
    ValueNotifier<double> frequency = useState(0);

    final RemindersNavigationController remindersController = Get.find();

    ValueNotifier<CoupleReminderNeeds?> coupleReminderNeed = useState(null);

    final getSetReminderNeeds = GetSetReminderNeeds();

    useEffect(() {
      Future<void> getNeeds() async {
        List<CoupleReminderNeeds>? need =
            await getSetReminderNeeds.getReminderNeeds(currentPage + 1);

        if (need!.isNotEmpty) {
          coupleReminderNeed.value = need.first;
        }

        if (need.isNotEmpty) {
          timePeriod.value = need.first.timePeriodInDays;
          frequency.value = need.first.frequency.toDouble();
        } else {
          timePeriod.value = 1;
          frequency.value = 1;
        }
      }

      getNeeds();
    }, [currentPage]);

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          BubbleContainer(
            position: 'START',
            children: [
              Text(
                questionText,
                style: Theme.of(context)
                    .textTheme
                    .headlineLarge
                    ?.copyWith(color: Theme.of(context).colorScheme.darkPink),
                textAlign: TextAlign.start,
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          RatingBar(
            itemSize: 30,
            initialRating: frequency.value ?? 0,
            direction: Axis.horizontal,
            allowHalfRating: false,
            itemCount: 5,
            ratingWidget: RatingWidget(
              full: FaIcon(
                FontAwesomeIcons.solidHeart,
                color: Theme.of(context).colorScheme.brightPink,
                size: 45,
              ),
              empty: FaIcon(FontAwesomeIcons.heart,
                  color: Theme.of(context).colorScheme.brightPink, size: 45),
              half: FaIcon(FontAwesomeIcons.solidHeart),
            ),
            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
            onRatingUpdate: (rating) {
              frequency.value = rating;
              getSetReminderNeeds.setReminderNeeds(
                  currentPage + 1, frequency, timePeriod);
            },
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ChoiceChip(
                padding: EdgeInsets.all(20),
                backgroundColor: Theme.of(context).colorScheme.light,
                selectedColor: Theme.of(context).colorScheme.brightPink,
                label: Text(
                  'btn_Daily'.tr,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: timePeriod.value == 1
                          ? Theme.of(context).colorScheme.light
                          : Theme.of(context).colorScheme.brightPink),
                ),
                selected: timePeriod.value == 1,
                onSelected: (bool selected) {
                  timePeriod.value = (selected ? 1 : null)!;
                  getSetReminderNeeds.setReminderNeeds(
                      currentPage + 1, frequency, timePeriod);
                },
              ),
              ChoiceChip(
                padding: EdgeInsets.all(20),
                backgroundColor: Theme.of(context).colorScheme.light,
                selectedColor: Theme.of(context).colorScheme.brightPink,
                label: Text(
                  'btn_Weekly'.tr,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: timePeriod.value == 7
                          ? Theme.of(context).colorScheme.light
                          : Theme.of(context).colorScheme.brightPink),
                ),
                selected: timePeriod.value == 7,
                onSelected: (bool selected) {
                  timePeriod.value = (selected ? 7 : null)!;
                  getSetReminderNeeds.setReminderNeeds(
                      currentPage + 1, frequency, timePeriod);
                },
              ),
              ChoiceChip(
                padding: EdgeInsets.all(20),
                backgroundColor: Theme.of(context).colorScheme.light,
                selectedColor: Theme.of(context).colorScheme.brightPink,
                label: Text(
                  'btn_Monthly'.tr,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: timePeriod.value == 30
                          ? Theme.of(context).colorScheme.light
                          : Theme.of(context).colorScheme.brightPink),
                ),
                selected: timePeriod.value == 30,
                onSelected: (bool selected) {
                  timePeriod.value = (selected ? 30 : null)!;
                  getSetReminderNeeds.setReminderNeeds(
                      currentPage + 1, frequency, timePeriod);
                },
              )
            ].toList(),
          ),
          currentPage == 8
              ? ForwardButton(
                  label: 'btn_ContinueToSummary'.tr,
                  onTap: () {
                    remindersController
                        .changeReminderRoute(RemindersRoutes.remindersSummary);
                  },
                )
              : const SizedBox()
        ],
      ),
    );
  }
}
