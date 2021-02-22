import 'dart:convert';
import 'dart:js';

import 'package:ahadu_uber/configMaps.dart';
import 'package:ahadu_uber/models/address.dart';
import 'package:ahadu_uber/models/place.dart';
import 'package:ahadu_uber/services/data/appData.dart';
import 'package:ahadu_uber/services/data/method.dart';
import 'package:ahadu_uber/services/data/request.dart';
import 'package:ahadu_uber/widgets/divider.dart';
import 'package:ahadu_uber/widgets/progressDialog.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController pickUpTextController = TextEditingController();
  TextEditingController dropOffUpTextController = TextEditingController();
  List<PlaceInfo> predictionPlacesList = [];

  @override
  Widget build(BuildContext context) {
    String placeAddress =
        Provider.of<AppData>(context).pickUpLocation.placeName ?? "";
    pickUpTextController.text = placeAddress;
    return Scaffold(
      resizeToAvoidBottomPadding: false,
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
          SizedBox(
            height: 10,
          ),
          (predictionPlacesList.length > 0)
              ? Padding(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListView.separated(
                    padding: EdgeInsets.all(0),
                    itemBuilder: (context, index) {
                      return PlaceTile(place: predictionPlacesList[index]);
                    },
                    separatorBuilder: (BuildContext context, index) =>
                        DividerWidget(),
                    itemCount: predictionPlacesList.length,
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }

  void search(String place) async {
    String url =
        "https://api.geocode.earth/v1/autocomplete?api_key=ge-057da8dfd588e075&boundary.gid=whosonfirst:region:85671149&text=$place";

    var res = await CustomRequest.getRequest(url);
    if (res == 'failed') {
      return;
    }
    print("180");
    var prediction = res["features"];
    var placeList =
        (prediction as List).map((e) => PlaceInfo.fromJson(e)).toList();

    print("184");
    this.setState(() {
      predictionPlacesList = placeList;
    });
  }
}

void setState(Null Function() param0) {}

class PlaceTile extends StatelessWidget {
  final PlaceInfo place;

  PlaceTile({Key key, this.place}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: () {
        choosePlace(place, context);
      },
      child: Container(
        child: Column(
          children: [
            SizedBox(
              width: 10,
            ),
            Row(
              children: [
                Icon(Icons.add_location),
                SizedBox(
                  width: 14,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 8,
                      ),
                      place.name != null
                          ? Text(
                              place.name,
                              style: TextStyle(fontSize: 16),
                              overflow: TextOverflow.ellipsis,
                            )
                          : Container(),
                      SizedBox(
                        height: 2,
                      ),
                      place.label != null
                          ? Text(
                              place.label,
                              style:
                                  TextStyle(fontSize: 12, color: Colors.grey),
                              overflow: TextOverflow.ellipsis,
                            )
                          : place.street != null
                              ? Text(
                                  place.street,
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.grey),
                                  overflow: TextOverflow.ellipsis,
                                )
                              : Container(),
                      SizedBox(
                        height: 8,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  void choosePlace(PlaceInfo place, BuildContext context) {
    ProgressDialog(
      message: "Setting DropOff",
    );
    Address dropOffAddress = Address();
    dropOffAddress.latitude = place.latitude;
    dropOffAddress.longitude = place.longitude;
    dropOffAddress.placeName = place.name;

    Provider.of<AppData>(context, listen: false)
        .updateDropOffLocationAddress(dropOffAddress);

    Navigator.pop(context);
  }
}
