class ProductModel {
  final List<Map<String, dynamic>> listings;
  final String nextPage, message;

  const ProductModel({
    required this.listings,
    required this.nextPage,
    required this.message,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      listings: List<Map<String, dynamic>>.from(json['listings']),
      nextPage: json['nextPage'],
      message: json['message'],
    );
  }
}
