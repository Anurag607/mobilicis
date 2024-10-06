// ignore_for_file: unrelated_type_equality_checks, use_build_context_synchronously

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ionicons/ionicons.dart';
import 'package:mobilicis/components/brand_slider.dart';
import 'package:mobilicis/components/custom_modal_bottom_sheet.dart';
import 'package:mobilicis/components/filter_form.dart';
import 'package:mobilicis/components/product_listview.dart';
import 'package:mobilicis/components/promotion_slider.dart';
import 'package:mobilicis/components/search_bar.dart';
import 'package:mobilicis/components/shop_by_slider.dart';
import 'package:mobilicis/components/top_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isConnected = false;
  String location = "India";

  Future<bool> checkConnection() async {
    if (isConnected) return true;
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      return false;
    } else {
      return true;
    }
  }

  @override
  void initState() {
    checkConnection().then((value) {
      if (value == false) {
        setState(() {
          isConnected = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("No Internet Connection"),
            backgroundColor: Colors.red,
          ),
        );
      } else {
        setState(() {
          isConnected = true;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.grey.shade100,
        child: SingleChildScrollView(
          child: !isConnected
              ? Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  color: HexColor("#2d2e42"),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/no-wifi.png', width: 200),
                      const SizedBox(height: 20),
                      const Text(
                        "No Internet Connection",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22.5,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ))
              : Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: MediaQuery.of(context).padding.top),
                    // TopBar...
                    const TopBar(),
                    // SearchBar...
                    const CustomSearchBar(),
                    // BrandSlider...
                    const BrandSlider(),
                    // Promotion Slider...
                    const SizedBox(height: 10),
                    const PromotionSlider(),
                    // Shop By Slider...
                    const ShopBySlider(),
                    const SizedBox(height: 20),
                    // Filter and Location Bar...
                    Container(
                      width: MediaQuery.of(context).size.width,
                      color: Colors.transparent,
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                              margin: const EdgeInsets.only(left: 10),
                              child: Row(
                                children: [
                                  const Text(
                                    "Best Deals Near You",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                  const SizedBox(width: 7),
                                  Text(
                                    location,
                                    style: const TextStyle(
                                      fontSize: 22.5,
                                      color: Colors.amber,
                                      fontWeight: FontWeight.w900,
                                      decoration: TextDecoration.underline,
                                      decorationThickness: 1.5,
                                    ),
                                  ),
                                ],
                              )),
                          TextButton.icon(
                            onPressed: () {
                              CustomBottomModalSheet.customBottomModalSheet(
                                context,
                                MediaQuery.of(context).size.height * 0.75,
                                const FilterForm(),
                              );
                            },
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            icon: const Icon(
                              Ionicons.filter,
                              color: Colors.black87,
                            ),
                            label: const Text(
                              "Filter",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black87,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    // Products...
                    const ProductListView(),
                  ],
                ),
        ),
      ),
    );
  }
}
