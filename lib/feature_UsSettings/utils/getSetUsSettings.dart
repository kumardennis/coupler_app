import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../feature_Auth/getx_controllers/couple_controller.dart';
import '../../feature_Auth/getx_controllers/user_controller.dart';
import '../models/special_dates.dart';

class UsSettingsHelper {
  final CoupleController coupleController = Get.find();
  final UserController userController = Get.find();

  Future<List<SpecialDates>> getSpecialDates() async {
    try {
      final response = await Supabase.instance.client.functions
          .invoke('auth-and-settings/get-couple-special-dates', headers: {
        'Authorization': 'Bearer ${userController.user.value.accessToken}'
      }, body: {
        "coupleId": coupleController.couple.value.id,
      });

      final data = await response.data;

      if (data['isRequestSuccessfull'] == true) {
        List<SpecialDates> dates = (data['data'] as List)
            .map((e) => SpecialDates.fromJson(e))
            .toList();

        print(dates);

        return dates;
      } else {
        Get.snackbar('Oops..', data['error'].toString());
        return [];
      }
    } catch (err) {
      debugPrint(err.toString());
      Get.snackbar('Oops..', err.toString());
      return [];
    }
  }

  Future<void> setSpecialDates(date, description) async {
    try {
      final response = await Supabase.instance.client.functions
          .invoke('auth-and-settings/create-couple-special-date', headers: {
        'Authorization': 'Bearer ${userController.user.value.accessToken}'
      }, body: {
        "coupleId": coupleController.couple.value.id,
        "dateDescription": description,
        "date": DateFormat('yyyy-MM-dd').format(date)
      });

      final data = await response.data;

      if (data['isRequestSuccessfull'] == true) {
        List<SpecialDates> dates = (data['data'] as List)
            .map((e) => SpecialDates.fromJson(e))
            .toList();

        print(dates);
      } else {
        Get.snackbar('Oops..', data['error'].toString());
      }
    } catch (err) {
      debugPrint(err.toString());
      Get.snackbar('Oops..', err.toString());
    }
  }

  Future<void> setAppearanceSettings(darkMode, blueAccent) async {
    try {
      final response = await Supabase.instance.client.functions
          .invoke('auth-and-settings/update-user-settings', headers: {
        'Authorization': 'Bearer ${userController.user.value.accessToken}'
      }, body: {
        "userId": userController.user.value.id,
        "darkMode": darkMode,
        "blueAccent": blueAccent
      });

      final data = await response.data;

      if (data['isRequestSuccessfull'] == true) {
        Get.snackbar('Success', 'Updated!');
      } else {
        Get.snackbar('Oops..', data['error'].toString());
      }
    } catch (err) {
      debugPrint(err.toString());
      Get.snackbar('Oops..', err.toString());
    }
  }
}
