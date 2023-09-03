class GetAcquaintedPreviousSessions {
  GetAcquaintedPreviousSessions({
    required this.acquaintedSessions,
    required this.acquaintedSurveys1,
    required this.acquaintedSurveys2,
  });
  late final AcquaintedSessions acquaintedSessions;
  late final AcquaintedSurveys1 acquaintedSurveys1;
  late final AcquaintedSurveys2 acquaintedSurveys2;

  GetAcquaintedPreviousSessions.fromJson(Map<String, dynamic> json) {
    acquaintedSessions =
        AcquaintedSessions.fromJson(json['acquainted_sessions']);
    acquaintedSurveys1 =
        AcquaintedSurveys1.fromJson(json['acquainted_surveys1']);
    acquaintedSurveys2 =
        AcquaintedSurveys2.fromJson(json['acquainted_surveys2']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['acquainted_sessions'] = acquaintedSessions.toJson();
    _data['acquainted_surveys1'] = acquaintedSurveys1.toJson();
    _data['acquainted_surveys2'] = acquaintedSurveys2.toJson();
    return _data;
  }
}

class AcquaintedSessions {
  AcquaintedSessions({
    required this.id,
    required this.createdAt,
    required this.coupleId,
    required this.bothPartnersJoined,
    required this.startTime,
    this.endTime,
    required this.acquaintedQuestionId,
    this.whoWillStart,
    required this.hasEnded,
    required this.acquaintedQuestions,
  });
  late final int id;
  late final String createdAt;
  late final int coupleId;
  late final bool bothPartnersJoined;
  late final String startTime;
  late final String? endTime;
  late final int acquaintedQuestionId;
  late final bool? whoWillStart;
  late final bool hasEnded;
  late final AcquaintedQuestions acquaintedQuestions;

  AcquaintedSessions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    coupleId = json['coupleId'];
    bothPartnersJoined = json['bothPartnersJoined'];
    startTime = json['startTime'];
    hasEnded = json['hasEnded'];
    endTime = json['startTime'];

    acquaintedQuestionId = json['acquaintedQuestionId'];
    whoWillStart = json['whoWillStart'];

    acquaintedQuestions =
        AcquaintedQuestions.fromJson(json['acquainted_questions']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['created_at'] = createdAt;
    _data['coupleId'] = coupleId;
    _data['bothPartnersJoined'] = bothPartnersJoined;
    _data['startTime'] = startTime;
    _data['endTime'] = endTime;
    _data['acquaintedQuestionId'] = acquaintedQuestionId;
    _data['whoWillStart'] = whoWillStart;
    _data['acquainted_questions'] = acquaintedQuestions.toJson();
    return _data;
  }
}

class AcquaintedQuestions {
  AcquaintedQuestions({
    required this.id,
    required this.createdAt,
    required this.question,
    required this.textContentId,
    required this.textContent,
  });
  late final int id;
  late final String createdAt;
  late final String question;
  late final int textContentId;
  late final TextContent textContent;

  AcquaintedQuestions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    question = json['question'];
    textContentId = json['textContentId'];
    textContent = TextContent.fromJson(json['text_content']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['created_at'] = createdAt;
    _data['question'] = question;
    _data['textContentId'] = textContentId;
    _data['text_content'] = textContent.toJson();
    return _data;
  }
}

class TextContent {
  TextContent({
    required this.id,
    required this.createdAt,
    required this.originalText,
    required this.originalLocaleId,
    required this.translations,
  });
  late final int id;
  late final String createdAt;
  late final String originalText;
  late final int originalLocaleId;
  late final List<Translations> translations;

  TextContent.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    originalText = json['originalText'];
    originalLocaleId = json['originalLocaleId'];
    translations = List.from(json['translations'])
        .map((e) => Translations.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['created_at'] = createdAt;
    _data['originalText'] = originalText;
    _data['originalLocaleId'] = originalLocaleId;
    _data['translations'] = translations.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Translations {
  Translations({
    required this.id,
    required this.createdAt,
    required this.textContentId,
    required this.localeId,
    required this.translation,
  });
  late final int id;
  late final String createdAt;
  late final int textContentId;
  late final int localeId;
  late final String translation;

  Translations.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    textContentId = json['textContentId'];
    localeId = json['localeId'];
    translation = json['translation'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['created_at'] = createdAt;
    _data['textContentId'] = textContentId;
    _data['localeId'] = localeId;
    _data['translation'] = translation;
    return _data;
  }
}

class AcquaintedSurveys1 {
  AcquaintedSurveys1({
    required this.id,
    this.predictedScore,
    this.score,
    required this.createdAt,
    required this.coupleId,
    required this.users,
  });
  late final int id;
  late final int? predictedScore;
  late final int? score;
  late final String createdAt;
  late final int coupleId;
  late final Users users;

  AcquaintedSurveys1.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    score = json['score'];
    predictedScore = json['predictedScore'];
    createdAt = json['created_at'];
    coupleId = json['coupleId'];
    users = Users.fromJson(json['users']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['score'] = score;
    _data['predictedScore'] = predictedScore;
    _data['created_at'] = createdAt;
    _data['coupleId'] = coupleId;
    _data['users'] = users.toJson();
    return _data;
  }
}

class Users {
  Users({
    required this.id,
    required this.name,
    required this.firstName,
    required this.lastName,
    this.profileImage,
  });
  late final int id;
  late final String name;
  late final String firstName;
  late final String lastName;
  late final String? profileImage;

  Users.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    profileImage = json['profileImage'];
    ;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['firstName'] = firstName;
    _data['lastName'] = lastName;
    _data['profileImage'] = profileImage;
    return _data;
  }
}

class AcquaintedSurveys2 {
  AcquaintedSurveys2({
    required this.id,
    this.predictedScore,
    this.score,
    required this.createdAt,
    required this.coupleId,
    required this.users,
  });
  late final int id;
  late final int? predictedScore;
  late final int? score;
  late final String createdAt;
  late final int coupleId;
  late final Users users;

  AcquaintedSurveys2.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    score = json['score'];
    predictedScore = json['predictedScore'];
    createdAt = json['created_at'];
    coupleId = json['coupleId'];
    users = Users.fromJson(json['users']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['score'] = score;
    _data['predictedScore'] = predictedScore;
    _data['created_at'] = createdAt;
    _data['coupleId'] = coupleId;
    _data['users'] = users.toJson();
    return _data;
  }
}
