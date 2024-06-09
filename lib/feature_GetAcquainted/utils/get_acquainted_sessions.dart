import 'package:coupler_app/feature_GetAcquainted/models/get-acquainted-current-session.dart';
import 'package:coupler_app/feature_GetAcquainted/models/get_acquainted_previous_sessions.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../feature_Auth/getx_controllers/couple_controller.dart';
import '../../feature_Auth/getx_controllers/user_controller.dart';
import '../getxControllers/GetAcquaintedSessionSurveyController.dart';

class GetAcquaintedSessions {
  final UserController userController = Get.find();
  final CoupleController coupleController = Get.find();
  final GetAcquaintedSessionSurveyController
      getAcquaintedSessionSurveyController = Get.find();

  Future<List<GetAcquaintedPreviousSessions>> getPreviousSessions() async {
    try {
      final response = await Supabase.instance.client.functions
          .invoke('get-acquainted/get-acquainted-previous-sessions', headers: {
        'Authorization': 'Bearer ${userController.user.value.accessToken}'
      }, body: {
        "coupleId": coupleController.couple.value.id,
        "userId": userController.user.value.id
      });

      final data = await response.data;

      if (data['isRequestSuccessfull'] == true) {
        List<GetAcquaintedPreviousSessions> previousSessions =
            (data['data'] as List)
                .map((e) => GetAcquaintedPreviousSessions.fromJson(e))
                .toList();

        return previousSessions;
      } else {
        return [];
      }
    } catch (err) {
      print('Previous Theme Error');
      print(err);
      return [];
    }
  }

  Future<GetAcquaintedCurrentSession?> getCurrentSession() async {
    try {
      final response = await Supabase.instance.client.functions
          .invoke('get-acquainted/get-acquainted-current-session', headers: {
        'Authorization': 'Bearer ${userController.user.value.accessToken}'
      }, body: {
        "coupleId": coupleController.couple.value.id,
        "userId": userController.user.value.id
      });

      final data = await response.data;

      if (data['isRequestSuccessfull'] == true) {
        List<GetAcquaintedCurrentSession> nextTheme = (data['data'] as List)
            .map((e) => GetAcquaintedCurrentSession.fromJson(e))
            .toList();

        return nextTheme.first;
      } else {
        return null;
      }
    } catch (err) {
      print('Current Theme Error');
      print(err);
      return null;
    }
  }

  Future<GetAcquaintedCurrentSession?> endSession() async {
    try {
      final response = await Supabase.instance.client.functions
          .invoke('get-acquainted/update-acquainted-session', headers: {
        'Authorization': 'Bearer ${userController.user.value.accessToken}'
      }, body: {
        "coupleId": coupleController.couple.value.id,
        "userId": userController.user.value.id,
        "sessionId": getAcquaintedSessionSurveyController
            .sessionSurvey.value!.acquaintedSessionId,
      });

      final data = await response.data;

      if (data['isRequestSuccessfull'] == true) {
        List<GetAcquaintedCurrentSession> nextTheme = (data['data'] as List)
            .map((e) => GetAcquaintedCurrentSession.fromJson(e))
            .toList();

        return nextTheme.first;
      } else {
        return null;
      }
    } catch (err) {
      print('End Theme Error');
      print(err);
      return null;
    }
  }

  Future<void> createSession(questionId) async {
    try {
      final response = await Supabase.instance.client.functions
          .invoke('get-acquainted/create-acquainted-session', headers: {
        'Authorization': 'Bearer ${userController.user.value.accessToken}'
      }, body: {
        "coupleId": coupleController.couple.value.id,
        "questionId": questionId,
      });

      final data = await response.data;

      if (data['isRequestSuccessfull'] == true) {
        List<GetAcquaintedCurrentSession> nextTheme = (data['data'] as List)
            .map((e) => GetAcquaintedCurrentSession.fromJson(e))
            .toList();
      }
    } catch (err) {
      print('Create Theme Error');
      print(err);
    }
  }
}
