import 'package:get/get.dart';

class StaticController extends GetxController {
  var title = "".obs;

  @override
  void onInit() {
    // TODO: implement onInit
    title.value = Get.arguments??"";
    super.onInit();
  }


}