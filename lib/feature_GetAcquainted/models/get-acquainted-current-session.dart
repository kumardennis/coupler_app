class GetAcquaintedCurrentSession {
  GetAcquaintedCurrentSession({
    required this.id,
    required this.createdAt,
    required this.coupleId,
    required this.bothPartnersJoined,
    required this.startTime,
    this.endTime,
    required this.acquaintedQuestionId,
    this.whoWillStart,
    required this.hasStarted,
    required this.hasEnded,
    required this.acquaintedQuestions,
  });
  late final int id;
  late final String createdAt;
  late final int coupleId;
  late final bool bothPartnersJoined;
  late final String startTime;
  late final String? endTime;
  late final String availableSince;
  late final int acquaintedQuestionId;
  late final bool? whoWillStart;
  late final bool hasEnded;
  late final bool hasStarted;
  late final AcquaintedQuestions acquaintedQuestions;

  GetAcquaintedCurrentSession.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    availableSince = json['availableSince'];
    coupleId = json['coupleId'];
    bothPartnersJoined = json['bothPartnersJoined'];
    startTime = json['startTime'];
    hasEnded = json['hasEnded'];
    hasStarted = json['hasStarted'];
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
