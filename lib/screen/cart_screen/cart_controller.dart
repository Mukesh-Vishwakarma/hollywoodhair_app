import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hollywood_hair/util/assets.dart';

class CartController extends GetxController with GetTickerProviderStateMixin {
  var promoCodeController = TextEditingController();
  RxList<CartModel> cartlist = <CartModel>[
    CartModel(
        image: Assets.p1,
        price: "zł 299.00",
        title: "Hair Spray",
        qun: "200 ml",
        number: 1),
    CartModel(
        image: Assets.p2,
        price: "zł 99.00",
        title: "Keratin Conditioner - Keratin Conditioner",
        qun: "200 ml",
        number: 1),
    CartModel(
        image: Assets.p3,
        price: "zł 29.00",
        title: "Scalp Mask - scalp treatment",
        qun: "500 ml",
        number: 2)
  ].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }
}

class CartModel {
  String image, price, title, qun;
  int number;

  CartModel(
      {required this.image,
      required this.price,
      required this.title,
      required this.qun,
      required this.number});
}
