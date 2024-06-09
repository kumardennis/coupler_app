import 'package:coupler_app/color_scheme.dart';
import 'package:coupler_app/feature_GetAcquainted/getxControllers/GetAcquaintedNavigationController.dart';
import 'package:coupler_app/feature_GetAcquainted/models/get-acquainted-current-session.dart';
import 'package:coupler_app/feature_GetAcquainted/models/get_acquainted_previous_sessions.dart';
import 'package:coupler_app/feature_GetAcquainted/utils/get_acquainted_sessions.dart';
import 'package:coupler_app/shared_widgets/bubble_container.dart';
import 'package:coupler_app/shared_widgets/bulb_tip.dart';
import 'package:coupler_app/shared_widgets/custom_appbar.dart';
import 'package:coupler_app/shared_widgets/forward_button.dart';
import 'package:easy_loader/easy_loader.dart';
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
import '../../shared_widgets/background.dart';
import '../../shared_widgets/user_avatar.dart';
import '../getxControllers/GetAcquaintedSessionSurveyController.dart';
import '../utils/get_acquainted_surveys.dart';

/* use get-acquainted-next-theme */
/* use get-acquainted-previous-sessions */

class InstructionRespondScreen extends HookWidget {
  const InstructionRespondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GetAcquaintedNavigationController getAcquaintedController =
        Get.find();

    final GetAcquaintedSessionSurveyController
        getAcquaintedSessionSurveyController = Get.find();

    final UserSettingsController userSettingsController = Get.find();

    final getAcquaintedSurveys = GetAcquaintedSurveys();

    ValueNotifier<bool> hasPartnerSpoken = useState(false);
    ValueNotifier<bool> hasSessionEnded = useState(false);
    ValueNotifier<bool> isLoading = useState(false);

    useEffect(() {
      if (getAcquaintedSessionSurveyController.sessionSurvey.value != null) {
        Supabase.instance.client
            .channel('acquainted_sessions_surveys_respond')
            .on(
                RealtimeListenTypes.postgresChanges,
                ChannelFilter(
                  event: '*',
                  schema: 'public',
                  table: 'acquainted_sessions_surveys',
                  filter:
                      'acquaintedSessionId=eq.${getAcquaintedSessionSurveyController.sessionSurvey.value!.acquaintedSessionId}',
                ), (payload, [ref]) {
          var receivedId = payload['new']['id'];
          var receivedAssessingDone = payload['new']['assessingDone'];

          if (receivedAssessingDone &&
              receivedId !=
                  getAcquaintedSessionSurveyController
                      .sessionSurvey.value!.id) {
            hasPartnerSpoken.value = true;
          }
        }).subscribe();
      }

      return null;
    }, [getAcquaintedSessionSurveyController.sessionSurvey.value]);

    useEffect(() {
      void changeScreen() async {
        isLoading.value = true;
        SchedulerBinding.instance.addPostFrameCallback((_) {
          if (getAcquaintedSessionSurveyController
              .sessionSurvey.value!.willMeStart) {
            Future.delayed(const Duration(milliseconds: 1000), () {
              getAcquaintedController
                  .changeReminderRoute(GetAcquaintedRoutes.homeScreen);
            });
          } else {
            Future.delayed(const Duration(milliseconds: 1000), () {
              getAcquaintedController
                  .changeReminderRoute(GetAcquaintedRoutes.instructionSpeak);
            });
          }

          isLoading.value = false;
        });
      }

      if (hasPartnerSpoken.value) {
        changeScreen();
      }
    }, [hasPartnerSpoken.value, hasSessionEnded.value]);

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
                      FontAwesomeIcons.microphone,
                      color: Theme.of(context).colorScheme.light,
                    ),
                    position: 'START',
                    children: [
                      Text(
                        'qt_RespondToPartner'.tr,
                        style: GoogleFonts.merienda(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).colorScheme.dark),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'qt_SpeakToPartnerAuthor'.tr,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(
                                  color: Theme.of(context).colorScheme.dark),
                        ),
                      )
                    ]),
                const SizedBox(
                  height: 30.0,
                ),
                BubbleContainer(position: 'END', children: [
                  Text(
                    'inf_RespondToPartner'.tr,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.darkPink),
                  ),
                ]),
                const SizedBox(
                  height: 30.0,
                ),
                ForwardButton(
                  label: 'btn_RespondToPartner'.tr,
                  onTap: () {},
                ),
              ]),
            ),
          ),
          isLoading.value
              ? const EasyLoader(image: AssetImage('assets/images/logo.png'))
              : const SizedBox(),
        ],
      ),
    ));
  }
}
