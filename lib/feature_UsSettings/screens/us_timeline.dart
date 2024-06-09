import 'package:coupler_app/color_scheme.dart';
import 'package:coupler_app/feature_Auth/getx_controllers/couple_controller.dart';
import 'package:coupler_app/feature_Auth/getx_controllers/user_controller.dart';
import 'package:coupler_app/feature_UsSettings/getXControllers/user_settings_controller.dart';
import 'package:coupler_app/feature_UsSettings/models/special_dates.dart';
import 'package:coupler_app/feature_UsSettings/utils/getSetUsSettings.dart';
import 'package:coupler_app/feature_UsSettings/widgets/UsTimelineTile.dart';
import 'package:coupler_app/shared_widgets/background.dart';
import 'package:coupler_app/shared_widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:collection/collection.dart';

class UsTimeline extends HookWidget {
  const UsTimeline({super.key});

  @override
  Widget build(BuildContext context) {
    final CoupleController coupleController = Get.find();
    final UserController userController = Get.find();
    final UserSettingsController userSettingsController = Get.find();

    final UsSettingsHelper usSettingsHelper = UsSettingsHelper();

    ValueNotifier<List<SpecialDates>> specialDates = useState([]);

    Future<void> getDates() async {
      var response = await usSettingsHelper.getSpecialDates();

      var dates = response +
          [
            SpecialDates(
                id: -1,
                dateDescription: 'lbl_Anniversary'.tr,
                date: coupleController.couple.value.anniversary!)
          ];

      dates.sort(
          (a, b) => DateTime.parse(a.date).compareTo(DateTime.parse(b.date)));

      specialDates.value = dates;
    }

    useEffect(() {
      getDates();
    }, [userController.user.value.accessToken]);

    return Scaffold(
      appBar: CustomAppbar(
        title: 'hd_Us',
        subtitle: 'hd_OurTimeline',
        appbarIcon: Obx(
          () => FaIcon(
            FontAwesomeIcons.clockRotateLeft,
            color: userSettingsController.user.value.darkMode
                ? Theme.of(context).colorScheme.lightPink
                : Theme.of(context).colorScheme.darkPink,
          ),
        ),
      ),
      body: Stack(
        children: [
          Background(),
          Padding(
            padding: const EdgeInsets.only(
              left: 20.0,
            ),
            child: ListView(
              children: (specialDates.value
                  .mapIndexed((index, date) => UsTimelineTile(
                        date: date,
                        isFirst: index == 0,
                      ))
                  .toList()),
            ),
          )
        ],
      ),
    );
  }
}
