class GetAcquaintedSessionSurvey {
  GetAcquaintedSessionSurvey({
    required this.id,
    required this.createdAt,
    required this.acquaintedSurveyId,
    required this.acquaintedSessionId,
    required this.willMeStart,
    required this.speakingDone,
    required this.assessingDone,
    required this.acquaintedSurveys,
  });
  late final int id;
  late final String createdAt;
  late final int acquaintedSurveyId;
  late final int acquaintedSessionId;
  late final bool willMeStart;
  late final bool speakingDone;
  late final bool assessingDone;
  late final AcquaintedSurveys acquaintedSurveys;

  GetAcquaintedSessionSurvey.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    acquaintedSurveyId = json['acquaintedSurveyId'];
    acquaintedSessionId = json['acquaintedSessionId'];
    willMeStart = json['willMeStart'];
    speakingDone = json['speakingDone'];
    assessingDone = json['assessingDone'];
    acquaintedSurveys = AcquaintedSurveys.fromJson(json['acquainted_surveys']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['created_at'] = createdAt;
    _data['acquaintedSurveyId'] = acquaintedSurveyId;
    _data['acquaintedSessionId'] = acquaintedSessionId;
    _data['willMeStart'] = willMeStart;
    _data['speakingDone'] = speakingDone;
    _data['assessingDone'] = assessingDone;
    _data['acquainted_surveys'] = acquaintedSurveys.toJson();
    return _data;
  }
}

class AcquaintedSurveys {
  AcquaintedSurveys({
    required this.id,
    required this.createdAt,
    this.predictedScore,
    this.score,
    required this.coupleId,
    required this.userId,
    required this.acquaintedSessionId,
  });
  late final int id;
  late final String createdAt;
  late final int? predictedScore;
  late final int? score;
  late final int coupleId;
  late final int userId;
  late final int acquaintedSessionId;

  AcquaintedSurveys.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    predictedScore = json['predictedScore'];
    score = json['score'];
    coupleId = json['coupleId'];
    userId = json['userId'];
    acquaintedSessionId = json['acquaintedSessionId'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['created_at'] = createdAt;
    _data['predictedScore'] = predictedScore;
    _data['score'] = score;
    _data['coupleId'] = coupleId;
    _data['userId'] = userId;
    _data['acquaintedSessionId'] = acquaintedSessionId;
    return _data;
  }
}
