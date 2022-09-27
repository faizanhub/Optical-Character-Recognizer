import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:optical_character_recognizer/constants/configs.dart';
import 'package:optical_character_recognizer/core/models/brewery.dart';
import 'package:http/http.dart' as http;

class BreweriesService {
  Future<List<Brewery>> getData() async {
    try {
      String url = AppConfigs.baseUrl;
      var response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        List jsonResponse = jsonDecode(response.body);
        List<Brewery> breweryList = [];

        breweryList =
            jsonResponse.map((brewery) => Brewery.fromJson(brewery)).toList();

        return breweryList;
      } else {
        debugPrint('Request failed with status: ${response.statusCode}.');
        throw Exception('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      throw Exception(
          'Something wrong happened while requesting http service $e');
    }
  }
}
