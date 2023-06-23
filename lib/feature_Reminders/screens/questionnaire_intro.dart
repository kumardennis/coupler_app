import 'package:coupler_app/color_scheme.dart';
import 'package:coupler_app/shared_widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../feature_Navigation/getxControllers/navigation_controller.dart';

class QuestionnaireIntro extends HookWidget {
  const QuestionnaireIntro({super.key});

  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      appBar: CustomAppbar(
        title: 'hd_Reminders',
        subtitle: 'hd_Questionnaire',
        appbarIcon: FaIcon(
          FontAwesomeIcons.listCheck,
          color: Theme.of(context).colorScheme.darkPink,
        ),
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/tile_background.png'),
                    fit: BoxFit.cover)),
          ),
          SingleChildScrollView(
            child: Text('questionnaire'),
          )
        ],
      ),
    ));
  }
}
