import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../feature_Auth/getx_controllers/couple_controller.dart';
import '../../feature_Auth/getx_controllers/user_controller.dart';
import '../models/CoupleReminderNeeds.dart';

class GetSetReminderNeeds {
  final UserController userController = Get.find();
  final CoupleController coupleController = Get.find();

  Future<List<CoupleReminderNeeds>?> getReminderNeeds([reminderNeedId]) async {
    try {
      final response = await Supabase.instance.client.functions
          .invoke('reminders/get-reminder-couple-needs', headers: {
        'Authorization': 'Bearer ${userController.user.value.accessToken}'
      }, body: {
        "coupleId": coupleController.couple.value.id,
        "reminderNeedId": reminderNeedId,
        "userId": userController.user.value.id
      });

      final data = await response.data;

      if (data['isRequestSuccessfull'] == true) {
        List<CoupleReminderNeeds> reminderNeeds = (data['data'] as List)
            .map((e) => CoupleReminderNeeds.fromJson(e))
            .toList();

        print(reminderNeedId);

        return reminderNeeds;
      } else {
        Get.snackbar('Oops..', data['error'].toString());
        return null;
      }
    } catch (err) {
      debugPrint(err.toString());
    }
    return null;
  }

  Future<void> setReminderNeeds(reminderNeedId, frequency, timePeriod) async {
    try {
      final response = await Supabase.instance.client.functions
          .invoke('reminders/upsert-reminder-couple-needs', headers: {
        'Authorization': 'Bearer ${userController.user.value.accessToken}'
      }, body: {
        "coupleId": coupleController.couple.value.id,
        "reminderNeedId": reminderNeedId,
        "userId": userController.user.value.id,
        "frequency": frequency.value,
        "timePeriodInDays": timePeriod.value
      });

      final data = await response.data;

      if (data['isRequestSuccessfull']) {
        CoupleReminderNeeds reminderNeeds = (data['data'] as List)
            .map((e) => CoupleReminderNeeds.fromJson(e))
            .toList()
            .first;

        print(reminderNeedId);
      } else {
        Get.snackbar('Oops..', data['error'].toString());
      }
    } catch (err) {
      debugPrint(err.toString());
    }
  }

  Future<List<CoupleReminderNeeds>?> getAverageReminderNeeds() async {
    try {
      final partner1Response = await Supabase.instance.client.functions
          .invoke('reminders/get-reminder-couple-needs', headers: {
        'Authorization': 'Bearer ${userController.user.value.accessToken}'
      }, body: {
        "coupleId": coupleController.couple.value.id,
        "userId": userController.user.value.id
      });

      final data1 = await partner1Response.data;

      final partner2Response = await Supabase.instance.client.functions
          .invoke('reminders/get-reminder-couple-needs', headers: {
        'Authorization': 'Bearer ${userController.user.value.accessToken}'
      }, body: {
        "coupleId": coupleController.couple.value.id,
        "userId": coupleController.couple.value.partner2!.id
      });

      final data2 = await partner2Response.data;

      if (data1['isRequestSuccessfull'] && data2['isRequestSuccessfull']) {
        List<CoupleReminderNeeds> reminderNeeds1 = (data1['data'] as List)
            .map((e) => CoupleReminderNeeds.fromJson(e))
            .toList();

        List<CoupleReminderNeeds> reminderNeeds2 = (data2['data'] as List)
            .map((e) => CoupleReminderNeeds.fromJson(e))
            .toList();

        List<CoupleReminderNeeds> reminderNeedsAvg = [...reminderNeeds1];

        for (int i = 0; i <= 8; i++) {
          int partnersFrequency = reminderNeeds1[i].frequency;
          int partnersTimePeriod = reminderNeeds1[i].timePeriodInDays;

          if (reminderNeeds1.length == reminderNeeds2.length &&
              reminderNeeds1[i].reminderNeeds.reminderText ==
                  reminderNeeds2[i].reminderNeeds.reminderText) {
            partnersFrequency = reminderNeeds2[i].frequency;
            partnersTimePeriod = reminderNeeds2[i].timePeriodInDays;
          }

          double partner1PerDayNeed =
              reminderNeeds1[i].frequency / reminderNeeds1[i].timePeriodInDays;

          double partner2PerDayNeed = partnersFrequency / partnersTimePeriod;

          double couplePerDayNeed =
              (partner1PerDayNeed + partner2PerDayNeed) / 2;

          int coupleTimePeriod = 1;

          if (couplePerDayNeed < 0.5 && coupleTimePeriod == 1) {
            couplePerDayNeed = couplePerDayNeed * 7;
            coupleTimePeriod = 7;
          }

          if (couplePerDayNeed < 0.5 && coupleTimePeriod == 7) {
            couplePerDayNeed = couplePerDayNeed * 4;
            coupleTimePeriod = 30;
          }

          reminderNeedsAvg[i].frequency = couplePerDayNeed.round();
          reminderNeedsAvg[i].timePeriodInDays = coupleTimePeriod;
        }

        return reminderNeedsAvg;
      } else {
        Get.snackbar('Oops..', data1['error'].toString());
        return null;
      }
    } catch (err) {
      debugPrint(err.toString());
    }
    return null;
  }
}
