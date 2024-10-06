class SearchModel {
  final List<String> makes, models;
  final String message;

  const SearchModel({
    required this.makes,
    required this.models,
    required this.message,
  });

  factory SearchModel.fromJson(Map<String, dynamic> json) {
    return SearchModel(
      makes: List<String>.from(json['makes']),
      models: List<String>.from(json['models']),
      message: json['message'],
    );
  }
}
