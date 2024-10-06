import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mobilicis/utils.dart';
import 'package:flutter/material.dart';

class CustomSearchBar extends StatefulWidget {
  const CustomSearchBar({super.key});

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  bool isLoading = false;
  bool active = false;
  String query = "";
  List<String> searchResults = [];
  List<String> makes = [];

  final searchQueryController = TextEditingController();
  FocusNode searchQueryFocusNode = FocusNode();

  void handleSearch(String query) async {
    if (query == "") {
      setState(() {
        active = false;
      });
    } else {
      setState(() {
        active = true;
      });
    }
    setState(() {
      isLoading = true;
    });
    final results = await APIFunctions().getSearchedProducts(query.trim());
    setState(() {
      if (results == null) {
        searchResults = [];
      } else {
        makes = results.makes;
        searchResults = results.models;
      }
    });
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      width: MediaQuery.of(context).size.width,
      height: active ? MediaQuery.of(context).size.height : 60,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar...
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(top: 5, left: 5, right: 5),
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(10),
                    topRight: const Radius.circular(10),
                    bottomLeft: Radius.circular(!active ? 10 : 0),
                    bottomRight: Radius.circular(!active ? 10 : 0),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      blurRadius: 4,
                      offset: const Offset(0.5, 2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(width: 20),
                    const Icon(
                      Icons.search,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        focusNode: searchQueryFocusNode,
                        controller: searchQueryController,
                        onChanged: handleSearch,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Search",
                          hintStyle: TextStyle(
                            color: Colors.grey.withOpacity(0.5),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        searchQueryController.clear();
                        searchQueryFocusNode.unfocus();
                        setState(() {
                          active = false;
                        });
                      },
                      icon: Icon(
                        Icons.clear,
                        color:
                            HexColor("#1a1a1c").withOpacity(active ? 1 : 0.5),
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Search Results...
            if (isLoading && active)
              Stack(
                children: [
                  Center(
                    child: Container(
                      height: 100,
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            blurRadius: 4,
                            offset: const Offset(0.5, 2),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Center(
                    child: Column(
                      children: [
                        const SizedBox(height: 25),
                        CircularProgressIndicator(
                          color: HexColor("#2d2e42"),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            else if (active)
              if (searchResults.isEmpty)
                Center(
                  child: Container(
                    height: 100,
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          blurRadius: 4,
                          offset: const Offset(0.5, 2),
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Text(
                        "No results found.",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                )
              else
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.775,
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          color: Colors.transparent,
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.only(top: 30),
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Text(
                            "Brand",
                            style: GoogleFonts.comfortaa(
                              textStyle: TextStyle(
                                color: HexColor("#1a1a1c").withOpacity(0.4),
                                fontSize: 12.5,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          color: Colors.transparent,
                          width: MediaQuery.of(context).size.width,
                          child: MediaQuery.removePadding(
                            context: context,
                            removeTop: true,
                            child: ListView(
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              clipBehavior: Clip.antiAlias,
                              children: List.generate(
                                makes.length,
                                (index) {
                                  return ListTile(
                                    tileColor: Colors.transparent,
                                    title: Text(
                                      makes[index].toString(),
                                      style: GoogleFonts.comfortaa(
                                        textStyle: TextStyle(
                                          color: HexColor("#1a1a1c")
                                              .withOpacity(0.8),
                                          fontSize: 17.5,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        Container(
                          color: Colors.transparent,
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.only(top: 10),
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Text(
                            "Mobile Model",
                            style: GoogleFonts.comfortaa(
                              textStyle: TextStyle(
                                color: HexColor("#1a1a1c").withOpacity(0.4),
                                fontSize: 12.5,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          color: Colors.transparent,
                          width: MediaQuery.of(context).size.width,
                          child: MediaQuery.removePadding(
                            context: context,
                            removeTop: true,
                            child: ListView(
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              clipBehavior: Clip.antiAlias,
                              children: List.generate(
                                searchResults.length,
                                (index) {
                                  return ListTile(
                                    tileColor: Colors.transparent,
                                    isThreeLine: false,
                                    title: Text(
                                      searchResults[index].toString(),
                                      style: GoogleFonts.comfortaa(
                                        textStyle: TextStyle(
                                          color: HexColor("#1a1a1c")
                                              .withOpacity(0.8),
                                          fontSize: 17.5,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
          ],
        ),
      ),
    );
  }
}
