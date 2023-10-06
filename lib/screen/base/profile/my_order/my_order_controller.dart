import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shopify_flutter/models/models.dart';
import 'package:shopify_flutter/shopify/shopify.dart';

class MyOrderController extends GetxController {
  ShopifyCheckout shopifyCheckout = ShopifyCheckout.instance;
  ShopifyAuth shopifyAuth = ShopifyAuth.instance;
  String? userAccessToken = "";
  var dataLoading = true.obs;
  var nodatafound = true.obs;
  RxList<Order> orderlist = <Order>[].obs;
  List<Order>? myOrder;

  onInit() async {
    userAccessToken = (await shopifyAuth.currentCustomerAccessToken).toString();
    await getUsersAllOrders();
    super.onInit();
  }

  getUsersAllOrders() async {
    try {
      List<Order>? _order = await shopifyCheckout
          .getAllOrders("c903c2d8482bea98327dd0883956a1b0")
          .timeout(Duration(minutes: 5));
      print(_order.toString());
      myOrder = _order;
      dataLoading.value = false;
      nodatafound.value = false;
      // if (_order!.isNotEmpty) {
      //   orderlist.value = [];
      //   orderlist.value = _order;
      //   nodatafound.value = false;
      // }
    } catch (error) {
      print("message:$error");
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
