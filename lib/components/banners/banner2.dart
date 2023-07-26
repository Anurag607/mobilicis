import 'package:flutter/material.dart';

class Banner2 extends StatelessWidget {
  const Banner2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          color: Colors.grey[300],
          child: Image.asset(
            'assets/images/banner_web_2.webp',
            cacheHeight: 200,
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
