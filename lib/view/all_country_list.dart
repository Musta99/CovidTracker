import 'package:covid19_report/get_controller/textfield_controller.dart';
import 'package:covid19_report/models/country_data_model.dart';
import 'package:covid19_report/view/country_details_screen.dart';
import 'package:covid19_report/view_model/fetch_Api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllCountryList extends StatefulWidget {
  const AllCountryList({Key? key}) : super(key: key);

  @override
  State<AllCountryList> createState() => _AllCountryListState();
}

class _AllCountryListState extends State<AllCountryList> {
  TextFieldController textFieldController = Get.put(TextFieldController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    FetchDataFromAPI().fetchCountryWiseData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Data by Country"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Row(
                children: [
                  Obx(() {
                    return Expanded(
                      child: TextFormField(
                        initialValue: textFieldController.searchField.value,
                        onChanged: (value) {
                          textFieldController.changeValue(value);

                          print(textFieldController.searchField.value);
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                    );
                  }),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "Submit",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              Obx(
                () => Expanded(
                  child: FutureBuilder(
                      future: FetchDataFromAPI().fetchCountryWiseData(),
                      builder: (context,
                          AsyncSnapshot<List<CountryDataModel>?> snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          return ListView.builder(
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Get.to(
                                      CountryDetailsScreen(
                                        snapshotData: snapshot.data![index],
                                      ),
                                    );
                                  },
                                  child: Card(
                                    child: ListTile(
                                      leading: CircleAvatar(
                                        backgroundImage: NetworkImage(
                                          snapshot
                                              .data![index].countryInfo!.flag
                                              .toString(),
                                        ),
                                      ),
                                      title: Text(
                                        snapshot.data![index].country
                                            .toString(),
                                      ),
                                      trailing: Icon(
                                        Icons.arrow_right,
                                      ),
                                    ),
                                  ),
                                );
                              });
                        }
                      }),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
