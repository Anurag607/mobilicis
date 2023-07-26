import 'dart:io';
import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:mobilicis/models/products_model.dart';
import 'package:mobilicis/models/search_model.dart';

class Constants {
  static Map<String, String> shopByUrls = {
    "Best Selling Mobiles":
        "https://d1tl44nezj10jx.cloudfront.net/web/assets/best-selling-mobiles.svg",
    "Verified Devices Only":
        "https://d1tl44nezj10jx.cloudfront.net/web/assets/verified-mobils.svg",
    "Like New Condition":
        "https://d1tl44nezj10jx.cloudfront.net/web/assets/like-new.svg",
    "Phones with Warranty":
        "https://d1tl44nezj10jx.cloudfront.net/web/assets/warranty.svg",
  };

  static List<String> brands = [
    "apple",
    "samsung",
    "xiaomi",
    "vivo",
    "oneplus",
    "oppo",
    "moto",
    "realme",
    "nokia",
    "google",
    "asus",
    "sony",
    "huawei",
    "lenovo",
    "honor",
    "lg",
    "htc",
    "alcatel",
    "blackberry",
    "nothing",
    "lava",
    "infinix",
    "tecno",
    "intex",
    "gionee",
    "micromax",
    "karbonn",
    "zte",
    "panasonic",
    "meizu",
  ];

  static String brandLogoImages(String brand) {
    return "https://www.oruphones.com/_next/image?url=https%3A%2F%2Fzenrodeviceimages.s3-us-west-2.amazonaws.com%2Foru%2Fproduct%2Fmobiledevices%2Fimg%2Fbrands%2Fmbr_$brand.png&w=128&q=75";
  }
}

class JSONConverter {
  static Future<List<Map>> convertJSONToList(
      String filePath, String content) async {
    var input = await File(filePath).readAsString();
    var map = jsonDecode(input);
    return map[content];
  }
}

class APIFunctions {
  static Future<dynamic> getProducts(int page, int limit) async {
    final String url =
        "https://dev2be.oruphones.com/api/v1/global/assignment/getListings?page=$page&limit=$limit";
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return ProductModel.fromJson(jsonDecode(response.body));
    } else {
      log("Error: ${response.statusCode}", error: response.body);
      return [];
    }
  }

  Future<dynamic> getSearchedProducts(String query) async {
    final body = {"searchModel": query};
    final headers = {HttpHeaders.contentTypeHeader: 'application/json'};
    const String url =
        "https://dev2be.oruphones.com/api/v1/global/assignment/searchModel/";

    http.Response response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: json.encode(body),
    );

    if (response.statusCode == 200) {
      return SearchModel.fromJson(jsonDecode(response.body));
    } else {
      log("Error: ${response.statusCode}", error: response.body);
      return null;
    }
  }
}
