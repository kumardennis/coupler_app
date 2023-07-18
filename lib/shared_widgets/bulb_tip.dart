import 'package:coupler_app/color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class BulbTip extends StatelessWidget {
  final Widget text;
  const BulbTip({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.brightPink,
              shape: BoxShape.circle,
            ),
            child: Center(
                child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: FaIcon(
                FontAwesomeIcons.lightbulb,
                color: Theme.of(context).colorScheme.light,
              ),
            ))),
        const SizedBox(
          width: 10,
        ),
        Expanded(child: text
            // Text(
            //   'tip_FirstSurvey'.tr,
            //   style: Theme.of(context)
            //       .textTheme
            //       .bodySmall
            //       ?.copyWith(color: Theme.of(context).colorScheme.dark),
            //   maxLines: 2,
            //   overflow: TextOverflow.ellipsis,
            // ),
            ),
      ],
    );
  }
}
