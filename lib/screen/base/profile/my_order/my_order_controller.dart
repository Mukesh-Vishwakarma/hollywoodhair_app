import 'package:get/get.dart';
import 'package:shopify_flutter/models/models.dart';
import 'package:shopify_flutter/shopify/shopify.dart';

class MyOrderController extends GetxController {
  ShopifyCheckout shopifyCheckout = ShopifyCheckout.instance;
  ShopifyAuth shopifyAuth = ShopifyAuth.instance;
  String? userAccessToken = "";
  var dataLoading = true.obs;
  var nodatafound = true.obs;
  RxList<Order> orderlist = <Order>[].obs;

  onInit() async {
    // userAccessToken = GetStorage().read(AppConstants.accessToken);
    userAccessToken = (await shopifyAuth.currentCustomerAccessToken).toString();
    await getUsersAllOrders();
    super.onInit();
  }

  getUsersAllOrders() async {
    try {
      print(userAccessToken.toString());
      List<Order>? _order =
          await shopifyCheckout.getAllOrders(userAccessToken.toString());
      print(_order);
      // if (_order!.isNotEmpty) {
      //   orderlist.value = [];
      //   orderlist.value = _order;
      //   nodatafound.value = false;
      // }
    } catch (error) {
      print("message:$error");
    }
  }
}
