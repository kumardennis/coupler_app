import 'package:coupler_app/color_scheme.dart';
import 'package:coupler_app/shared_widgets/background.dart';
import 'package:coupler_app/shared_widgets/bubble_container.dart';
import 'package:coupler_app/shared_widgets/bulb_tip.dart';
import 'package:coupler_app/shared_widgets/custom_appbar.dart';
import 'package:coupler_app/shared_widgets/forward_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../feature_UsSettings/getXControllers/user_settings_controller.dart';
import '../getxControllers/ReminderNavigationController.dart';
import '../utils/getSetReminderSurvey.dart';

class FirstSurvey extends HookWidget {
  const FirstSurvey({super.key});

  @override
  Widget build(BuildContext context) {
    final RemindersNavigationController remindersController = Get.find();

    final getSetReminderSurvey = GetSetReminderSurvey();

    final UserSettingsController userSettingsController = Get.find();

    ValueNotifier<double> currentSliderValue = useState(0);

    double sliderWidth = MediaQuery.of(context).size.width - 100;

    return (Scaffold(
      appBar: CustomAppbar(
        title: 'hd_Reminders',
        subtitle: 'hd_FirstSurvey',
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
              child: Column(children: [
                BubbleContainer(
                    imageUrl:
                        'assets/images/first_survey_unsplash_trent_bradley.jpg',
                    icon: FaIcon(
                      FontAwesomeIcons.quoteLeft,
                      color: Theme.of(context).colorScheme.light,
                    ),
                    position: 'START',
                    children: [
                      Text(
                        'qt_FirstSurvey'.tr,
                        style: GoogleFonts.merienda(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).colorScheme.light),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'qt_FirstSurveyAuthor'.tr,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(
                                  color: Theme.of(context).colorScheme.light),
                        ),
                      )
                    ]),
                const SizedBox(
                  height: 30.0,
                ),
                BubbleContainer(position: 'MIDDLE', children: [
                  Text(
                    'inf_FirstSurveyPart1'.tr,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(color: Theme.of(context).colorScheme.dark),
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  Text(
                    'inf_FirstSurveyPart2'.tr,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(color: Theme.of(context).colorScheme.dark),
                  ),
                ]),
                const SizedBox(
                  height: 30.0,
                ),
                BubbleContainer(position: 'END', children: [
                  Text(
                    'lbl_FirstSurvey'.tr,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.dark),
                  ),
                ]),
                const SizedBox(
                  height: 30,
                ),
                SliderTheme(
                  data: SliderThemeData(
                    activeTrackColor: Theme.of(context).colorScheme.brightPink,
                    inactiveTrackColor:
                        Theme.of(context).colorScheme.brightPink,
                    thumbColor: Theme.of(context)
                        .colorScheme
                        .brightPink, // set thumb color as pink
                    thumbShape: const RoundSliderThumbShape(
                        enabledThumbRadius:
                            15.0), // adjust thumb radius as per your requirement
                    overlayColor: Colors
                        .white, // the overlay color when thumb is being pressed
                    overlayShape: const RoundSliderOverlayShape(
                        overlayRadius:
                            20.0), // adjust overlay radius, it gives border effect
                  ),
                  child: Slider(
                    value: currentSliderValue.value,
                    min: 0,
                    max: 10,
                    divisions: 10,
                    label: currentSliderValue.value.toString(),
                    onChanged: (double value) {
                      currentSliderValue.value = value;
                    },
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                BulbTip(
                    text: Text(
                  'tip_FirstSurvey'.tr,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.brightPink),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                )),
                ForwardButton(
                  label: 'btn_ContinueToQuestionnaire'.tr,
                  onTap: () {
                    remindersController.changeReminderRoute(
                        RemindersRoutes.questionnaireIntro);

                    if (currentSliderValue.value != 0) {
                      getSetReminderSurvey
                          .setReminderSurveyScore(currentSliderValue);
                    }
                  },
                )
              ]),
            ),
          ),
        ],
      ),
    ));
  }
}
