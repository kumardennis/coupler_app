import 'package:coupler_app/color_scheme.dart';
import 'package:coupler_app/feature_Auth/getx_controllers/couple_controller.dart';
import 'package:coupler_app/feature_Auth/getx_controllers/user_controller.dart';
import 'package:coupler_app/feature_UsSettings/getXControllers/user_settings_controller.dart';
import 'package:coupler_app/feature_dashboard/models/answered_daily_question_model.dart';
import 'package:coupler_app/feature_dashboard/utils/daily_stuff_class.dart';
import 'package:coupler_app/feature_dashboard/widgets/daily_question.dart';
import 'package:coupler_app/feature_dashboard/widgets/daily_questions_item.dart';
import 'package:coupler_app/shared_widgets/background.dart';
import 'package:coupler_app/shared_widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class AllDailyQuestionsScreen extends HookWidget {
  const AllDailyQuestionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final UserController userController = Get.find();
    final UserSettingsController userSettingsController = Get.find();
    final CoupleController coupleController = Get.find();

    var allQuestions = useState<List<AnsweredDailyQuestionModel>>([]);

    DailyStuffClass dailyStuffClass = DailyStuffClass();

    Future getAnsweredQuestions() async {
      var response = await dailyStuffClass
          .getAllAnsweredDailyQuestions(userController.user.value.accessToken);

      allQuestions.value = response;
    }

    Future getQuestionAndAnswer() async {
      await getAnsweredQuestions();
    }

    useEffect(() {
      getQuestionAndAnswer();
      return null;
    }, []);

    return (Scaffold(
      body: Stack(children: [
        Background(),
        LiquidPullToRefresh(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 50.0, 20.0, 20.0),
              child: ListView(
                children: allQuestions.value
                    .map((question) => question
                                    .couplesDailyQuestions.first.userId ==
                                userController.user.value.id ||
                            (question.couplesDailyQuestions.length > 1 &&
                                question.couplesDailyQuestions[1].userId ==
                                    coupleController.couple.value.partner1!.id)
                        ? DailyQuestionItem(
                            dailyQuestion: question,
                          )
                        : DailyQuestion(
                            questionId: question.id,
                          ))
                    .toList(),
              ),
            ),
            onRefresh: () async {
              print('refresh');
              return;
            }),
      ]),
      appBar: CustomAppbar(
        title: 'hd_Dashboard',
        subtitle: 'lbl_GetOverview',
        appbarIcon: FaIcon(
          FontAwesomeIcons.house,
          color: userSettingsController.user.value.darkMode
              ? Theme.of(context).colorScheme.lightPink
              : Theme.of(context).colorScheme.darkPink,
        ),
      ),
    ));
  }
}
