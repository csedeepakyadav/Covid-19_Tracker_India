import 'package:flutter/material.dart';
import 'dart:async' show Future;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:covidtracker/model/DataModel.dart';

class StateManager with ChangeNotifier {
 /*  StateManager() {
    
  } */

  bool error = false;
  getError() => error;

  Future<CovidData> fetchCovidData() async {
    CovidData data;

    var response = await http.get(
      'https://covid-19-coronavirus-statistics.p.rapidapi.com/v1/stats?country=India',
      headers: {
        "X-RapidAPI-Host": "covid-19-coronavirus-statistics.p.rapidapi.com",
        "X-RapidAPI-Key": "a29ac21fabmsh82de3b391187b03p1a9d95jsn09596bfc5528"
      },
    );

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      print(jsonResponse['data']['covid19Stats']);

      if (jsonResponse['message'] == "OK") {
        for (var item in jsonResponse['data']['covid19Stats']) {
          data = new CovidData.fromJson(item);
        }

        return data;
      } else {
        error = true;
        notifyListeners();
        return null;
      }
    } else {
      error = true;
      notifyListeners();
    }
    return data;
  }
}
