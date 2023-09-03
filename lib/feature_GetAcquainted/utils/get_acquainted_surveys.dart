import 'package:coupler_app/feature_GetAcquainted/models/get-acquainted-current-session.dart';
import 'package:coupler_app/feature_GetAcquainted/models/get_acquainted_previous_sessions.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../feature_Auth/getx_controllers/couple_controller.dart';
import '../../feature_Auth/getx_controllers/user_controller.dart';
import '../getxControllers/GetAcquaintedSessionSurveyController.dart';
import '../models/get_acquainted_session_survey.dart';

class GetAcquaintedSurveys {
  final UserController userController = Get.find();
  final CoupleController coupleController = Get.find();
  final GetAcquaintedSessionSurveyController
      getAcquaintedSessionSurveyController = Get.find();

  Future<GetAcquaintedSessionSurvey?> createSessionSurvey(int sessionId) async {
    try {
      final response = await Supabase.instance.client.functions
          .invoke('get-acquainted/create-acquainted-session-survey', headers: {
        'Authorization': 'Bearer ${userController.user.value.accessToken}'
      }, body: {
        "coupleId": coupleController.couple.value.id,
        "userId": userController.user.value.id,
        "sessionId": sessionId,
      });

      final data = await response.data;

      if (data['isRequestSuccessfull'] == true) {
        if ((data['data'] as List).isEmpty) {
          return null;
        }

        List<GetAcquaintedSessionSurvey> session = (data['data'] as List)
            .map((e) => GetAcquaintedSessionSurvey.fromJson(e))
            .toList();

        return session.isEmpty ? null : session.first;
      } else {
        Get.snackbar('Oops...', data['error']);
        return null;
      }
    } catch (err) {
      print(err);
      Get.snackbar('Oops...', err.toString());
    }
  }

  Future<GetAcquaintedSessionSurvey?> getSessionSurvey(int sessionId,
      [bool? getForPartner]) async {
    try {
      final response = await Supabase.instance.client.functions
          .invoke('get-acquainted/get-acquainted-session-survey', headers: {
        'Authorization': 'Bearer ${userController.user.value.accessToken}'
      }, body: {
        "coupleId": coupleController.couple.value.id,
        "userId": (getForPartner != null)
            ? coupleController.couple.value.partner2!.id
            : userController.user.value.id,
        "sessionId": sessionId,
      });

      final data = await response.data;

      if (data['isRequestSuccessfull'] == true) {
        if ((data['data'] as List).isEmpty) {
          return null;
        }

        List<GetAcquaintedSessionSurvey> session = (data['data'] as List)
            .map((e) => GetAcquaintedSessionSurvey.fromJson(e))
            .toList();

        return session.isEmpty ? null : session.first;
      } else {
        Get.snackbar('Oops...', data['error']);
        return null;
      }
    } catch (err) {
      print(err);
      Get.snackbar('Oops...', err.toString());
      return null;
    }
  }

  Future<void> updateSurveyPredictedScore(double predictedScore) async {
    try {
      final response = await Supabase.instance.client.functions
          .invoke('get-acquainted/update-acquainted-survey', headers: {
        'Authorization': 'Bearer ${userController.user.value.accessToken}'
      }, body: {
        "surveyId": getAcquaintedSessionSurveyController
            .sessionSurvey.value!.acquaintedSurveyId,
        "predictedScore": predictedScore,
      });

      final data = await response.data;

      if (data['isRequestSuccessfull'] == false) {
        Get.snackbar('Oops...', data['error']);
      }
    } catch (err) {
      print(err);
      Get.snackbar('Oops...', err.toString());
    }
  }

  Future<void> updateSurveyScore(double score) async {
    try {
      final response = await Supabase.instance.client.functions
          .invoke('get-acquainted/update-acquainted-survey', headers: {
        'Authorization': 'Bearer ${userController.user.value.accessToken}'
      }, body: {
        "surveyId": getAcquaintedSessionSurveyController
            .sessionSurvey.value!.acquaintedSurveyId,
        "score": score.toInt(),
      });

      final data = await response.data;

      if (data['isRequestSuccessfull'] == false) {
        Get.snackbar('Oops...', data['error']);
      }
    } catch (err) {
      print(err);
      Get.snackbar('Oops...', err.toString());
    }
  }

  Future<void> updateSessionSurveySpeaking() async {
    try {
      final response = await Supabase.instance.client.functions
          .invoke('get-acquainted/update-acquainted-session-survey', headers: {
        'Authorization': 'Bearer ${userController.user.value.accessToken}'
      }, body: {
        "sessionSurveyId":
            getAcquaintedSessionSurveyController.sessionSurvey.value!.id,
        "speakingDone": true,
      });

      final data = await response.data;

      if (data['isRequestSuccessfull'] == false) {
        Get.snackbar('Oops...', data['error']);
      }
    } catch (err) {
      print(err);
      Get.snackbar('Oops...', err.toString());
    }
  }

  Future<void> updateSessionSurveyAssessing() async {
    try {
      final response = await Supabase.instance.client.functions
          .invoke('get-acquainted/update-acquainted-session-survey', headers: {
        'Authorization': 'Bearer ${userController.user.value.accessToken}'
      }, body: {
        "sessionSurveyId":
            getAcquaintedSessionSurveyController.sessionSurvey.value!.id,
        "assessingDone": true,
      });

      final data = await response.data;

      if (data['isRequestSuccessfull'] == false) {
        Get.snackbar('Oops...', data['error']);
      }
    } catch (err) {
      print(err);
      Get.snackbar('Oops...', err.toString());
    }
  }
}
