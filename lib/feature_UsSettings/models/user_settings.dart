class UserSettings {
  UserSettings({
    required this.darkMode,
    required this.blueAccent,
  });

  late final bool darkMode;
  late final bool blueAccent;

  UserSettings.fromJson(Map<String, dynamic> json) {
    darkMode = json['darkMode'];
    blueAccent = json['blueAccent'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};

    _data['darkMode'] = darkMode;
    _data['date'] = blueAccent;
    return _data;
  }
}
