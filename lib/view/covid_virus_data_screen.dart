import 'dart:convert';
import 'dart:ui';

import 'package:covid19_report/models/covid_total_overview.dart';
import 'package:covid19_report/res/utils/colorsLists.dart';
import 'package:covid19_report/view/all_country_list.dart';
import 'package:covid19_report/view_model/fetch_Api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:http/http.dart' as http;

class CovidVirusDataScreen extends StatefulWidget {
  const CovidVirusDataScreen({Key? key}) : super(key: key);

  @override
  State<CovidVirusDataScreen> createState() => _CovidVirusDataScreenState();
}

class _CovidVirusDataScreenState extends State<CovidVirusDataScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FetchDataFromAPI fetchDataFromAPI = FetchDataFromAPI();
    return Scaffold(
      appBar: AppBar(
        actions: [
          Card(
            child: TextButton(
                onPressed: () {
                  Get.changeTheme(ThemeData.light());
                },
                child: Text("Light")),
          ),
          Card(
            child: TextButton(
                onPressed: () {
                  Get.changeTheme(ThemeData.dark());
                },
                child: Text("Dark")),
          ),
        ],
      ),
      body: Container(
        child: Column(
          children: [
            // -------------- Pie Chart --------------- //
            FutureBuilder(
                future: fetchDataFromAPI.fetchTotalOverview(),
                builder:
                    (context, AsyncSnapshot<CovidTotalOverview?> snapshots) {
                  if (!snapshots.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return Expanded(
                      child: Column(
                        children: [
                          Container(
                            height: Get.height * 0.3,
                            child: PieChart(
                              colorList: [
                                Colors.blue,
                                Colors.green,
                                Colors.red,
                              ],
                              legendOptions: LegendOptions(
                                legendPosition: LegendPosition.left,
                              ),
                              chartValuesOptions: ChartValuesOptions(
                                showChartValuesInPercentage: true,
                              ),
                              chartType: ChartType.ring,
                              chartRadius: 150,
                              animationDuration: Duration(
                                seconds: 3,
                              ),
                              dataMap: {
                                "Total": double.parse(
                                    snapshots.data!.cases.toString()),
                                "Recovered": double.parse(
                                    snapshots.data!.active.toString()),
                                "Deaths": double.parse(
                                    snapshots.data!.deaths.toString()),
                              },
                            ),
                          ),

                          // -------------- Data List --------------- //
                          Expanded(
                            child: Container(
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    ReUsableCard(
                                      title: "Total cases",
                                      value: double.parse(
                                          snapshots.data!.updated.toString()),
                                    ),
                                    ReUsableCard(
                                      title: "Today cases",
                                      value: double.parse(snapshots
                                          .data!.todayCases
                                          .toString()),
                                    ),
                                    ReUsableCard(
                                      title: "Total death",
                                      value: double.parse(
                                          snapshots.data!.deaths.toString()),
                                    ),
                                    ReUsableCard(
                                      title: "Today Death",
                                      value: double.parse(snapshots
                                          .data!.todayDeaths
                                          .toString()),
                                    ),
                                    ReUsableCard(
                                      title: "Total Recovered",
                                      value: double.parse(
                                          snapshots.data!.recovered.toString()),
                                    ),
                                    ReUsableCard(
                                      title: "Today Recovered",
                                      value: double.parse(snapshots
                                          .data!.todayRecovered
                                          .toString()),
                                    ),
                                    ReUsableCard(
                                      title: "Active Cases",
                                      value: double.parse(
                                          snapshots.data!.active.toString()),
                                    ),
                                    ReUsableCard(
                                      title: "Critical Cases",
                                      value: double.parse(
                                          snapshots.data!.critical.toString()),
                                    ),
                                    ReUsableCard(
                                      title: "Cases per million",
                                      value: double.parse(snapshots
                                          .data!.casesPerOneMillion
                                          .toString()),
                                    ),
                                    ReUsableCard(
                                      title: "Deaths per million",
                                      value: double.parse(snapshots
                                          .data!.deathsPerOneMillion
                                          .toString()),
                                    ),
                                    ReUsableCard(
                                      title: "Total Tests",
                                      value: double.parse(
                                          snapshots.data!.tests.toString()),
                                    ),
                                    ReUsableCard(
                                      title: "Affected Countries",
                                      value: double.parse(snapshots
                                          .data!.affectedCountries
                                          .toString()),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),

                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                            ),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (context) => AllCountryList(),
                                  ),
                                );
                              },
                              child: Container(
                                height: Get.height * 0.06,
                                color: ColorsLists().buttonColor,
                                child: Center(
                                  child: Text(
                                    "View Country-wise",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                })
          ],
        ),
      ),
    );
  }
}

class ReUsableCard extends StatelessWidget {
  final String title;
  final double value;
  ReUsableCard({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
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
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              value.toString(),
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
