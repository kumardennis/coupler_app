import 'package:coupler_app/color_scheme.dart';
import 'package:coupler_app/feature_Auth/getx_controllers/couple_controller.dart';
import 'package:coupler_app/feature_Auth/getx_controllers/user_controller.dart';
import 'package:coupler_app/feature_Auth/screens/sign_in.dart';
import 'package:coupler_app/feature_GetAcquainted/getxControllers/GetAcquaintedNavigationController.dart';
import 'package:coupler_app/feature_GetAcquainted/models/get-acquainted-current-session.dart';
import 'package:coupler_app/feature_GetAcquainted/models/get_acquainted_previous_sessions.dart';
import 'package:coupler_app/feature_GetAcquainted/models/get_acquainted_session_survey.dart';
import 'package:coupler_app/feature_UsSettings/getXControllers/user_settings_controller.dart';
import 'package:coupler_app/shared_widgets/background.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:coupler_app/feature_GetAcquainted/utils/get_acquainted_sessions.dart';
import 'package:coupler_app/feature_UsSettings/models/special_dates.dart';
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
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../feature_Auth/utils/supabase_auth_manger.dart';
import '../../shared_widgets/user_avatar.dart';
import '../utils/getSetUsSettings.dart';
import '../widgets/AddDatePopup.dart';

/* use get-acquainted-next-theme */
/* use get-acquainted-previous-sessions */

class UsSettings extends HookWidget {
  const UsSettings({super.key});

  @override
  Widget build(BuildContext context) {
    final CoupleController coupleController = Get.find();
    final UserController userController = Get.find();
    final UserSettingsController userSettingsController = Get.find();

    final _supabase = SupabaseAuthManger();

    ValueNotifier<double> currentSliderValue = useState(0);
    ValueNotifier<List<SpecialDates>> specialDates = useState([]);

    ValueNotifier<bool> darkMode = useState(false);
    ValueNotifier<bool> blueAccent = useState(false);

    double sliderWidth = MediaQuery.of(context).size.width - 100;

    ValueNotifier<bool> isLoading = useState(false);

    final UsSettingsHelper usSettingsHelper = UsSettingsHelper();

    Future<void> getDates() async {
      darkMode.value = userSettingsController.user.value.darkMode;
      blueAccent.value = userSettingsController.user.value.blueAccent;

      var response = await usSettingsHelper.getSpecialDates();

      specialDates.value = response;
    }

    Future<void> changeDarkMode(value) async {
      var response =
          await usSettingsHelper.setAppearanceSettings(value, blueAccent.value);

      _supabase.getUserSettings(
          userController.user.value.id, userController.user.value.accessToken);
    }

    Future<void> changeBlueAccent(value) async {
      var response =
          await usSettingsHelper.setAppearanceSettings(darkMode.value, value);

      _supabase.getUserSettings(
          userController.user.value.id, userController.user.value.accessToken);
    }

    useEffect(() {
      getDates();
    }, [userController.user.value.accessToken]);

    return (Scaffold(
      appBar: CustomAppbar(
        title: 'hd_Us',
        subtitle: 'hd_Settings',
        appbarIcon: Obx(
          () => FaIcon(
            FontAwesomeIcons.handshakeAngle,
            color: userSettingsController.user.value.darkMode
                ? Theme.of(context).colorScheme.lightPink
                : Theme.of(context).colorScheme.darkPink,
          ),
        ),
      ),
      body: Stack(
        children: [
          Background(),
          SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 200,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                  'https://images.unsplash.com/photo-1618005182384-a83a8bd57fbe?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8YWJzdHJhY3R8ZW58MHx8MHx8fDA%3D&w=1000&q=80'))),
                    ),
                    Positioned(
                      top: 120,
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            right: 20.0, left: 20.0, top: 50.0, bottom: 30.0),
                        child: Column(children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: [
                                  UserAvatar(
                                    size: 60,
                                    imageUrl: coupleController
                                        .couple.value.partner1!.profileImage,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    coupleController
                                        .couple.value.partner1!.name,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall,
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  UserAvatar(
                                    size: 60,
                                    imageUrl: coupleController
                                        .couple.value.partner2!.profileImage,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    coupleController
                                        .couple.value.partner2!.name,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall,
                                  )
                                ],
                              )
                            ],
                          ),
                        ]),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 120,
                ),
                Container(
                  child: Column(children: [
                    Text(
                      coupleController.couple.value.anniversary != null
                          ? DateFormat('EEE, dd MMM - yyyy').format(
                              DateTime.parse(
                                  coupleController.couple.value.anniversary ??
                                      ''))
                          : 'lbl_NotSetYet'.tr,
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    Text(
                      'lbl_Anniversary'.tr,
                      style: Theme.of(context).textTheme.headlineSmall,
                    )
                  ]),
                ),
                const SizedBox(
                  height: 30,
                ),
                ForwardButton(
                  label: 'btn_AddSpecialDate'.tr,
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) =>
                          AddDatePopup(getDates: getDates),
                    );
                  },
                  icon: FaIcon(FontAwesomeIcons.heartCirclePlus),
                ),
                const SizedBox(
                  height: 15,
                ),
                Column(
                    children: specialDates.value
                        .map((date) => Container(
                              child: Column(children: [
                                Text(
                                  DateFormat('EEE, dd MMM - yyyy')
                                      .format(DateTime.parse(date.date)),
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium
                                      ?.copyWith(
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                                Text(
                                  date.dateDescription,
                                  style:
                                      Theme.of(context).textTheme.headlineSmall,
                                ),
                                const SizedBox(
                                  height: 20,
                                )
                              ]),
                            ))
                        .toList()),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'lbl_DarkMode'.tr,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    Obx(
                      () => Switch(
                          value: userSettingsController.user.value.darkMode,
                          onChanged: (value) {
                            changeDarkMode(value);
                          }),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('lbl_BlueAccent'.tr,
                        style: Theme.of(context).textTheme.headlineMedium),
                    Obx(
                      () => Switch(
                          value: userSettingsController.user.value.blueAccent,
                          onChanged: (value) {
                            changeBlueAccent(value);
                          }),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    ));
  }
}