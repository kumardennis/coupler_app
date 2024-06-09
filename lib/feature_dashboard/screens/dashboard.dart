import 'package:coupler_app/color_scheme.dart';
import 'package:coupler_app/feature_Auth/getx_controllers/couple_controller.dart';
import 'package:coupler_app/feature_Auth/getx_controllers/user_controller.dart';
import 'package:coupler_app/feature_Reminders/models/CoupleReminderNeeds.dart';
import 'package:coupler_app/feature_dashboard/utils/couple_management.dart';
import 'package:coupler_app/feature_dashboard/widgets/daily_question.dart';
import 'package:coupler_app/feature_dashboard/widgets/daily_quote.dart';
import 'package:coupler_app/shared_widgets/background.dart';
import 'package:coupler_app/shared_widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import '../../feature_Auth/utils/supabase_auth_manger.dart';
import '../../feature_Reminders/utils/getSetReminderNeeds.dart';
import '../../feature_UsSettings/getXControllers/user_settings_controller.dart';
import '../../services/notification_service.dart';
import '../../shared_widgets/forward_button.dart';
import '../widgets/reminders_untouched.dart';

class Dashboard extends HookWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final getSetReminders = GetSetReminderNeeds();

    final UserController userController = Get.find();
    final CoupleController coupleController = Get.find();

    final UserSettingsController userSettingsController = Get.find();

    final textController = useTextEditingController();

    final notificationService = NotificationService();

    ValueNotifier<bool> isReminderCompleted = useState(false);

    useEffect(() {
      notificationService.requestNotificationsPermission();
    }, []);

    useEffect(() {
      Future<void> checkIfReminderCompleted() async {
        List<CoupleReminderNeeds>? reminder =
            await getSetReminders.getReminderNeeds();

        if (reminder != null && reminder.isNotEmpty) {
          isReminderCompleted.value = true;
        }
      }

      userController.user.value.id != 0 ? checkIfReminderCompleted() : null;

      return null;
    }, [coupleController.coupleExists.value, userController.user.value.id]);

    Future<void> sendAnInvite() async {
      await CoupleManagement().sendInvite(textController.text);
    }

    Future<void> acceptAnInvite() async {
      await CoupleManagement().acceptInvite();
    }

    return (Scaffold(
      body: Stack(
        children: [
          Background(),
          LiquidPullToRefresh(
            onRefresh: () async {
              await SupabaseAuthManger().loadFreshUser(
                  userController.user.value.userId,
                  userController.user.value.accessToken);
            },
            child: SingleChildScrollView(
              child: Obx(
                () => Padding(
                    padding: const EdgeInsets.only(
                        right: 20.0, left: 20.0, top: 50.0, bottom: 30.0),
                    child: !coupleController.coupleExists.value
                        ? Column(
                            children: [
                              Text(
                                'inf_InviteCouple'.tr,
                                style:
                                    Theme.of(context).textTheme.headlineLarge,
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Text('inf_InviteCouple2'.tr,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium),
                              const SizedBox(
                                height: 30,
                              ),
                              TextField(
                                controller: textController,
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              ForwardButton(
                                  label: 'btn_InvitePartner'.tr,
                                  onTap: () async {
                                    sendAnInvite();
                                  }),
                              ForwardButton(
                                  label: 'btn_CopyShareableCode'.tr,
                                  onTap: () {})
                            ],
                          )
                        : !coupleController.couple.value.isAccepted
                            ? coupleController.couple.value.initiatedById ==
                                    userController.user.value.id
                                ? Text(
                                    'inf_WaitingForAcceptance'.tr,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineLarge,
                                  )
                                : Column(
                                    children: [
                                      Text(
                                        'inf_InvitePending'.tr,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineLarge,
                                      ),
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      Text(
                                          coupleController
                                                      .couple.value.partner2 !=
                                                  null
                                              ? coupleController
                                                  .couple.value.partner2!.name
                                              : '',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineMedium),
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      ForwardButton(
                                          label: 'btn_AcceptInvite'.tr,
                                          onTap: () {
                                            acceptAnInvite();
                                          }),
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      ForwardButton(
                                          label: 'btn_RejectInvite'.tr,
                                          onTap: () {}),
                                    ],
                                  )
                            : isReminderCompleted.value
                                ? const Column(
                                    children: [
                                      DailyQuote(),
                                      SizedBox(
                                        height: 50,
                                      ),
                                      DailyQuestion()
                                    ],
                                  )
                                : const RemindersUntouched()),
              ),
            ),
          )
        ],
      ),
      appBar: CustomAppbar(
        title: 'hd_Dashboard',
        subtitle: 'lbl_GetOverview',
        appbarIcon: FaIcon(
          FontAwesomeIcons.house,
          color: userSettingsController.user.value.darkMode
              ? Theme.of(context).colorScheme.lightPink
              : Theme.of(context).colorScheme.darkPink,
        ),
      ),
    ));
  }
}
