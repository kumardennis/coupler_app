class DailyQuoteModel {
  DailyQuoteModel({
    required this.id,
    required this.createdAt,
    required this.textContentId,
    required this.textContent,
  });
  late final int id;
  late final String createdAt;
  late final int textContentId;
  late final TextContent textContent;

  DailyQuoteModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    textContentId = json['textContentId'];
    textContent = TextContent.fromJson(json['text_content']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['created_at'] = createdAt;
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
    this.et,
    required this.translations,
  });
  late final int id;
  late final String createdAt;
  late final String originalText;
  late final int originalLocaleId;
  late final String? et;
  late final List<dynamic> translations;

  TextContent.fromJson(Map<String, dynamic> json) {
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
