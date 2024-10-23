import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart';

import 'networkresponse.dart';

class Networkcall {
  static Future<NetworkResponse> getRequest(String url) async {
    try {
      Response response = await get(Uri.parse(url), headers: {'Authorization': ''});
      log('Status Code: ${response.statusCode}');
      log('Response Body: ${response.body}');
      if (response.statusCode == 200) {
        return NetworkResponse(
            true, response.statusCode, jsonDecode(response.body));
      } else if (response.statusCode == 401) {
        // Handle unauthorized response if needed
      } else {
        return NetworkResponse(false, response.statusCode, null);
      }
    } catch (e) {
      log('Error: $e');
    }
    return NetworkResponse(false, -1, null);
  }
}
