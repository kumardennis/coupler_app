class DailyQuestionModel {
  DailyQuestionModel({
    required this.id,
    required this.createdAt,
    required this.question,
    required this.option1,
    required this.option2,
    required this.option3,
    required this.option4,
  });
  late final int id;
  late final String createdAt;
  late final Question question;
  late final Option option1;
  late final Option option2;
  late final Option option3;
  late final Option option4;

  DailyQuestionModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    question = Question.fromJson(json['question']);
    option1 = Option.fromJson(json['option1']);
    option2 = Option.fromJson(json['option2']);
    option3 = Option.fromJson(json['option3']);
    option4 = Option.fromJson(json['option4']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['created_at'] = createdAt;
    _data['question'] = question.toJson();
    _data['option1'] = option1.toJson();
    _data['option2'] = option2.toJson();
    _data['option3'] = option3.toJson();
    _data['option4'] = option4.toJson();
    return _data;
  }
}

class Question {
  Question({
    required this.id,
    required this.createdAt,
    required this.originalText,
    required this.originalLocaleId,
    this.et,
    required this.translations,
  });
  late final int id;
  late final String createdAt;
  late final String originalText;
  late final int originalLocaleId;
  late final String? et;
  late final List<dynamic> translations;

  Question.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    originalText = json['originalText'];
    originalLocaleId = json['originalLocaleId'];
    et = json['et'];
    translations = List.castFrom<dynamic, dynamic>(json['translations']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['created_at'] = createdAt;
    _data['originalText'] = originalText;
    _data['originalLocaleId'] = originalLocaleId;
    _data['et'] = et;
    _data['translations'] = translations;
    return _data;
  }
}

class Option {
  Option({
    required this.id,
    required this.createdAt,
    required this.originalText,
    required this.originalLocaleId,
    this.et,
    required this.translations,
  });
  late final int id;
  late final String createdAt;
  late final String originalText;
  late final int originalLocaleId;
  late final String? et;
  late final List<dynamic> translations;

  Option.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    originalText = json['originalText'];
    originalLocaleId = json['originalLocaleId'];
    et = json['et'];
    translations = List.castFrom<dynamic, dynamic>(json['translations']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['created_at'] = createdAt;
    _data['originalText'] = originalText;
    _data['originalLocaleId'] = originalLocaleId;
    _data['et'] = et;
    _data['translations'] = translations;
    return _data;
  }
}
