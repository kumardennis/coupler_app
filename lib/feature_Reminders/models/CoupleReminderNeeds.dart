class CoupleReminderNeeds {
  CoupleReminderNeeds({
    required this.id,
    required this.coupleId,
    required this.frequency,
    required this.timePeriodInDays,
    required this.reminderNeeds,
    required this.users,
  });
  late final int id;
  late final int coupleId;
  late int frequency;
  late int timePeriodInDays;
  late final ReminderNeeds reminderNeeds;
  late final Users users;

  CoupleReminderNeeds.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    coupleId = json['coupleId'];
    frequency = json['frequency'];
    timePeriodInDays = json['timePeriodInDays'];
    reminderNeeds = ReminderNeeds.fromJson(json['reminder_needs']);
    users = Users.fromJson(json['users']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['coupleId'] = coupleId;
    _data['frequency'] = frequency;
    _data['timePeriodInDays'] = timePeriodInDays;
    _data['reminder_needs'] = reminderNeeds.toJson();
    _data['users'] = users.toJson();
    return _data;
  }
}

class ReminderNeeds {
  ReminderNeeds({
    required this.id,
    required this.reminderText,
  });
  late final int id;
  late final String reminderText;

  ReminderNeeds.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    reminderText = json['reminderText'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['reminderText'] = reminderText;
    return _data;
  }
}

class Users {
  Users({
    required this.id,
    required this.name,
  });
  late final int id;
  late final String name;

  Users.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    return _data;
  }
}
