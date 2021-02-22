import 'package:geolocator/geolocator.dart';

class PlaceInfo {
  String name;
  String label;
  String street;
  String id;
  double longitude;
  double latitude;

  PlaceInfo({this.label, this.name, this.street, this.id});

  PlaceInfo.fromJson(Map<String, dynamic> json) {
    id = json["properties"]["id"];
    name = json["properties"]["name"];
    label = json["properties"]["label"];
    street = json["properties"]["street"];
    longitude = json["geometry"]["coordinates"][0];
    latitude = json["geometry"]["coordinates"][1];
  }
}
