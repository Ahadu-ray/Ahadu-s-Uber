import 'package:ahadu_uber/configMaps.dart';
import 'package:ahadu_uber/services/data/appData.dart';
import 'package:ahadu_uber/services/data/method.dart';
import 'package:ahadu_uber/services/data/request.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController pickUpTextController = TextEditingController();
  TextEditingController dropOffUpTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String placeAddress =
        Provider.of<AppData>(context).pickUpLocation.placeName ?? "";
    pickUpTextController.text = placeAddress;
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 215,
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                color: Colors.black,
                blurRadius: 6,
                spreadRadius: 0.5,
                offset: Offset(0.7, 0.7),
              ),
            ]),
            child: Padding(
              padding:
                  EdgeInsets.only(left: 25, right: 25, top: 30, bottom: 20),
              child: Column(
                children: [
                  SizedBox(height: 5),
                  Stack(
                    children: [
                      GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.arrow_back,
                          )),
                      Center(
                        child: Text(
                          "Set Drop Off Location",
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: "Lobster Regular",
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.map,
                        color: Colors.red,
                      ),
                      SizedBox(
                        width: 18,
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[400],
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(3),
                            child: TextField(
                              controller: pickUpTextController,
                              decoration: InputDecoration(
                                hintText: "Pick Up Location",
                                fillColor: Colors.grey[400],
                                filled: true,
                                border: InputBorder.none,
                                isDense: true,
                                contentPadding: EdgeInsets.only(
                                    left: 11, top: 6, bottom: 8),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.pin_drop,
                        color: Colors.red,
                      ),
                      SizedBox(
                        width: 18,
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[400],
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(3),
                            child: TextField(
                              onChanged: (val) {
                                search(val);
                              },
                              controller: dropOffUpTextController,
                              decoration: InputDecoration(
                                hintText: "Drop Off Location",
                                fillColor: Colors.grey[400],
                                filled: true,
                                border: InputBorder.none,
                                isDense: true,
                                contentPadding: EdgeInsets.only(
                                    left: 11, top: 6, bottom: 8),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void search(String place) async {
  searchPlace(place);
}
