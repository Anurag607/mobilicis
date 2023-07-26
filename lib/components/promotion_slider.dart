import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mobilicis/components/banners/banner1.dart';
import 'package:mobilicis/components/banners/banner2.dart';
import 'package:mobilicis/components/banners/banner3.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PromotionSlider extends StatefulWidget {
  const PromotionSlider({super.key});

  @override
  State<PromotionSlider> createState() => _PromotionSliderState();
}

class _PromotionSliderState extends State<PromotionSlider> {
  final _controller = PageController();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // page view
          SizedBox(
            height: 200,
            child: PageView(
              controller: _controller,
              children: const [
                Banner1(),
                Banner2(),
                Banner3(),
              ],
            ),
          ),
          const SizedBox(height: 10),
          // dot indicators
          SmoothPageIndicator(
            controller: _controller,
            count: 3,
            effect: ExpandingDotsEffect(
              activeDotColor: HexColor("#2d2e42"),
              dotColor: HexColor("#2d2e42").withOpacity(0.5),
              dotHeight: 10,
              dotWidth: 10,
              spacing: 10,
            ),
          ),
        ],
      ),
    );
  }
}
