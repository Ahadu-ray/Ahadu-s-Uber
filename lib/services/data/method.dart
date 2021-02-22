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

  Provider.of<AppData>(context, listen: false)
      .updatePickUpLocationAddress(userPickUpAddress);

  return reverseSearchResult.address["suburb"];
}

Future searchPlace(String place) async {
  final searchResult = await Nominatim.searchByName(
      query: place,
      limit: 1,
      addressDetails: true,
      extraTags: true,
      nameDetails: true,
      country: 'gb');
  print(searchResult.single.displayName);
}
