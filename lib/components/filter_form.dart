import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mobilicis/data/filters.dart';
import 'package:mobilicis/redux/actions.dart';
import 'package:mobilicis/redux/states/filter_state.dart';

class FilterForm extends StatefulWidget {
  const FilterForm({
    super.key,
  });

  @override
  State<FilterForm> createState() => _FilterFormState();
}

class _FilterFormState extends State<FilterForm> {
  Map<String, dynamic> filterSelections = {
    "make": [],
    "condition": [],
    "storage": [],
    "ram": []
  };
  late final Function press;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<SelectedFitlersState, Map<String, dynamic>>(
      converter: (store) => store.state.selectedFilters,
      builder: (context, Map<String, dynamic> selectedFilters) {
        filterSelections = selectedFilters;
        return Container(
          color: Colors.transparent,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.7,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Filters",
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.7),
                      fontSize: 22.5,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      filterSelections = {
                        "make": [],
                        "condition": [],
                        "storage": [],
                        "ram": []
                      };
                      StoreProvider.of<SelectedFitlersState>(context).dispatch(
                        UpdateSelectedFiltersAction({
                          "make": [],
                          "condition": [],
                          "storage": [],
                          "ram": []
                        }),
                      );
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Clear Filter",
                      style: TextStyle(
                        fontSize: 17.5,
                        color: Colors.red.withOpacity(0.8),
                        decoration: TextDecoration.underline,
                        decorationThickness: 1.75,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 10),
              Container(
                color: Colors.transparent,
                width: MediaQuery.of(context).size.width,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: filters.keys.map((filter) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${filter[0].toUpperCase()}${filter.substring(1)}",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.7),
                              fontSize: 20,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          const SizedBox(height: 7.5),
                          Container(
                            color: Colors.transparent,
                            width: MediaQuery.of(context).size.width,
                            child: SingleChildScrollView(
                              clipBehavior: Clip.antiAlias,
                              physics: const BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [...filters[filter]].map((val) {
                                  return Container(
                                    margin: const EdgeInsets.only(right: 10),
                                    child: OutlinedButton(
                                      onPressed: () {
                                        setState(() {
                                          filterSelections[filter].contains(
                                                  val.toString().toLowerCase())
                                              ? filterSelections[filter].remove(
                                                  val.toString().toLowerCase())
                                              : filterSelections[filter].add(
                                                  val.toString().toLowerCase());
                                        });
                                      },
                                      style: OutlinedButton.styleFrom(
                                        backgroundColor:
                                            (filterSelections[filter].contains(
                                                    val
                                                        .toString()
                                                        .toLowerCase()))
                                                ? Colors.grey[300]
                                                : Colors.transparent,
                                        side: BorderSide(
                                          color: Colors.black.withOpacity(0.5),
                                          width: 1,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                      ),
                                      child: Text(
                                        val,
                                        style: TextStyle(
                                          color: Colors.black.withOpacity(0.7),
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  StoreProvider.of<SelectedFitlersState>(context).dispatch(
                    UpdateSelectedFiltersAction(filterSelections),
                  );
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(MediaQuery.of(context).size.width, 40),
                  backgroundColor: HexColor("#2d2e42"),
                  side: const BorderSide(
                    color: Colors.transparent,
                    width: 0,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                child: Text(
                  "Apply Filter",
                  style: TextStyle(
                    color: Colors.white.withOpacity(1),
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
