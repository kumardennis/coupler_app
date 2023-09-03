import 'package:coupler_app/feature_GetAcquainted/models/get_acquainted_session_survey.dart';
import 'package:get/get.dart';

class GetAcquaintedSessionSurveyController extends GetxController {
  Rxn<GetAcquaintedSessionSurvey> sessionSurvey =
      Rxn<GetAcquaintedSessionSurvey>();

  void updateValue(GetAcquaintedSessionSurvey route) {
    sessionSurvey.value = route;
  }
}
