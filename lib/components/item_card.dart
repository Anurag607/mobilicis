import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class ItemCard extends StatelessWidget {
  final dynamic product;
  final VoidCallback press;
  const ItemCard({
    super.key,
    required this.product,
    required this.press,
  });

  String pricetoStringConvertor() {
    String price = product["listingNumPrice"].toString();
    if (price.length == 4) {
      price =
          "${price.substring(price.length - 4, price.length - 3)},${price.substring(price.length - 3)}";
    } else if (price.length == 5) {
      price =
          "${price.substring(price.length - 5, price.length - 3)},${price.substring(price.length - 3)}";
    } else if (price.length == 6) {
      price =
          "${price.substring(0, price.length - 5)},${price.substring(price.length - 5, price.length - 3)},${price.substring(price.length - 3)}";
    }
    return price;
  }

  String dateConverter() {
    String date = product["listingDate"];
    List<String> dateList = date.split("/");
    List<String> monthList = [
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "May",
      "June",
      "July",
      "Aug",
      "Sept",
      "Oct",
      "Nov",
      "Dec",
    ];
    date =
        "${dateList[1]} ${monthList[int.parse(dateList[0]) - 1]} ${dateList[2]}";
    return date;
  }

  Widget nativeCachedImage() {
    return Image.network(
      product["defaultImage"]["fullImage"],
      cacheWidth: 200,
      loadingBuilder: (
        BuildContext context,
        Widget child,
        ImageChunkEvent? loadingProgress,
      ) {
        if (loadingProgress == null) {
          return child;
        }
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 57.5),
          child: const CircularProgressIndicator(),
        );
      },
      fit: BoxFit.contain,
    );
  }

  static final customCacheManager = CacheManager(
    Config(
      "productImages",
      stalePeriod: const Duration(hours: 15),
      maxNrOfCacheObjects: 100,
    ),
  );

  Widget pluginCachedImage() {
    return CachedNetworkImage(
      cacheManager: customCacheManager,
      key: UniqueKey(),
      width: 200,
      height: 125,
      fit: BoxFit.contain,
      imageUrl: product["defaultImage"]["fullImage"],
      progressIndicatorBuilder: (context, url, downloadProgress) => Container(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 57.5),
        child: CircularProgressIndicator(value: downloadProgress.progress),
      ),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Ink(
      child: InkWell(
        splashColor: Colors.black.withOpacity(0.1),
        onTap: () {},
        child: Container(
          color: Colors.white,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 125,
                  width: 200,
                  child: Stack(
                    children: [
                      Container(
                        width: 200,
                        margin: const EdgeInsets.only(top: 20),
                        padding: const EdgeInsets.all(10),
                        color: Colors.transparent,
                        child: nativeCachedImage(),
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.favorite_border,
                              color: Colors.pink),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  color: Colors.transparent,
                  padding: const EdgeInsets.all(6.5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "₹ ${pricetoStringConvertor()}",
                        style: GoogleFonts.comfortaa(
                          textStyle: TextStyle(
                            color: HexColor("#1a1a1c").withOpacity(1),
                            fontSize: 19,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        product["model"],
                        style: GoogleFonts.comfortaa(
                          textStyle: TextStyle(
                            color: HexColor("#1a1a1c").withOpacity(0.75),
                            fontSize: 13,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            product["deviceStorage"],
                            style: GoogleFonts.comfortaa(
                              textStyle: TextStyle(
                                color: HexColor("#1a1a1c").withOpacity(0.5),
                                fontSize: 10,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            "Condition: ${product["deviceCondition"]}",
                            style: GoogleFonts.comfortaa(
                              textStyle: TextStyle(
                                color: HexColor("#1a1a1c").withOpacity(0.5),
                                fontSize: 10,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            product["listingState"],
                            style: GoogleFonts.comfortaa(
                              textStyle: TextStyle(
                                color: HexColor("#1a1a1c").withOpacity(0.5),
                                fontSize: 10,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            dateConverter(),
                            style: GoogleFonts.comfortaa(
                              textStyle: TextStyle(
                                color: HexColor("#1a1a1c").withOpacity(0.5),
                                fontSize: 10,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
