import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../getx_controllers/user_controller.dart';
import '../models/user_model.dart';

const String supabaseUrl = 'http://localhost:54321';
final String anonKey = dotenv.env['SUPABASE_LOCAL_ANON_KEY'] ?? '';

JsonEncoder encoder = const JsonEncoder.withIndent('  ');

class SupabaseAuthManger {
  final supabseClient = SupabaseClient(supabaseUrl, anonKey);
  final userController = Get.put(UserController());

  Future<void> signOut(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();

    await supabseClient.auth.signOut();

    prefs.remove('password');
  }

  Future<void> signIn(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();

    prefs.setString('email', email);
    prefs.setString('password', password);

    try {
      final AuthResponse response = await supabseClient.auth
          .signInWithPassword(password: password, email: email);

      final session = response.session;
      final user = response.user;

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
            userRecordResponse[0]['userUid'],
            user.email,
            user.phone,
            session.accessToken);

        userController.loadUser(userProfileClassed);

        prefs.setString('email', email);
        prefs.setString('password', password);

        String prettyprintSession = encoder.convert(response.session?.toJson());

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
            session.accessToken);

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
}
