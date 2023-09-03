import 'package:coupler_app/color_scheme.dart';
import 'package:coupler_app/feature_GetAcquainted/getxControllers/GetAcquaintedNavigationController.dart';
import 'package:coupler_app/feature_GetAcquainted/models/get-acquainted-current-session.dart';
import 'package:coupler_app/feature_GetAcquainted/models/get_acquainted_previous_sessions.dart';
import 'package:coupler_app/feature_GetAcquainted/utils/get_acquainted_sessions.dart';
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
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../feature_UsSettings/getXControllers/user_settings_controller.dart';
import '../../shared_widgets/user_avatar.dart';
import '../getxControllers/GetAcquaintedSessionSurveyController.dart';
import '../utils/get_acquainted_surveys.dart';

/* use get-acquainted-next-theme */
/* use get-acquainted-previous-sessions */

class IntroScreen extends HookWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GetAcquaintedNavigationController getAcquaintedController =
        Get.find();
    final GetAcquaintedSessionSurveyController
        getAcquaintedSessionSurveyController = Get.find();

    final UserSettingsController userSettingsController = Get.find();

    ValueNotifier<double> currentSliderValue = useState(0);

    double sliderWidth = MediaQuery.of(context).size.width - 100;

    final getAcquaintedSurveys = GetAcquaintedSurveys();

    useEffect(() {
      if (getAcquaintedSessionSurveyController
              .sessionSurvey.value!.acquaintedSurveys.predictedScore !=
          null) {
        currentSliderValue.value = getAcquaintedSessionSurveyController
            .sessionSurvey.value!.acquaintedSurveys.predictedScore as double;
      }

      return null;
    }, [getAcquaintedSessionSurveyController.sessionSurvey.value]);

    Future<void> updateSurveyScore() async {
      await getAcquaintedSurveys
          .updateSurveyPredictedScore(currentSliderValue.value);

      getAcquaintedController.changeReminderRoute(
          getAcquaintedSessionSurveyController.sessionSurvey.value!.willMeStart
              ? GetAcquaintedRoutes.instructionSpeak
              : GetAcquaintedRoutes.instructionListen);
    }

    return (Scaffold(
      appBar: CustomAppbar(
        title: 'hd_GetAcquainted',
        subtitle: 'hd_LetsGetAcquainted',
        appbarIcon: FaIcon(
          FontAwesomeIcons.heartCircleBolt,
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
                BubbleContainer(position: 'START', children: [
                  Text(
                    'inf_PredictScore'.tr,
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(color: Theme.of(context).colorScheme.dark),
                  ),
                ]),
                const SizedBox(
                  height: 50.0,
                ),
                Text(
                  'lbl_PredictScore'.tr,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(
                  height: 30.0,
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
                  height: 50,
                ),
                ForwardButton(
                  label: 'btn_LetsBegin'.tr,
                  onTap: () {
                    updateSurveyScore();
                  },
                ),
              ]),
            ),
          ),
        ],
      ),
    ));
  }
}
