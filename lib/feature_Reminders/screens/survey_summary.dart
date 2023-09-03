import 'package:coupler_app/color_scheme.dart';
import 'package:coupler_app/feature_Reminders/utils/getSetReminderSurvey.dart';
import 'package:coupler_app/shared_widgets/bubble_container.dart';
import 'package:coupler_app/shared_widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../feature_Navigation/getxControllers/navigation_controller.dart';
import '../../feature_UsSettings/getXControllers/user_settings_controller.dart';
import '../../shared_widgets/background.dart';
import '../../shared_widgets/forward_button.dart';
import '../getxControllers/ReminderNavigationController.dart';
import '../models/CoupleReminderNeeds.dart';
import '../utils/getSetReminderNeeds.dart';
import '../widgets/questionnaire_summary_box.dart';

class SurveySummary extends HookWidget {
  const SurveySummary({super.key});

  @override
  Widget build(BuildContext context) {
    final RemindersNavigationController remindersController = Get.find();

    ValueNotifier<List<CoupleReminderNeeds>> coupleReminderNeeds = useState([]);

    final getSetReminderNeeds = GetSetReminderNeeds();

    final UserSettingsController userSettingsController = Get.find();

    useEffect(() {
      Future<void> getNeeds() async {
        List<CoupleReminderNeeds>? need =
            await getSetReminderNeeds.getAverageReminderNeeds();
        coupleReminderNeeds.value = need!;
      }

      getNeeds();
    }, []);

    return (Scaffold(
      appBar: CustomAppbar(
        title: 'hd_Reminders',
        subtitle: 'hd_Overview',
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(child: SfCartesianChart()),
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  BubbleContainer(position: 'MIDDLE', children: [
                    Text(
                      'inf_ReminderSummary'.tr,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ]),
                  const SizedBox(
                    height: 50,
                  ),
                  ForwardButton(
                    label: 'btn_ReDoSurvey'.tr,
                    onTap: () {
                      remindersController
                          .changeReminderRoute(RemindersRoutes.firstSurvey);
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
