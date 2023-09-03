import 'package:coupler_app/color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../feature_Navigation/getxControllers/navigation_controller.dart';

class ForwardButton extends GetWidget<NavigationController> {
  final String label;
  final Function onTap;
  final FaIcon? icon;
  const ForwardButton(
      {super.key, required this.label, required this.onTap, this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.darkPink),
          onPressed: () {
            onTap();
          },
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  label,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: Theme.of(context).colorScheme.light,
                      fontStyle: FontStyle.italic),
                ),
                const SizedBox(
                  width: 10,
                ),
                icon ?? const FaIcon(FontAwesomeIcons.caretRight)
              ],
            ),
          )),
    );
  }
}
