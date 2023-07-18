import 'package:coupler_app/color_scheme.dart';
import 'package:coupler_app/feature_Auth/getx_controllers/couple_controller.dart';
import 'package:coupler_app/feature_Auth/getx_controllers/user_controller.dart';
import 'package:coupler_app/feature_Reminders/utils/getSetReminderNeeds.dart';
import 'package:coupler_app/shared_widgets/bubble_container.dart';
import 'package:coupler_app/shared_widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../feature_Navigation/getxControllers/navigation_controller.dart';
import '../../shared_widgets/forward_button.dart';
import '../models/CoupleReminderNeeds.dart';
import '../widgets/questionnaire_question_box.dart';

class QuestionnaireQuestions extends HookWidget {
  const QuestionnaireQuestions({super.key});

  @override
  Widget build(BuildContext context) {
    final PageController pageController = usePageController();
    final UserController userController = Get.find();
    final CoupleController coupleController = Get.find();

    ValueNotifier<int> currentPage = useState(0);

    final getSetReminderNeeds = GetSetReminderNeeds();

    return (Scaffold(
      appBar: CustomAppbar(
        title: 'hd_Reminders',
        subtitle: 'hd_Questionnaire',
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
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      'qt_HowOftenDoYouExpect'.tr,
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(
                              color: Theme.of(context).colorScheme.darkPink),
                      textAlign: TextAlign.right,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: StepProgressIndicator(
                      totalSteps: 9,
                      currentStep: currentPage.value + 1,
                      selectedColor: Theme.of(context).colorScheme.darkPink,
                    ),
                  ),
                  Container(
                    height: 600,
                    child: PageView(
                      controller: pageController,
                      onPageChanged: (value) {
                        currentPage.value = value;
                      },
                      children: [
                        QuestionnaireQuestionBox(
                          questionText: 'qt_NiceActivities'.tr,
                          currentPage: currentPage.value,
                        ),
                        QuestionnaireQuestionBox(
                          questionText: 'qt_Surprises'.tr,
                          currentPage: currentPage.value,
                        ),
                        QuestionnaireQuestionBox(
                          questionText: 'qt_IntimateTouches'.tr,
                          currentPage: currentPage.value,
                        ),
                        QuestionnaireQuestionBox(
                          questionText: 'qt_Compliments'.tr,
                          currentPage: currentPage.value,
                        ),
                        QuestionnaireQuestionBox(
                          questionText: 'qt_WarmMessages'.tr,
                          currentPage: currentPage.value,
                        ),
                        QuestionnaireQuestionBox(
                          questionText: 'qt_DeepConvos'.tr,
                          currentPage: currentPage.value,
                        ),
                        QuestionnaireQuestionBox(
                          questionText: 'qt_DiscussRelationships'.tr,
                          currentPage: currentPage.value,
                        ),
                        QuestionnaireQuestionBox(
                          questionText: 'qt_TimeForYourself'.tr,
                          currentPage: currentPage.value,
                        ),
                        QuestionnaireQuestionBox(
                          questionText: 'qt_CaringActivities'.tr,
                          currentPage: currentPage.value,
                        ),
                      ],
                    ),
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
