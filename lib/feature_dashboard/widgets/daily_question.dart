import 'package:coupler_app/color_scheme.dart';
import 'package:coupler_app/feature_Auth/getx_controllers/user_controller.dart';
import 'package:coupler_app/feature_dashboard/models/answered_daily_question_model.dart';
import 'package:coupler_app/feature_dashboard/models/daily_question_model.dart';
import 'package:coupler_app/feature_dashboard/utils/daily_stuff_class.dart';
import 'package:coupler_app/feature_dashboard/widgets/daily_question_answer.dart';
import 'package:coupler_app/shared_widgets/bubble_container.dart';
import 'package:coupler_app/shared_widgets/forward_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class DailyQuestion extends HookWidget {
  final int? questionId;
  const DailyQuestion({super.key, this.questionId});

  @override
  Widget build(BuildContext context) {
    UserController userController = Get.find();

    var dailyQuestion = useState<DailyQuestionModel?>(null);
    var answeredDailyQuestion = useState<AnsweredDailyQuestionModel?>(null);
    var selectedAnswer = useState<String?>(null);
    var fetchedAnswer = useState<String?>(null);

    var isLoading = useState<bool>(true);

    DailyStuffClass dailyStuffClass = DailyStuffClass();

    Future getQuestionOfTheDay() async {
      var response = await dailyStuffClass.getDailyQuestion(
          userController.user.value.accessToken, questionId);

      dailyQuestion.value = response;

      if (questionId != null) {
        isLoading.value = false;
      }
    }

    Future getAnsweredQuestionOfTheDay(int dailyQuestionId) async {
      isLoading.value = true;

      var response = await dailyStuffClass.getAnsweredDailyQuestion(
          userController.user.value.accessToken, dailyQuestionId);

      answeredDailyQuestion.value = response;

      Iterable<CouplesDailyQuestions>? questions = response
          ?.couplesDailyQuestions
          .where((element) => element.userId == userController.user.value.id);

      if (questions != null && questions.isNotEmpty) {
        fetchedAnswer.value = questions.first.selectedAnswer;
      }

      isLoading.value = false;
    }

    Future getQuestionAndAnswer() async {
      await getQuestionOfTheDay();

      await getAnsweredQuestionOfTheDay(dailyQuestion.value!.id);
    }

    useEffect(() {
      getQuestionAndAnswer();
      return null;
    }, []);

    return Column(
      children: [
        BubbleContainer(
            imageUrl: 'assets/images/question_bg_unsplash_ana_municio.jpg',
            icon: FaIcon(
              FontAwesomeIcons.question,
              color: Theme.of(context).colorScheme.light,
            ),
            position: 'END',
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    top: -60.0,
                    left: 60.0,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Theme.of(context).colorScheme.darkPink),
                      child: Padding(
                        padding:
                            const EdgeInsets.fromLTRB(15.0, 8.0, 15.0, 8.0),
                        child: Text(
                          questionId != null
                              ? 'lbl_YourTurn'.tr
                              : 'lbl_QuestionOfTheDay'.tr,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(
                                  color: Theme.of(context).colorScheme.light),
                        ),
                      ),
                    ),
                  ),
                  dailyQuestion.value == null
                      ? const SizedBox()
                      : Text(dailyQuestion.value!.question.originalText,
                          style: Theme.of(context)
                              .textTheme
                              .displayLarge
                              ?.copyWith(
                                  color: Theme.of(context).colorScheme.light,
                                  fontWeight: FontWeight.w600)),
                ],
              )
            ]),
        isLoading.value
            ? const CircularProgressIndicator()
            : fetchedAnswer.value != null
                ? Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'inf_AlreadyAnswered'.tr,
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium
                              ?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color:
                                      Theme.of(context).colorScheme.brightPink),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        FaIcon(
                          FontAwesomeIcons.circleCheck,
                          color: Theme.of(context).colorScheme.brightPink,
                        )
                      ],
                    ),
                  )
                : Column(
                    children: [
                      dailyQuestion.value == null
                          ? const SizedBox()
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    selectedAnswer.value = 'option1';
                                  },
                                  child: DailyQuestionAnswer(
                                    isSelected: selectedAnswer.value == null
                                        ? false
                                        : selectedAnswer.value == 'option1',
                                    answerText: dailyQuestion
                                        .value!.option1.originalText,
                                    alignment: Alignment.center,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    selectedAnswer.value = 'option2';
                                  },
                                  child: DailyQuestionAnswer(
                                    isSelected: selectedAnswer.value == null
                                        ? false
                                        : selectedAnswer.value == 'option2',
                                    answerText: dailyQuestion
                                        .value!.option2.originalText,
                                    alignment: Alignment.center,
                                  ),
                                ),
                              ],
                            ),
                      dailyQuestion.value == null
                          ? const SizedBox()
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    selectedAnswer.value = 'option3';
                                  },
                                  child: DailyQuestionAnswer(
                                    isSelected: selectedAnswer.value == null
                                        ? false
                                        : selectedAnswer.value == 'option3',
                                    answerText: dailyQuestion
                                        .value!.option3.originalText,
                                    alignment: Alignment.center,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    selectedAnswer.value = 'option4';
                                  },
                                  child: DailyQuestionAnswer(
                                    isSelected: selectedAnswer.value == null
                                        ? false
                                        : selectedAnswer.value == 'option4',
                                    answerText: dailyQuestion
                                        .value!.option4.originalText,
                                    alignment: Alignment.center,
                                  ),
                                ),
                              ],
                            ),
                      ForwardButton(
                          label: 'btn_MarkMyChoice'.tr,
                          onTap: () async {
                            if (selectedAnswer.value != null) {
                              await dailyStuffClass.createAnsweredDailyQuestion(
                                  userController.user.value.accessToken,
                                  dailyQuestion.value!.id,
                                  selectedAnswer.value);

                              getQuestionAndAnswer();
                            }
                          })
                    ],
                  ),
        questionId == null
            ? ForwardButton(
                label: 'See previous questions'.tr,
                onTap: () async {
                  Get.toNamed('/all-daily-questions');
                })
            : const SizedBox()
      ],
    );
  }
}
