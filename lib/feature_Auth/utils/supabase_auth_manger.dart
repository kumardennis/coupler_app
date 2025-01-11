import 'dart:convert';

import 'package:coupler_app/feature_Auth/models/couple_model.dart';
import 'package:coupler_app/feature_UsSettings/models/user_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../feature_UsSettings/getXControllers/user_settings_controller.dart';
import '../getx_controllers/couple_controller.dart';
import '../getx_controllers/user_controller.dart';
import '../models/user_model.dart';

// const String supabaseUrl = 'http://192.168.196.67:64321';
const String supabaseRemoteUrl = 'https://vpofopxljvcsghhtmeup.supabase.co';
const String supabaseUrl = 'http://localhost:34321';
final String anonKey = dotenv.env['SUPABASE_LOCAL_ANON_KEY'] ?? '';

JsonEncoder encoder = const JsonEncoder.withIndent('  ');

class SupabaseAuthManger {
  final supabseClient = SupabaseClient(supabaseUrl, anonKey);
  final userController = Get.put(UserController());
  final coupleController = Get.put(CoupleController());
  final userSettingController = Get.put(UserSettingsController());

  Future<void> loadFreshUser(userId, accessToken) async {
    final tokenToUse = accessToken;

    print('TOKEN IN USE: $tokenToUse');

    final userRecordResponse =
        await supabseClient.from('users').select('*').eq('userUid', userId);

    final userProfileClassed = UserModel(
        userRecordResponse[0]['id'],
        userRecordResponse[0]['created_at'],
        userRecordResponse[0]['firstName'],
        userRecordResponse[0]['lastName'],
        userRecordResponse[0]['name'],
        userRecordResponse[0]['profileImage'],
        userRecordResponse[0]['userUid'],
        null,
        null,
        tokenToUse,
        userRecordResponse[0]['shareableUuid']);

    userController.loadUser(userProfileClassed);

    final userSettingsResponse = await supabseClient
        .from('user_settings')
        .select('darkMode, blueAccent')
        .eq('userId', userProfileClassed.id);

    if (userSettingsResponse.toString() != '[]') {
      userSettingController.loadUser(UserSettings(
          darkMode: userSettingsResponse[0]['darkMode'],
          blueAccent: userSettingsResponse[0]['blueAccent']));
    }

    final coupleResponse = await Supabase.instance.client.functions.invoke(
        'auth-and-settings/get-couple',
        headers: {'Authorization': 'Bearer ${tokenToUse}'},
        body: {"userId": userRecordResponse[0]['id']});

    final data = await coupleResponse.data;

    if (data['error'] != null) {
      print('TEST');
      Get.snackbar('Oops..', data['error'].toString());
    }

    if (data['data'].toString() == '[]') {
      coupleController.changeCoupleExists(false);
    } else {
      CoupleModel couplesData = (data['data'] as List)
          .map((e) => CoupleModel.fromJson(e, userRecordResponse[0]['id']))
          .toList()
          .first;

      coupleController.loadCouple(couplesData);
      coupleController.changeCoupleExists(true);
    }
  }

  Future<void> signOut(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();

    await supabseClient.auth.signOut();

    prefs.remove('password');
  }

  Future<void> signIn(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();

    prefs.setString('email', email);
    prefs.setString('password', password);

    print('Repsonse ${email}');

    try {
      final AuthResponse response = await supabseClient.auth
          .signInWithPassword(password: password, email: email);

      final session = response.session;
      final user = response.user;

      print('Repsonse ${response.user}');

      if (session != null) {
        await loadFreshUser(user!.id, session.accessToken);

        prefs.setString('email', email);
        prefs.setString('password', password);

        Get.toNamed('/home-screen');

        // final userRecord = userRecordResponse
      }
    } catch (err) {
      debugPrint(err.toString());
    }
  }

  Future<void> signUp(
      String email, String password, String firstName, String lastName) async {
    final prefs = await SharedPreferences.getInstance();

    prefs.setString('email', email);
    prefs.setString('password', password);

    try {
      final response = await Supabase.instance.client.functions
          .invoke('auth-and-settings/create-user', headers: {}, body: {
        "email": email,
        "password": password,
        "firstName": firstName,
        "lastName": lastName
      });

      Get.toNamed('/sign-in');
    } catch (err) {
      debugPrint(err.toString());
    }
  }

  Future<void> signInWithFacebook() async {
    final prefs = await SharedPreferences.getInstance();

    try {
      final bool response = await supabseClient.auth.signInWithOAuth(
          Provider.facebook,
          redirectTo:
              'https://vpofopxljvcsghhtmeup.supabase.co/auth/v1/callback');

      final session = supabseClient.auth.currentSession;
      final user = supabseClient.auth.currentUser;

      if (session != null) {
        final userRecordResponse = await supabseClient
            .from('users')
            .select('*')
            .eq('userUid', user!.id);

        final userProfile = {
          ...userRecordResponse[0],
          'phone': user.phone,
          'email': user.email
        };

        final userProfileClassed = UserModel(
            userRecordResponse[0]['id'],
            userRecordResponse[0]['created_at'],
            userRecordResponse[0]['firstName'],
            userRecordResponse[0]['lastName'],
            userRecordResponse[0]['name'],
            userRecordResponse[0]['profileImage'],
            userRecordResponse[0]['userId'],
            user.email,
            user.phone,
            session.accessToken,
            userRecordResponse[0]['shareableUuid']);

        userController.loadUser(userProfileClassed);

        // debugPrint(prettyprintSession);

        // String prettyPrintUser = encoder.convert(userProfileClassed);

        // debugPrint(session.accessToken);

        Get.toNamed('/home-screen');

        // final userRecord = userRecordResponse
      }
    } catch (err) {
      debugPrint(err.toString());
    }
  }

  Future<void> getUserSettings(userId, accessToken) async {
    try {
      final userSettingsResponse = await supabseClient
          .from('user_settings')
          .select('darkMode, blueAccent')
          .eq('userId', userId);

      print(userSettingsResponse);

      userSettingController.loadUser(UserSettings(
          darkMode: userSettingsResponse[0]['darkMode'],
          blueAccent: userSettingsResponse[0]['blueAccent']));

      if (userSettingsResponse.data['error'] != null) {
        print('TEST');
        Get.snackbar('Oops..', userSettingsResponse.data['error'].toString());
      }
    } catch (err) {
      debugPrint(err.toString());
    }
  }
}
