class SpecialDates {
  SpecialDates({
    required this.id,
    required this.dateDescription,
    required this.date,
  });
  late final int id;
  late final String dateDescription;
  late final String date;

  SpecialDates.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dateDescription = json['dateDescription'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['dateDescription'] = dateDescription;
    _data['date'] = date;
    return _data;
  }
}
