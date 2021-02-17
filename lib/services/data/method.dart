import 'package:geolocator/geolocator.dart';
import 'package:osm_nominatim/osm_nominatim.dart';

Future searchCoordinate(Position position) async {
  final reverseSearchResult = await Nominatim.reverseSearch(
    lat: position.latitude,
    lon: position.longitude,
    addressDetails: true,
    extraTags: true,
    nameDetails: true,
  );
  print(reverseSearchResult);
  print("displayName ");
  print(reverseSearchResult..displayName);
  print("Name");
  print(reverseSearchResult.address);
  print("Tags");
  print(reverseSearchResult.extraTags);
  print("Details");
  print(reverseSearchResult.nameDetails);
  return reverseSearchResult;
}
