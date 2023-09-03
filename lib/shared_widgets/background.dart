import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';

import '../feature_UsSettings/getXControllers/user_settings_controller.dart';

class Background extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final UserSettingsController userSettingsController = Get.find();

    return Obx(() => Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(userSettingsController.user.value.darkMode
                      ? 'assets/images/tile_background_pink_dark.png'
                      : 'assets/images/tile_background.png'),
                  fit: BoxFit.cover)),
        ));
  }
}
