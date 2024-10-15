import 'dart:convert';

import 'package:covid19_report/get_controller/textfield_controller.dart';
import 'package:covid19_report/models/country_data_model.dart';
import 'package:covid19_report/models/covid_total_overview.dart';
import 'package:covid19_report/services/api_services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class FetchDataFromAPI {
  Future<CovidTotalOverview?> fetchTotalOverview() async {
    try {
      final response = await http.get(
        Uri.parse(APIServices().baseUrl),
      );

      var data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return CovidTotalOverview.fromJson(data);
      } else {
        throw Exception("Error");
      }
    } catch (err) {
      Get.snackbar(
        "Error",
        err.toString(),
      );
    }
  }

  TextFieldController textFieldController = Get.put(TextFieldController());

  List<CountryDataModel> countryWiseDataList = [];
  List<CountryDataModel> filteredList = [];
  Future<List<CountryDataModel>?> fetchCountryWiseData() async {
    if (textFieldController.searchField.value == "") {
      try {
        final response = await http.get(Uri.parse(APIServices().countryData));
        var data = jsonDecode(response.body);

        if (response.statusCode == 200) {
          for (Map<String, dynamic> i in data) {
            countryWiseDataList.add(CountryDataModel.fromJson(i));
          }
          return countryWiseDataList;
        } else {
          throw Exception("Error");
        }
      } catch (err) {
        print(err.toString());
      }
    } else {
      try {
        final response = await http.get(Uri.parse(APIServices().countryData));
        var data = jsonDecode(response.body);

        if (response.statusCode == 200) {
          for (Map<String, dynamic> i in data) {
            countryWiseDataList.add(CountryDataModel.fromJson(i));
          }
          filteredList = countryWiseDataList
              .where((element) => element.country!
                  .contains(textFieldController.searchField.value))
              .toList();
          return filteredList;
        } else {
          throw Exception("Error");
        }
      } catch (err) {
        print(err.toString());
      }
    }
  }
}
