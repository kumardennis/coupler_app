import 'package:coupler_app/color_scheme.dart';
import 'package:coupler_app/feature_Auth/getx_controllers/user_controller.dart';
import 'package:coupler_app/feature_Auth/utils/supabase_auth_manger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../utils/getSetUsSettings.dart';

class UpdateAnniversaryPopup extends HookWidget {
  final Function getAnniversary;

  const UpdateAnniversaryPopup({super.key, required this.getAnniversary});

  @override
  Widget build(BuildContext context) {
    final UserController userController = Get.find();

    ValueNotifier pickedDate = useState(null);

    final UsSettingsHelper usSettingsHelper = UsSettingsHelper();

    void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
      pickedDate.value = args.value;
    }

    Future addDate() async {
      print(pickedDate.value);

      await usSettingsHelper.updateAnniversary(pickedDate.value);

      await SupabaseAuthManger().loadFreshUser(userController.user.value.userId,
          userController.user.value.accessToken);

      Navigator.of(context).pop();
    }

    return AlertDialog(
      title: Text('lbl_Anniversary'.tr),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200,
            width: 200,
            child: SfDateRangePicker(
              onSelectionChanged: _onSelectionChanged,
              selectionMode: DateRangePickerSelectionMode.single,
            ),
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          style: TextButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.dark),
          child: Text(
            'btn_Close'.tr,
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(color: Theme.of(context).colorScheme.light),
          ),
        ),
        TextButton(
          onPressed: () {
            addDate();
          },
          style: TextButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.darkPink),
          child: Text(
            'btn_Add'.tr,
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(color: Theme.of(context).colorScheme.light),
          ),
        )
      ],
    );
  }
}
