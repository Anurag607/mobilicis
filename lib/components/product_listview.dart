import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mobilicis/components/item_card.dart';
import 'package:mobilicis/redux/states/filter_state.dart';
import 'package:mobilicis/utils.dart';
import 'package:mobilicis/data/products.dart' as products_data;

class ProductListView extends StatefulWidget {
  const ProductListView({super.key});

  @override
  State<ProductListView> createState() => _ProductListViewState();
}

class _ProductListViewState extends State<ProductListView>
    with TickerProviderStateMixin {
  late final AnimationController _opacityControllerItems = AnimationController(
    duration: const Duration(seconds: 1),
    vsync: this,
  )..forward();

  late final Animation<double> _opacityAnimationItems = CurvedAnimation(
    parent: _opacityControllerItems,
    curve: Curves.easeIn,
  );

  int page = 1;

  final ScrollController _scrollController = ScrollController();

  late dynamic products = products_data.products;
  late dynamic filteredProducts = products_data.products;

  void getMoreProducts() {
    APIFunctions.getProducts(page + 1, 10).then((value) {
      setState(() {
        page++;
        products = [...products, ...value.listings];
        filteredProducts = [...filteredProducts, ...value.listings];
      });
    });
  }

  bool passFilter(product, selectedFilters) {
    bool isFilteredByMake = true,
        isFilteredByCondition = true,
        isFilteredByStorage = true,
        isFilteredByRAM = true,
        noFilters = true;
    if (selectedFilters["make"].isNotEmpty) {
      log("filtering by make");
      noFilters = false;
      if (selectedFilters["make"]
          .contains(product["model"].split(" ")[0].toString().toLowerCase())) {
        isFilteredByMake = true;
      } else {
        isFilteredByMake = false;
      }
    }
    if (selectedFilters["condition"].isNotEmpty) {
      log("filtering by condition");
      noFilters = false;
      if (selectedFilters["condition"]
          .contains(product["deviceCondition"].toString().toLowerCase())) {
        isFilteredByCondition = true;
      } else {
        isFilteredByCondition = false;
      }
    }
    if (selectedFilters["storage"].isNotEmpty) {
      log("filtering by storage");
      noFilters = false;
      if (selectedFilters["storage"]
          .contains(product["deviceStorage"].toString().toLowerCase())) {
        isFilteredByStorage = true;
      } else {
        isFilteredByStorage = false;
      }
    }
    if (selectedFilters["ram"].isNotEmpty) {
      log("filtering by ram");
      noFilters = false;
      if (selectedFilters["ram"]
          .contains(product["deviceRam"].toString().toLowerCase())) {
        isFilteredByRAM = true;
      } else {
        isFilteredByRAM = false;
      }
    }
    if (noFilters) return true;
    if (isFilteredByMake &&
        isFilteredByCondition &&
        isFilteredByStorage &&
        isFilteredByRAM) return true;

    return false;
  }

  void filterProducts(selectedFilters) {
    filteredProducts = products.where((product) {
      return passFilter(product, selectedFilters);
    }).toList();
  }

  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        getMoreProducts();
      }
    });

    if (products.isEmpty) {
      APIFunctions.getProducts(page, 10).then((value) {
        setState(() {
          products = [...value.listings];
          filteredProducts = [...value.listings];
        });
      });
    }
    super.initState();
  }

  @override
  void dispose() {
    _opacityControllerItems.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
        return Future.delayed(const Duration(seconds: 1), () {
          setState(() {
            products = [];
            filteredProducts = [];
            page = 1;
          });
          APIFunctions.getProducts(page, 10).then((value) {
            setState(() {
              products = [...value.listings];
              filteredProducts = [...value.listings];
            });
          });
        });
      },
      child: StoreConnector<SelectedFitlersState, Map<String, dynamic>>(
        converter: (store) => store.state.selectedFilters,
        builder: (context, Map<String, dynamic> selectedFilters) {
          filterProducts(selectedFilters);
          return FadeTransition(
            opacity: CurvedAnimation(
              parent: _opacityAnimationItems,
              curve: Curves.easeIn,
            ),
            child: Container(
              clipBehavior: Clip.antiAlias,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.65,
              margin: const EdgeInsets.symmetric(horizontal: 5),
              decoration: const BoxDecoration(
                color: Colors.transparent,
              ),
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GridView.builder(
                      cacheExtent: 10,
                      shrinkWrap: true,
                      itemCount: filteredProducts.length + 1,
                      scrollDirection: Axis.vertical,
                      physics: const BouncingScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 7.5,
                        crossAxisSpacing: 5,
                        childAspectRatio: 0.75,
                      ),
                      itemBuilder: (BuildContext context, index) {
                        if (index == filteredProducts.length) {
                          return Container(
                            color: Colors.transparent,
                            width: MediaQuery.of(context).size.width,
                            child: Center(
                              child: CircularProgressIndicator(
                                color: HexColor("#2d2e42"),
                              ),
                            ),
                          );
                        }
                        if (passFilter(
                            filteredProducts[index], selectedFilters)) {
                          return ItemCard(
                            product: filteredProducts[index],
                            press: () => {},
                          );
                        } else {
                          return const SizedBox();
                        }
                      },
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
