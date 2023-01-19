import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/CountryListModel.dart';
import '../models/WorldStateModel.dart';
import 'app_url.dart';

class StateServices {
  Future<WorldStateModel> getWorldStateModel() async {
    final response = await http.get(Uri.parse(AppUrl.worldStateUrl));
    final data = await jsonDecode(response.body);
    if (response.statusCode == 200) {
      return WorldStateModel.fromJson(data);
    }
    throw Exception('Error');
  }

  List<CountryListModel> countryList = [];

  Future<List<CountryListModel>> getCountryListApi() async {
    final response = await http.get(Uri.parse(AppUrl.countryListUrl));
    final data = await jsonDecode(response.body);
    if (response.statusCode == 200) {
      for (Map i in data) {
        countryList.add(CountryListModel.fromJson(i));
      }
      return countryList;
    }
    throw Exception('Error');
  }
}
