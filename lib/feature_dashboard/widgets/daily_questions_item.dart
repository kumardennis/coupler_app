import 'package:coupler_app/color_scheme.dart';
import 'package:coupler_app/feature_dashboard/models/answered_daily_question_model.dart';
import 'package:coupler_app/feature_dashboard/widgets/daily_question_item_answer.dart';
import 'package:coupler_app/shared_widgets/bubble_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class DailyQuestionItem extends HookWidget {
  final AnsweredDailyQuestionModel dailyQuestion;
  const DailyQuestionItem({super.key, required this.dailyQuestion});

  @override
  Widget build(BuildContext context) {
    var showOptions = useState<bool>(false);

    return Column(
      children: [
        GestureDetector(
          onTap: () {
            showOptions.value = !showOptions.value;
          },
          child: BubbleContainer(
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
                            'lbl_QuestionOfTheDay'.tr,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                                    color: Theme.of(context).colorScheme.light),
                          ),
                        ),
                      ),
                    ),
                    Text(dailyQuestion.question.originalText,
                        style: Theme.of(context)
                            .textTheme
                            .displayLarge
                            ?.copyWith(
                                color: Theme.of(context).colorScheme.light,
                                fontWeight: FontWeight.w600)),
                  ],
                )
              ]),
        ),
        showOptions.value
            ? Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      DailyQuestionItemAnswer(
                        names: dailyQuestion.couplesDailyQuestions
                            .where((element) =>
                                element.selectedAnswer == 'option1')
                            .toList(),
                        answerText: dailyQuestion.option1.originalText,
                        alignment: Alignment.center,
                      ),
                      DailyQuestionItemAnswer(
                        names: dailyQuestion.couplesDailyQuestions
                            .where((element) =>
                                element.selectedAnswer == 'option2')
                            .toList(),
                        answerText: dailyQuestion.option2.originalText,
                        alignment: Alignment.center,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      DailyQuestionItemAnswer(
                        names: dailyQuestion.couplesDailyQuestions
                            .where((element) =>
                                element.selectedAnswer == 'option3')
                            .toList(),
                        answerText: dailyQuestion.option3.originalText,
                        alignment: Alignment.center,
                      ),
                      DailyQuestionItemAnswer(
                        names: dailyQuestion.couplesDailyQuestions
                            .where((element) =>
                                element.selectedAnswer == 'option4')
                            .toList(),
                        answerText: dailyQuestion.option4.originalText,
                        alignment: Alignment.center,
                      ),
                    ],
                  ),
                ],
              )
            : const SizedBox(),
      ],
    );
  }
}
