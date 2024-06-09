import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../feature_Auth/getx_controllers/couple_controller.dart';
import '../../feature_Auth/getx_controllers/user_controller.dart';
import '../../feature_Auth/utils/supabase_auth_manger.dart';
import '../../feature_GetAcquainted/getxControllers/GetAcquaintedSessionSurveyController.dart';
import '../../feature_GetAcquainted/utils/get_acquainted_sessions.dart';

class CoupleManagement {
  final UserController userController = Get.find();
  final CoupleController coupleController = Get.find();
  final GetAcquaintedSessionSurveyController
      getAcquaintedSessionSurveyController =
      Get.put(GetAcquaintedSessionSurveyController());

  final getAcquaintedSessions = GetAcquaintedSessions();

  Future<void> sendInvite(String partnersUuid) async {
    try {
      final response = await Supabase.instance.client.functions
          .invoke('auth-and-settings/create-couple', headers: {
        'Authorization': 'Bearer ${userController.user.value.accessToken}'
      }, body: {
        // "coupleId": coupleController.couple.value.id,
        "partnerShareableUuid": partnersUuid,
        "userId": userController.user.value.id
      });

      final data = await response.data;

      if (data['isRequestSuccessfull'] == true) {
        Get.snackbar('Great!', 'inf_InvitationSent'.tr);
        await SupabaseAuthManger().loadFreshUser(
            userController.user.value.userId,
            userController.user.value.accessToken);
      } else {
        Get.snackbar('Oops..', data['error'].toString());
      }
    } catch (err) {
      debugPrint(err.toString());
      Get.snackbar('Oops..', err.toString());
    }
  }

  Future<void> acceptInvite() async {
    try {
      final response = await Supabase.instance.client.functions
          .invoke('auth-and-settings/accept-couple', headers: {
        'Authorization': 'Bearer ${userController.user.value.accessToken}'
      }, body: {
        "coupleId": coupleController.couple.value.id,
        "userId": userController.user.value.id
      });

      final data = await response.data;

      if (data['isRequestSuccessfull'] == true) {
        Get.snackbar('Great!', 'inf_CoupleCreated'.tr);

        await getAcquaintedSessions.createSession(1);

        await SupabaseAuthManger().loadFreshUser(
            userController.user.value.userId,
            userController.user.value.accessToken);

        Get.snackbar('NEW!', 'inf_NewThemeAvailable'.tr);
      } else {
        Get.snackbar('Oops..', data['error'].toString());
      }
    } catch (err) {
      debugPrint(err.toString());
      Get.snackbar('Oops..', err.toString());
    }
  }
}
