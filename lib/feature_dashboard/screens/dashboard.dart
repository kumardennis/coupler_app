import 'package:coupler_app/color_scheme.dart';
import 'package:coupler_app/shared_widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../feature_Navigation/getxControllers/navigation_controller.dart';

class Dashboard extends HookWidget {
  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/tile_background.png'),
                fit: BoxFit.cover)),
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
