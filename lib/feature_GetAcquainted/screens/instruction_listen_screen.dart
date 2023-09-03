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
import 'package:flutter/scheduler.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../feature_UsSettings/getXControllers/user_settings_controller.dart';
import '../../shared_widgets/user_avatar.dart';
import '../getxControllers/GetAcquaintedSessionSurveyController.dart';
import '../utils/get_acquainted_surveys.dart';

/* use get-acquainted-next-theme */
/* use get-acquainted-previous-sessions */

class InstructionListenScreen extends HookWidget {
  const InstructionListenScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GetAcquaintedNavigationController getAcquaintedController =
        Get.find();

    final GetAcquaintedSessionSurveyController
        getAcquaintedSessionSurveyController = Get.find();

    final UserSettingsController userSettingsController = Get.find();

    final getAcquaintedSurveys = GetAcquaintedSurveys();

    ValueNotifier<bool> hasPartnerSpoken = useState(false);

    useEffect(() {
      Supabase.instance.client.channel('acquainted_sessions_surveys_listen').on(
          RealtimeListenTypes.postgresChanges,
          ChannelFilter(
            event: 'UPDATE',
            schema: 'public',
            table: 'acquainted_sessions_surveys',
            filter:
                'acquaintedSessionId=eq.${getAcquaintedSessionSurveyController.sessionSurvey.value!.acquaintedSessionId}',
          ), (payload, [ref]) {
        var receivedId = payload['new']['id'];
        var receivedSpeakingDone = payload['new']['speakingDone'];

        print(payload['new']);

        if (receivedId !=
            getAcquaintedSessionSurveyController.sessionSurvey.value!.id) {
          hasPartnerSpoken.value = true;
        }
      }).subscribe();

      return null;
    }, [getAcquaintedSessionSurveyController.sessionSurvey.value]);

    useEffect(() {
      void changeScreen() {
        SchedulerBinding.instance.addPostFrameCallback((_) {
          getAcquaintedController
              .changeReminderRoute(GetAcquaintedRoutes.instructionRespond);
        });
      }

      if (hasPartnerSpoken.value == true) {
        changeScreen();
      }
    }, [hasPartnerSpoken.value]);

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
                BubbleContainer(
                    icon: FaIcon(
                      FontAwesomeIcons.earListen,
                      color: Theme.of(context).colorScheme.light,
                    ),
                    position: 'START',
                    children: [
                      Text(
                        'inf_ListenToPartner'.tr,
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).colorScheme.darkPink),
                      ),
                    ]),
                const SizedBox(
                  height: 30.0,
                ),
                ForwardButton(
                  label: 'btn_ListenToPartner'.tr,
                  onTap: () {},
                ),
              ]),
            ),
          ),
        ],
      ),
    ));
  }
}
