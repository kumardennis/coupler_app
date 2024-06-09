import 'package:coupler_app/color_scheme.dart';

import 'package:coupler_app/feature_dashboard/models/answered_daily_question_model.dart';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class DailyQuestionItemAnswer extends HookWidget {
  final String answerText;
  final Alignment alignment;
  final List<CouplesDailyQuestions> names;
  const DailyQuestionItemAnswer(
      {super.key,
      required this.answerText,
      required this.names,
      required this.alignment});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: Container(
              height: 200,
              width: (MediaQuery.of(context).size.width / 2) - 30,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: names.isNotEmpty
                      ? Theme.of(context).colorScheme.darkPink
                      : Theme.of(context).colorScheme.lightPink),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
                  child: Text(
                    answerText,
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: names.isEmpty
                            ? Theme.of(context).colorScheme.dark
                            : Theme.of(context).colorScheme.light),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 30,
            right: 30,
            child: Text(
              names.length > 1
                  ? 'Both selected this <3'
                  : names.length == 1
                      ? names.first.users.name
                      : '',
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: Theme.of(context).colorScheme.light),
            ),
          ),
        ],
      ),
    );
  }
}
