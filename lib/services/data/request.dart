import 'dart:convert';

import 'package:http/http.dart' as http;

class CustomRequest {
  static Future<dynamic> getRequest(String url) async {
    http.Response response = await http.get(url);

    try {
      if (response.statusCode == 200) {
        String jsonData = response.body;
        var decodeData = jsonDecode(jsonData);
        return decodeData;
      } else {
        return "Failed, No Response";
      }
    } catch (e) {
      return "failed.";
    }
  }
}
