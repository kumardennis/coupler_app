class CoupleReminderSurvey {
  CoupleReminderSurvey(
      {required this.id, required this.score, required this.created_at});
  late final int id;
  late final int score;
  late final String created_at;

  CoupleReminderSurvey.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    score = json['score'];
    created_at = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['score'] = score;
    _data['created_at'] = created_at;
    return _data;
  }
}
