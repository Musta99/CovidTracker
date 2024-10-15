import 'package:get/get.dart';

class TextFieldController extends GetxController {
  RxString searchField = "".obs;

  void changeValue(String value) {
    searchField.value = value;
  }
}
