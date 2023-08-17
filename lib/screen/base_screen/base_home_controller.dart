import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hollywood_hair/screen/home_screen/home_controller.dart';
import 'package:hollywood_hair/screen/profile/profile_screen.dart';

import '../home_screen/home_screen.dart';

class BaseHomeController extends GetxController {
  var selectedIndex = 0.obs;
  var baseChildren = <Widget>[].obs;

  // final homeScreenController = Get.put(HomeController()).obs;

  var totalMessageCount = "0".obs;

  // final likeScreenController = Get.put(LikeController()).obs;
  // final socketService = Get.find<SocketService>();

  @override
  void onInit() {
    lazyPutScreens();
    baseChildren.value = [
      HomeScreen(),
      HomeScreen(),
      HomeScreen(),
      HomeScreen(),
      ProfileScreen(),
    ];

    super.onInit();
  }

  lazyPutScreens() {
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => ProfileScreen());
  }

  onItemSelect(index) {
    selectedIndex.value = index;
    refresh();
  }

// messageCountApi() async {
//   try {
//     Map<String, dynamic> params = {
//       'user_id': GetStorage().read(AppConstants.userId),
//     };
//     TotalMessagesModel totalMessagesModel =
//     await ApiProvider.base().getTotalMessages(params);
//     if (totalMessagesModel.result == 1) {
//       totalMessageCount.value = totalMessagesModel.data.toString();
//       print("Api not responding... ${totalMessagesModel.data.toString()}");
//     } else {
//       print("Api not responding...");
//     }
//   } on HttpException catch (exception) {
//     print("Api not responding... $exception");
//   } catch (exception) {
//     print("Api not responding... $exception");
//   }
// }
}
