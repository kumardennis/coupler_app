import 'package:coupler_app/color_scheme.dart';
import 'package:coupler_app/feature_Auth/getx_controllers/user_controller.dart';
import 'package:coupler_app/feature_Reminders/models/CoupleReminderNeeds.dart';
import 'package:coupler_app/shared_widgets/bubble_container.dart';
import 'package:coupler_app/shared_widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../feature_Navigation/getxControllers/navigation_controller.dart';
import '../../feature_Reminders/getxControllers/ReminderNavigationController.dart';
import '../../feature_Reminders/utils/getSetReminderNeeds.dart';
import '../../shared_widgets/forward_button.dart';
import '../widgets/reminders_untouched.dart';

class Dashboard extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final getSetReminders = GetSetReminderNeeds();

    final UserController userController = Get.find();

    final RemindersNavigationController remindersController = Get.find();
    final NavigationController navigationController = Get.find();

    ValueNotifier<bool> isReminderCompleted = useState(true);

    useEffect(() {
      Future<void> checkIfReminderCompleted() async {
        List<CoupleReminderNeeds>? reminder =
            await getSetReminders.getReminderNeeds();

        if (reminder == null || reminder.isEmpty) {
          isReminderCompleted.value = false;
        }
      }

      userController.user.value.id != 0 ? checkIfReminderCompleted() : null;

      return null;
    }, []);

    return (Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/tile_background.png'),
                    fit: BoxFit.cover)),
          ),
          SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.only(
                    right: 20.0, left: 20.0, top: 50.0, bottom: 30.0),
                child: isReminderCompleted.value
                    ? Text('Status')
                    : RemindersUntouched()),
          )
        ],
      ),
      appBar: CustomAppbar(
        title: 'hd_Dashboard',
        subtitle: 'lbl_GetOverview',
        appbarIcon: FaIcon(
          FontAwesomeIcons.house,
          color: Theme.of(context).colorScheme.darkPink,
        ),
      ),
    ));
  }
}
