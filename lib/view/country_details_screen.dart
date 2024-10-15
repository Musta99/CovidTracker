import 'package:covid19_report/models/country_data_model.dart';
import 'package:covid19_report/view/covid_virus_data_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CountryDetailsScreen extends StatelessWidget {
  final CountryDataModel snapshotData;
  CountryDetailsScreen({
    Key? key,
    required this.snapshotData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Details of Covid Cases"),
          centerTitle: true,
        ),
        body: Container(
          margin: EdgeInsets.symmetric(
            horizontal: 12,
          ),
          child: Column(
            children: [
              Container(
                height: Get.height * 0.25,
                width: Get.width * 1,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                            snapshotData.countryInfo!.flag.toString()))),
              ),
              Container(
                child: Column(
                  children: [
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Country Name",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              snapshotData.country.toString(),
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Continent",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              snapshotData.continent.toString(),
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    ReUsableCard(
                      title: "Population",
                      value: double.parse(
                        snapshotData.population.toString(),
                      ),
                    ),
                    ReUsableCard(
                      title: "Total Cases",
                      value: double.parse(
                        snapshotData.updated.toString(),
                      ),
                    ),
                    ReUsableCard(
                      title: "Current Cases",
                      value: double.parse(
                        snapshotData.cases.toString(),
                      ),
                    ),
                    ReUsableCard(
                      title: "Total Recovered",
                      value: double.parse(
                        snapshotData.recovered.toString(),
                      ),
                    ),
                    ReUsableCard(
                      title: "Total Deaths",
                      value: double.parse(
                        snapshotData.deaths.toString(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
