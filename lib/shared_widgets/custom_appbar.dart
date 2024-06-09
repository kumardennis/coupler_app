import 'package:coupler_app/color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../feature_UsSettings/getXControllers/user_settings_controller.dart';

class CustomAppbar extends HookWidget implements PreferredSizeWidget {
  final String title;
  final String subtitle;
  final Widget appbarIcon;

  const CustomAppbar({
    super.key,
    required this.title,
    required this.subtitle,
    required this.appbarIcon,
  });

  @override
  Size get preferredSize => Size.fromHeight(101.0);

  @override
  Widget build(BuildContext context) {
    final UserSettingsController userSettingsController = Get.find();

    return Obx(
      () => (AppBar(
        elevation: 10,
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            userSettingsController.user.value.darkMode
                ? Theme.of(context).colorScheme.dark
                : Theme.of(context).colorScheme.light,
            userSettingsController.user.value.darkMode
                ? Theme.of(context).colorScheme.dark
                : Theme.of(context).colorScheme.light,
          ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
          child: Padding(
            padding: const EdgeInsets.only(left: 55.0, top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Column(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              appbarIcon,
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                '$title'.tr,
                                style: Theme.of(context)
                                    .textTheme
                                    .displayMedium
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          Text('$subtitle'.tr,
                              style: Theme.of(context).textTheme.displaySmall)
                        ],
                      ),
                    ],
                  ),
                ),
                Image.asset(
                  'assets/images/two_hearts_pink.png',
                  scale: 1.5,
                )
              ],
            ),
          ),
        ),
      )),
    );
  }
}
