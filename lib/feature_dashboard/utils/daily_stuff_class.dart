import 'package:coupler_app/feature_Auth/getx_controllers/couple_controller.dart';
import 'package:coupler_app/feature_Auth/getx_controllers/user_controller.dart';
import 'package:coupler_app/feature_dashboard/models/answered_daily_question_model.dart';
import 'package:coupler_app/feature_dashboard/models/daily_question_model.dart';
import 'package:coupler_app/feature_dashboard/models/daily_quote_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DailyStuffClass {
  UserController userController = Get.find();
  CoupleController coupleController = Get.find();

  Future<DailyQuoteModel?> getDailyQuote(accessToken) async {
    try {
      final response = await Supabase.instance.client.functions.invoke(
          'daily-stuff/get-daily-quote',
          headers: {'Authorization': 'Bearer $accessToken'},
          body: {"userId": userController.user.value.id});

      final data = await response.data;

      if (data['isRequestSuccessfull'] == true) {
        List<DailyQuoteModel> dailyQuote = (data['data'] as List)
            .map((e) => DailyQuoteModel.fromJson(e))
            .toList();

        return dailyQuote.first;
      } else {
        Get.snackbar('Oops..', data['error'].toString());
        return null;
      }
    } catch (err) {
      debugPrint(err.toString());
    }
    return null;
  }

  Future<DailyQuestionModel?> getDailyQuestion(accessToken,
      [int? questionId]) async {
    try {
      final response = await Supabase.instance.client.functions.invoke(
          'daily-stuff/get-daily-question',
          headers: {'Authorization': 'Bearer $accessToken'},
          body: {"userId": userController.user.value.id});

      final data = await response.data;

      if (data['isRequestSuccessfull'] == true) {
        List<DailyQuestionModel> dailyQuestion = (data['data'] as List)
            .map((e) => DailyQuestionModel.fromJson(e))
            .toList();

        return dailyQuestion.first;
      } else {
        Get.snackbar('Oops..', data['error'].toString());
        return null;
      }
    } catch (err) {
      debugPrint(err.toString());
    }
    return null;
  }

  Future<AnsweredDailyQuestionModel?> getAnsweredDailyQuestion(
      accessToken, questionId) async {
    try {
      final response = await Supabase.instance.client.functions
          .invoke('daily-stuff/get-answered-daily-questions', headers: {
        'Authorization': 'Bearer $accessToken'
      }, body: {
        "userId": userController.user.value.id,
        "coupleId": coupleController.couple.value.id,
        "questionId": questionId
      });

      final data = response.data;

      if (data['isRequestSuccessfull'] == true) {
        List<AnsweredDailyQuestionModel> dailyQuestion = (data['data'] as List)
            .map((e) => AnsweredDailyQuestionModel.fromJson(e))
            .toList();

        return dailyQuestion.first;
      } else {
        Get.snackbar('Oops..', data['error'].toString());
        return null;
      }
    } catch (err) {
      debugPrint(err.toString());
      err.printInfo();
    }
    return null;
  }

  Future<List<AnsweredDailyQuestionModel>> getAllAnsweredDailyQuestions(
      accessToken) async {
    try {
      final response = await Supabase.instance.client.functions
          .invoke('daily-stuff/get-answered-daily-questions', headers: {
        'Authorization': 'Bearer $accessToken'
      }, body: {
        "userId": userController.user.value.id,
        "coupleId": coupleController.couple.value.id,
      });

      final data = response.data;

      if (data['isRequestSuccessfull'] == true) {
        List<AnsweredDailyQuestionModel> dailyQuestion = (data['data'] as List)
            .map((e) => AnsweredDailyQuestionModel.fromJson(e))
            .toList();

        return dailyQuestion;
      } else {
        Get.snackbar('Oops..', data['error'].toString());
        return [];
      }
    } catch (err) {
      debugPrint(err.toString());
      err.printInfo();
    }
    return [];
  }

  Future<void> createAnsweredDailyQuestion(
      accessToken, questionId, selectedAnswer) async {
    try {
      final response = await Supabase.instance.client.functions
          .invoke('daily-stuff/create-answered-daily-question', headers: {
        'Authorization': 'Bearer $accessToken'
      }, body: {
        "userId": userController.user.value.id,
        "coupleId": coupleController.couple.value.id,
        "dailyQuestionId": questionId,
        "selectedAnswer": selectedAnswer
      });

      final data = response.data;

      if (data['isRequestSuccessfull'] == true) {
        Get.snackbar('Success..',
            'Answer saved! Your partner will see only when they answer');
      } else {
        Get.snackbar('Oops..', data['error'].toString());
      }
    } catch (err) {
      debugPrint(err.toString());
      err.printInfo();
    }
  }
}
