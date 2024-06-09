import 'package:coupler_app/color_scheme.dart';
import 'package:coupler_app/feature_Auth/getx_controllers/user_controller.dart';
import 'package:coupler_app/feature_dashboard/models/daily_question_model.dart';
import 'package:coupler_app/feature_dashboard/utils/daily_stuff_class.dart';
import 'package:coupler_app/shared_widgets/bubble_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class DailyQuestionAnswer extends HookWidget {
  final String answerText;
  final Alignment alignment;
  final bool isSelected;
  const DailyQuestionAnswer(
      {super.key,
      required this.answerText,
      required this.isSelected,
      required this.alignment});

  @override
  Widget build(BuildContext context) {
    UserController userController = Get.find();

    var dailyQuestion = useState<DailyQuestionModel?>(null);

    DailyStuffClass dailyStuffClass = DailyStuffClass();

    Future getQuestionOfTheDay() async {
      var response = await dailyStuffClass
          .getDailyQuestion(userController.user.value.accessToken);

      dailyQuestion.value = response;
    }

    useEffect(() {
      getQuestionOfTheDay();
    }, []);

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
                  color: isSelected
                      ? Theme.of(context).colorScheme.darkPink
                      : Theme.of(context).colorScheme.lightPink),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
                  child: Text(
                    answerText,
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: !isSelected
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
            child: Checkbox(
              checkColor: Theme.of(context).colorScheme.darkPink,
              fillColor: MaterialStateProperty.all<Color>(
                  Theme.of(context).colorScheme.lightPink),
              shape: CircleBorder(),
              value: isSelected,
              onChanged: (bool? value) {},
            ),
          ),
        ],
      ),
    );
  }
}
