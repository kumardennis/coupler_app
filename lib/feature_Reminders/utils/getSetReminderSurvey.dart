import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../feature_Auth/getx_controllers/couple_controller.dart';
import '../../feature_Auth/getx_controllers/user_controller.dart';
import '../models/CoupleReminderNeeds.dart';
import '../models/CoupleReminderSurvey.dart';

class GetSetReminderSurvey {
  final UserController userController = Get.find();
  final CoupleController coupleController = Get.find();

  Future<List<CoupleReminderSurvey>?> getReminderSurveyScores(
      [int? userId]) async {
    try {
      final response = await Supabase.instance.client.functions
          .invoke('reminders/get-reminder-survey-scores', headers: {
        'Authorization': 'Bearer ${userController.user.value.accessToken}'
      }, body: {
        "coupleId": coupleController.couple.value.id,
        "userId": userId ?? userController.user.value.id
      });

      final data = await response.data;

      if (data['isRequestSuccessfull'] == true) {
        List<CoupleReminderSurvey> reminderSurvey = (data['data'] as List)
            .map((e) => CoupleReminderSurvey.fromJson(e))
            .toList();

        print(reminderSurvey);

        return reminderSurvey;
      } else {
        Get.snackbar('Oops..', data['error'].toString());
        return null;
      }
    } catch (err) {
      debugPrint(err.toString());
    }
  }

  Future<void> setReminderSurveyScore(score) async {
    try {
      final response = await Supabase.instance.client.functions
          .invoke('reminders/create-reminder-survey-score', headers: {
        'Authorization': 'Bearer ${userController.user.value.accessToken}'
      }, body: {
        "coupleId": coupleController.couple.value.id,
        "userId": userController.user.value.id,
        "score": score.value,
      });

      final data = await response.data;

      if (data['isRequestSuccessfull']) {
      } else {
        Get.snackbar('Oops..', data['error'].toString());
      }
    } catch (err) {
      debugPrint(err.toString());
    }
  }
}
