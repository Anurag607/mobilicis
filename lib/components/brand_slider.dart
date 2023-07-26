import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mobilicis/utils.dart';

class BrandSlider extends StatefulWidget {
  const BrandSlider({super.key});

  @override
  State<BrandSlider> createState() => _BrandSliderState();
}

class _BrandSliderState extends State<BrandSlider> {
  static final customCacheManager = CacheManager(
    Config(
      "brandImages",
      stalePeriod: const Duration(days: 3),
      maxNrOfCacheObjects: 30,
    ),
  );

  // Widget nativeCachedImage(brand) {
  //   return Image.network(
  //     Constants.brandLogoImages(brand),
  //     loadingBuilder: (
  //       BuildContext context,
  //       Widget child,
  //       ImageChunkEvent? loadingProgress,
  //     ) {
  //       if (loadingProgress == null) {
  //         return child;
  //       }
  //       return Container(
  //         padding: const EdgeInsets.symmetric(vertical: 25.0, horizontal: 37.5),
  //         child: const CircularProgressIndicator(),
  //       );
  //     },
  //     fit: BoxFit.contain,
  //   );
  // }

  Widget pluginCachedImage(brand) {
    return CachedNetworkImage(
      cacheManager: customCacheManager,
      key: UniqueKey(),
      width: 200,
      height: 125,
      fit: BoxFit.contain,
      imageUrl: Constants.brandLogoImages(brand),
      progressIndicatorBuilder: (context, url, downloadProgress) => Container(
        padding: const EdgeInsets.symmetric(vertical: 25.0, horizontal: 37.5),
        child: CircularProgressIndicator(value: downloadProgress.progress),
      ),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Colors.grey.shade100,
      margin: const EdgeInsets.only(left: 5, top: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              "Buy Top Brands",
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  color: HexColor("#1a1a1c").withOpacity(0.8),
                  fontSize: 17.5,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          SingleChildScrollView(
            clipBehavior: Clip.antiAlias,
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: Constants.brands.map((brand) {
                return Container(
                  width: 100,
                  height: 75,
                  margin: const EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: pluginCachedImage(brand),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
