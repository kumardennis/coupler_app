import 'package:coupler_app/color_scheme.dart';
import 'package:coupler_app/feature_UsSettings/models/special_dates.dart';
import 'package:coupler_app/shared_widgets/bubble_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:timeline_tile/timeline_tile.dart';

class UsTimelineTile extends HookWidget {
  final SpecialDates date;
  final bool? isFirst;
  const UsTimelineTile({super.key, required this.date, this.isFirst});

  @override
  Widget build(BuildContext context) {
    return TimelineTile(
      isFirst: isFirst ?? true,
      afterLineStyle:
          LineStyle(color: Theme.of(context).colorScheme.brightPink),
      beforeLineStyle:
          LineStyle(color: Theme.of(context).colorScheme.brightPink),
      indicatorStyle: IndicatorStyle(
          width: 50,
          height: 50,
          indicator: Container(
            decoration: BoxDecoration(
                border: Border.all(
                    color: Theme.of(context).colorScheme.light, width: 7.0),
                borderRadius: BorderRadius.circular(50.0),
                color: Theme.of(context).colorScheme.brightPink),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: FaIcon(
                  FontAwesomeIcons.heartCircleBolt,
                  color: Theme.of(context).colorScheme.light,
                  size: 20.0,
                ),
              ),
            ),
          ),
          color: Theme.of(context).colorScheme.brightPink),
      endChild: Padding(
        padding: const EdgeInsets.fromLTRB(50.0, 100.0, 20.0, 20.0),
        child: BubbleContainer(
          position: 'END',
          children: [
            Column(children: [
              Text(
                DateFormat('EEE, dd MMM - yyyy')
                    .format(DateTime.parse(date.date)),
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              Text(
                date.dateDescription,
                style: Theme.of(context).textTheme.headlineSmall,
              )
            ])
          ],
        ),
      ),
    );
  }
}
