import 'package:coupler_app/feature_GetAcquainted/models/get_acquainted_session_survey.dart';
import 'package:get/get.dart';

import '../models/get-acquainted-current-session.dart';

class GetAcquaintedSessionController extends GetxController {
  Rxn<GetAcquaintedCurrentSession> currentSession =
      Rxn<GetAcquaintedCurrentSession>();

  void updateValue(GetAcquaintedCurrentSession route) {
    currentSession.value = route;
  }
}
