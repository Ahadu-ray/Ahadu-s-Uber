import 'dart:convert';

import 'package:ahadu_uber/models/address.dart';
import 'package:ahadu_uber/services/data/appData.dart';
import 'package:geolocator/geolocator.dart';
import 'package:osm_nominatim/osm_nominatim.dart';
import 'package:provider/provider.dart';

Future searchCoordinate(Position position, context) async {
  final reverseSearchResult = await Nominatim.reverseSearch(
    lat: position.latitude,
    lon: position.longitude,
    addressDetails: true,
    extraTags: true,
    nameDetails: true,
  );

  Address userPickUpAddress = Address();
  userPickUpAddress.latitude = position.latitude;
  userPickUpAddress.longitude = position.longitude;
  userPickUpAddress.placeName =
      reverseSearchResult.address.values.elementAt(0) +
          ", " +
          reverseSearchResult.address.values.elementAt(1) +
          ", " +
          reverseSearchResult.address.values.elementAt(2);

  print(reverseSearchResult.address.values.elementAt(0));

  Provider.of<AppData>(context, listen: false)
      .updatePickPickUpLocationAddress(userPickUpAddress);

  return reverseSearchResult.address["suburb"];
}
