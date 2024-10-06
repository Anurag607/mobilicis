import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mobilicis/utils.dart';

class ShopBySlider extends StatefulWidget {
  const ShopBySlider({super.key});

  @override
  State<ShopBySlider> createState() => _ShopBySliderState();
}

class _ShopBySliderState extends State<ShopBySlider> {
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
              "Shop By",
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
            child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              for (int index = 0;
                  index < Constants.shopByUrls.keys.length;
                  index++)
                Container(
                  width: 110,
                  height: 130,
                  padding: const EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 8.0,
                  ),
                  margin: const EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(7.5),
                  ),
                  child: Column(
                    children: [
                      SvgPicture.network(
                        width: 100,
                        height: 70,
                        Constants.shopByUrls.values.elementAt(index),
                        placeholderBuilder: (BuildContext context) => Container(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: const CircularProgressIndicator(),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        Constants.shopByUrls.keys.elementAt(index),
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            color: HexColor("#1a1a1c").withOpacity(0.8),
                            fontSize: 12.5,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
            ]),
          ),
        ],
      ),
    );
  }
}
