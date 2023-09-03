import 'package:coupler_app/color_scheme.dart';
import 'package:coupler_app/feature_Reminders/utils/getSetReminderSurvey.dart';
import 'package:coupler_app/shared_widgets/background.dart';
import 'package:coupler_app/shared_widgets/bubble_container.dart';
import 'package:coupler_app/shared_widgets/bulb_tip.dart';
import 'package:coupler_app/shared_widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../feature_Auth/getx_controllers/couple_controller.dart';
import '../../feature_Navigation/getxControllers/navigation_controller.dart';
import '../../feature_UsSettings/getXControllers/user_settings_controller.dart';
import '../../shared_widgets/forward_button.dart';
import '../getxControllers/ReminderNavigationController.dart';
import '../models/CoupleReminderNeeds.dart';
import '../models/CoupleReminderSurvey.dart';
import '../models/chart_data.dart';
import '../utils/getSetReminderNeeds.dart';
import '../widgets/questionnaire_summary_box.dart';

class RemindersSummary extends HookWidget {
  const RemindersSummary({super.key});

  @override
  Widget build(BuildContext context) {
    final RemindersNavigationController remindersController = Get.find();
    final CoupleController coupleController = Get.find();

    final UserSettingsController userSettingsController = Get.find();

    ValueNotifier<List<CoupleReminderNeeds>> coupleReminderNeeds = useState([]);

    final getSetReminderNeeds = GetSetReminderNeeds();
    final getSetReminderSurveys = GetSetReminderSurvey();

    final ValueNotifier<List<ChartData>> chartData = useState([]);

    useEffect(() {
      Future<void> getSurveyScores() async {
        List<CoupleReminderSurvey>? scores1 =
            await getSetReminderSurveys.getReminderSurveyScores();

        List<CoupleReminderSurvey>? scores2 =
            await getSetReminderSurveys.getReminderSurveyScores(
                coupleController.couple.value.partner2!.id);

        int maxLength =
            scores1!.length > scores2!.length ? scores1.length : scores2.length;

        List<ChartData> allData = [];

        scores1.sort((a, b) => a.created_at.compareTo(b.created_at));
        scores2.sort((a, b) => a.created_at.compareTo(b.created_at));

        for (var index = 0; index < scores1!.length; index++) {
          /* Check if both partners have same date of scores */
          var date = DateFormat('MMM dd, yyy')
              .format(DateTime.parse(scores1[index].created_at));

          allData.add(ChartData(scores1[index].created_at,
              scores1[index].score as double?, null));
        }

        for (var index = 0; index < scores2!.length; index++) {
          /* Check if both partners have same date of scores */
          var date = DateFormat('MMM dd, yyy')
              .format(DateTime.parse(scores2[index].created_at));

          var date2 = allData.indexWhere((element) =>
              DateFormat('MMM dd, yyy').format(DateTime.parse(element.x)) ==
              date);

          bool bothPartnersHaveCommonDate = date2 > -1;

          /* If yes, get scores related to that date for both parters */

          if (bothPartnersHaveCommonDate) {
            allData[date2].y2 = scores2[index].score as double?;
          } else {
            /* If no, add seperate dates and scores */

            allData.add(ChartData(
              scores2[index].created_at,
              null,
              scores2[index].score as double?,
            ));
          }
        }

        /* Sort data by date */
        allData.sort((ChartData a, ChartData b) => a.x.compareTo(b.x));

        chartData.value = allData;
      }

      getSurveyScores();
    }, []);

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
          color: userSettingsController.user.value.darkMode
              ? Theme.of(context).colorScheme.lightPink
              : Theme.of(context).colorScheme.darkPink,
        ),
      ),
      body: Stack(
        children: [
          Background(),
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
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).colorScheme.dark)),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            'qt_FirstSurveyAuthor'.tr,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                                    color: Theme.of(context).colorScheme.dark),
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
                        primaryXAxis: CategoryAxis(
                            labelRotation: 45,
                            arrangeByIndex: true,
                            isVisible: false),
                        series: <CartesianSeries>[
                          LineSeries<ChartData, String>(
                              dataSource: chartData.value,
                              xValueMapper: (ChartData data, _) =>
                                  DateFormat('MMM dd, yy')
                                      .format(DateTime.parse(data.x)),
                              yValueMapper: (data, _) => data.y1),
                          LineSeries<ChartData, String>(
                              dataSource: chartData.value,
                              xValueMapper: (ChartData data, _) =>
                                  DateFormat('MMM dd, yy')
                                      .format(DateTime.parse(data.x)),
                              yValueMapper: (data, _) => data.y2),
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
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(color: Theme.of(context).colorScheme.dark),
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
                          .changeReminderRoute(RemindersRoutes.reminderSurvey);
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
