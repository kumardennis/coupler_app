class CoupleModel {
  CoupleModel({
    required this.id,
    this.anniversary,
    required this.isActive,
    required this.initiatedById,
    required this.isAccepted,
    required this.partner1,
    required this.partner2,
  });
  late final int id;
  late final String? anniversary;
  late final bool isActive;
  late final bool isRejected;
  late final bool isAccepted;
  late final int initiatedById;
  late final Partner? partner1;
  late final Partner? partner2;

  CoupleModel.fromJson(Map<String, dynamic> json, int userId) {
    id = json['id'];
    anniversary = json['anniversary'];
    isActive = json['isActive'];
    isRejected = json['isRejected'];
    isAccepted = json['isAccepted'];
    initiatedById = json['initiatedById'];
    partner1 = json['partner1']['id'] == userId
        ? Partner.fromJson(json['partner1'])
        : Partner.fromJson(json['partner2']);
    partner2 = json['partner1']['id'] == userId
        ? Partner.fromJson(json['partner2'])
        : Partner.fromJson(json['partner1']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['anniversary'] = anniversary;
    _data['isActive'] = isActive;
    _data['partner1'] = partner1!.toJson();
    _data['partner2'] = partner2!.toJson();
    return _data;
  }
}

class Partner {
  Partner({
    required this.id,
    required this.name,
    this.profileImage,
  });
  late final int id;
  late final String name;
  late final String? profileImage;

  Partner.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    profileImage = json['profileImage'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['profileImage'] = profileImage;
    return _data;
  }
}
