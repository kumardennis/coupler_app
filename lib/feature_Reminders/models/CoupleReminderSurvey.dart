class CoupleReminderSurvey {
  CoupleReminderSurvey({
    required this.id,
    required this.score,
  });
  late final int id;
  late final int score;

  CoupleReminderSurvey.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    score = json['score'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['score'] = score;
    return _data;
  }
}
