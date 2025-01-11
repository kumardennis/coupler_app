import 'package:coupler_app/color_scheme.dart';
import 'package:coupler_app/feature_GetAcquainted/getxControllers/GetAcquaintedNavigationController.dart';
import 'package:coupler_app/feature_GetAcquainted/models/get-acquainted-current-session.dart';
import 'package:coupler_app/feature_GetAcquainted/models/get_acquainted_previous_sessions.dart';
import 'package:coupler_app/feature_GetAcquainted/models/get_acquainted_session_survey.dart';
import 'package:coupler_app/feature_GetAcquainted/utils/get_acquainted_sessions.dart';
import 'package:coupler_app/shared_widgets/background.dart';
import 'package:coupler_app/shared_widgets/bubble_container.dart';
import 'package:coupler_app/shared_widgets/bulb_tip.dart';
import 'package:coupler_app/shared_widgets/custom_appbar.dart';
import 'package:coupler_app/shared_widgets/forward_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../feature_UsSettings/getXControllers/user_settings_controller.dart';
import '../../shared_widgets/user_avatar.dart';
import '../getxControllers/GetAcquaintedSessionController.dart';
import '../getxControllers/GetAcquaintedSessionSurveyController.dart';
import '../models/chart_data.dart';
import '../utils/get_acquainted_surveys.dart';

/* use get-acquainted-next-theme */
/* use get-acquainted-previous-sessions */

class GetAcquaintedHomeScreen extends HookWidget {
  const GetAcquaintedHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GetAcquaintedNavigationController getAcquaintedController =
        Get.find();

    final UserSettingsController userSettingsController = Get.find();

    final GetAcquaintedSessionSurveyController
        getAcquaintedSessionSurveyController =
        Get.put(GetAcquaintedSessionSurveyController());

    final GetAcquaintedSessionController getAcquaintedSessionController =
        Get.put(GetAcquaintedSessionController());

    ValueNotifier<List<GetAcquaintedPreviousSessions>> previousSessions =
        useState<List<GetAcquaintedPreviousSessions>>([]);

    ValueNotifier<GetAcquaintedCurrentSession?> nextTheme = useState(null);
    ValueNotifier<bool> isLoading = useState(false);

    final ValueNotifier<List<ChartData>> chartData = useState([]);

    final getAcquaintedSessions = GetAcquaintedSessions();
    final getAcquaintedSurveys = GetAcquaintedSurveys();

    useEffect(() {
      Future<void> getSessions() async {
        var sessions = await getAcquaintedSessions.getPreviousSessions();

        List<ChartData> allData = [];

        for (var session in sessions) {
          var data = ChartData(
              session.acquaintedSessions.createdAt,
              session.acquaintedSurveys1.score?.toDouble(),
              session.acquaintedSurveys2.score?.toDouble());

          allData.add(data);
        }

        chartData.value = allData;
        previousSessions.value = sessions;
      }

      getSessions();
      return null;
    }, []);

    useEffect(() {
      Future<void> getSessions() async {
        isLoading.value = true;
        var next = await getAcquaintedSessions.getCurrentSession();

        nextTheme.value = next;

        if (next != null) {
          getAcquaintedSessionController.updateValue(next);
        }

        isLoading.value = false;
      }

      getSessions();
    }, []);

    Future<void> startSession() async {
      var dataGet =
          await getAcquaintedSurveys.getSessionSurvey(nextTheme.value!.id);

      if (dataGet != null) {
        getAcquaintedSessionSurveyController.updateValue(dataGet);

        getAcquaintedController
            .changeReminderRoute(GetAcquaintedRoutes.introScreen);
      } else {
        var data =
            await getAcquaintedSurveys.createSessionSurvey(nextTheme.value!.id);

        if (data != null) {
          getAcquaintedSessionSurveyController.updateValue(data);

          getAcquaintedController
              .changeReminderRoute(GetAcquaintedRoutes.introScreen);
        }
      }
    }

    return (Scaffold(
      appBar: CustomAppbar(
        title: 'hd_GetAcquainted',
        subtitle: 'hd_LetsGetAcquainted',
        appbarIcon: Obx(
          () => FaIcon(
            FontAwesomeIcons.heartCircleBolt,
            color: userSettingsController.user.value.darkMode
                ? Theme.of(context).colorScheme.lightPink
                : Theme.of(context).colorScheme.darkPink,
          ),
        ),
      ),
      body: Stack(
        children: [
          Background(),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(
                  right: 20.0, left: 20.0, top: 50.0, bottom: 30.0),
              child: Column(children: [
                BubbleContainer(
                    imageUrl:
                        'assets/images/get_acquainted_unsplash_brooklyn.jpg',
                    icon: FaIcon(
                      FontAwesomeIcons.faceKissWinkHeart,
                      color: Theme.of(context).colorScheme.light,
                    ),
                    position: 'START',
                    children: [
                      Text(
                        'inf_GetAcquainted'.tr,
                        style: GoogleFonts.merienda(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).colorScheme.light),
                      ),
                    ]),
                const SizedBox(
                  height: 30.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    nextTheme.value?.acquaintedQuestions?.question ??
                        'loading..',
                    style: Theme.of(context).textTheme.displayLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                    textAlign: TextAlign.center,
                  ),
                ),
                isLoading.value
                    ? CircularProgressIndicator()
                    : DateTime.parse(nextTheme.value!.availableSince)
                                .millisecondsSinceEpoch >
                            DateTime.now().millisecondsSinceEpoch
                        ? ForwardButton(
                            label: 'inf_ThemeAvailableNextMonday'.tr,
                            onTap: () {},
                          )
                        : ForwardButton(
                            label: nextTheme.value?.hasStarted != null &&
                                    nextTheme.value!.hasStarted
                                ? 'btn_ContinueSession'.tr
                                : 'btn_StartSession'.tr,
                            onTap: () async {
                              await startSession();
                            },
                          ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
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
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    'lbl_PreviousThemes'.tr,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: previousSessions.value.isEmpty
                        ? Text('no themes...')
                        : Column(
                            children: previousSessions.value
                                .map((session) => Column(
                                      children: [
                                        Text(
                                          session.acquaintedSessions
                                              .acquaintedQuestions.question,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineSmall
                                              ?.copyWith(
                                                fontWeight: FontWeight.w600,
                                              ),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    UserAvatar(
                                                      imageUrl: session
                                                          .acquaintedSurveys1
                                                          .users
                                                          .profileImage,
                                                    ),
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text(session
                                                        .acquaintedSurveys1
                                                        .users
                                                        .firstName)
                                                  ],
                                                ),
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          session
                                                              .acquaintedSurveys1
                                                              .predictedScore
                                                              .toString(),
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .headlineSmall
                                                                  ?.copyWith(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                  ),
                                                        ),
                                                        Text(
                                                            'lbl_PredictedScore'
                                                                .tr)
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      width: 30,
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          session
                                                              .acquaintedSurveys2
                                                              .score
                                                              .toString(),
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .headlineSmall
                                                              ?.copyWith(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: Theme.of(
                                                                          context)
                                                                      .colorScheme
                                                                      .brightPink),
                                                        ),
                                                        Text('lbl_ActualScore'
                                                            .tr)
                                                      ],
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    UserAvatar(
                                                      imageUrl: session
                                                          .acquaintedSurveys2
                                                          .users
                                                          .profileImage,
                                                    ),
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text(session
                                                        .acquaintedSurveys2
                                                        .users
                                                        .firstName)
                                                  ],
                                                ),
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          session
                                                              .acquaintedSurveys2
                                                              .predictedScore
                                                              .toString(),
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .headlineSmall
                                                                  ?.copyWith(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                  ),
                                                        ),
                                                        Text(
                                                            'lbl_PredictedScore'
                                                                .tr)
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      width: 30,
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          session
                                                              .acquaintedSurveys1
                                                              .score
                                                              .toString(),
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .headlineSmall
                                                              ?.copyWith(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: Theme.of(
                                                                          context)
                                                                      .colorScheme
                                                                      .brightPink),
                                                        ),
                                                        Text('lbl_ActualScore'
                                                            .tr)
                                                      ],
                                                    ),
                                                  ],
                                                )
                                              ],
                                            )
                                          ],
                                        )
                                      ],
                                    ))
                                .toList(),
                          )),
              ]),
            ),
          ),
        ],
      ),
    ));
  }
}
