import 'dart:io';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hollywood_hair/util/app_constants.dart';
import 'package:intl/intl.dart';
import 'package:shopify_flutter/models/models.dart';
import 'package:shopify_flutter/shopify/shopify.dart';

import '../../../../api_provider/api_provider.dart';
import '../../../../model/shopify_model/user_orders_model.dart';
import '../../../product_details/product_details_controller.dart';

class MyOrderController extends GetxController {
  ShopifyCheckout shopifyCheckout = ShopifyCheckout.instance;
  ShopifyAuth shopifyAuth = ShopifyAuth.instance;
  String? userAccessToken = "";
  var dataLoading = true.obs;
  var nodatafound = true.obs;
  RxList<Order> orderlist = <Order>[].obs;
  List<Order>? myOrder;

  var userOrdersModel = UserOrdersModel().obs;
  var orderStatus = true.obs;

  onInit() async {
    userAccessToken = (await shopifyAuth.currentCustomerAccessToken).toString();
    print("sahvZJhb==> ${GetStorage().read(AppConstants.userId)}");
    await getUsersAllOrders();
    getUserOrders();
    super.onInit();
  }

  getUsersAllOrders() async {
    print("ldkfjnxkzmxz==> $userAccessToken");
    try {
      List<Order>? order = await shopifyCheckout
          .getAllOrders(userAccessToken.toString())
          .timeout(const Duration(minutes: 5));
      print(order.toString());
      myOrder = order;
      dataLoading.value = false;
      nodatafound.value = false;
      if (order!.isNotEmpty) {
        orderlist.value = [];
        orderlist.value = order;
        nodatafound.value = false;
      }
    } catch (error) {
      print("message:$error");
    }
  }

  getFindController() {
    try {
      Get.find<ProductDetailsController>().onInit();
    } catch (e){
      print("kjashb $e");
    }
  }

  getUserOrders() async {
    try {
      final input = await GetStorage().read(AppConstants.userId);
      final customerId = input.split('/').last;
      UserOrdersModel getAddressModel =
      await ApiProvider.shopify().getMyOrdersByCustomerId(customerId: customerId);

      orderStatus.value = false;
          print("jhbzxnjkm");
      userOrdersModel.value = getAddressModel;

    } on HttpException catch (exception) {
      orderStatus.value = false;
      print(exception.message);
    } catch (exception) {
      orderStatus.value = false;
      print(exception.toString());
    }
  }

  dateConvert(inputDate) {
    try {
      // Parse the input date string into a DateTime object
      DateTime dateTime = DateTime.parse(inputDate);

      // Format the date using the desired format
      String formattedDate = DateFormat('E d MMM, yyyy').format(dateTime);
      return formattedDate;
    } catch (error) {
      return "";
    }
  }

}
