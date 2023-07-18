import 'package:coupler_app/color_scheme.dart';
import 'package:coupler_app/feature_Reminders/utils/getSetReminderSurvey.dart';
import 'package:coupler_app/shared_widgets/bubble_container.dart';
import 'package:coupler_app/shared_widgets/bulb_tip.dart';
import 'package:coupler_app/shared_widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../feature_Navigation/getxControllers/navigation_controller.dart';
import '../../shared_widgets/forward_button.dart';
import '../getxControllers/ReminderNavigationController.dart';
import '../models/CoupleReminderNeeds.dart';
import '../models/chart_data.dart';
import '../utils/getSetReminderNeeds.dart';
import '../widgets/questionnaire_summary_box.dart';

class RemindersSummary extends HookWidget {
  const RemindersSummary({super.key});

  @override
  Widget build(BuildContext context) {
    final RemindersNavigationController remindersController = Get.find();

    ValueNotifier<List<CoupleReminderNeeds>> coupleReminderNeeds = useState([]);

    final getSetReminderNeeds = GetSetReminderNeeds();

    final List<ChartData> chartData = <ChartData>[
      ChartData('Germany', 129, 110),
      ChartData('Russia', 90, 200),
      ChartData('USA', 107, 100),
      ChartData('Norway', 68, 90),
    ];

    final List<ChartData> chartData2 = <ChartData>[
      ChartData('Germany', 149, 90),
      ChartData('Russia', 110, 170),
      ChartData('USA', 127, 98),
      ChartData('Norway', 88, 90),
    ];

    useEffect(() {
      Future<void> getNeeds() async {
        List<CoupleReminderNeeds>? need =
            await getSetReminderNeeds.getAverageReminderNeeds();
        coupleReminderNeeds.value = need!;
      }

      getNeeds();
    }, []);

    return (Scaffold(
      appBar: CustomAppbar(
        title: 'hd_Reminders',
        subtitle: 'hd_Overview',
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
            child: Padding(
              padding: const EdgeInsets.only(
                  right: 20.0, left: 20.0, top: 50.0, bottom: 30.0),
              child: Column(
                children: [
                  BubbleContainer(
                      icon: FaIcon(
                        FontAwesomeIcons.quoteLeft,
                        color: Theme.of(context).colorScheme.light,
                      ),
                      position: 'START',
                      children: [
                        Text('qt_ReminderSummray'.tr,
                            style: GoogleFonts.merienda(
                                fontSize: 18, fontWeight: FontWeight.w600)),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            'qt_FirstSurveyAuthor'.tr,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        )
                      ]),
                  const SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          child: SfCartesianChart(
                        series: <CartesianSeries>[
                          LineSeries(
                              dataSource: chartData,
                              xValueMapper: (data, _) => data.y,
                              yValueMapper: (data, _) => data.z),
                          LineSeries(
                              dataSource: chartData2,
                              xValueMapper: (data, _) => data.y,
                              yValueMapper: (data, _) => data.z)
                        ],
                      )),
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  BulbTip(
                      text: Text(
                    'inf_FluctuationsIInSatisfaction'.tr,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: Theme.of(context).colorScheme.brightPink),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  )),
                  const SizedBox(
                    height: 50,
                  ),
                  BubbleContainer(position: 'MIDDLE', children: [
                    Text(
                      'inf_ReminderSummary'.tr,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ]),
                  const SizedBox(
                    height: 50,
                  ),
                  coupleReminderNeeds.value.isNotEmpty
                      ? Column(
                          children: coupleReminderNeeds.value
                              .map(
                                (need) => QuestionnaireSummaryBox(
                                  questionText:
                                      need.reminderNeeds.reminderText.tr,
                                  timePeriod: need.timePeriodInDays,
                                  frequency: need.frequency,
                                ),
                              )
                              .toList(),
                        )
                      : Text('Null value'),
                  ForwardButton(
                    label: 'btn_ReDoQuestionnaire'.tr,
                    onTap: () {
                      remindersController
                          .changeReminderRoute(RemindersRoutes.firstSurvey);
                    },
                  )
                ],
              ),
            ),
          )
        ],
      ),
    ));
  }
}
