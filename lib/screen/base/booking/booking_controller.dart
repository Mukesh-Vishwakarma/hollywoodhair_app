import 'package:get/get.dart';
import 'package:hollywood_hair/util/assets.dart';

class BookingController extends GetxController {
  var bookingList = <BookingModel>[];

  @override
  void onInit() {
    // TODO: implement onInit
    bookingList = [
      BookingModel(
          text: "style_selection_consultation".tr,
          description: "consult_with_experts".tr,
      image: Assets.demo1),
      // BookingModel(
      //     text: "Book_in_Store_appointment".tr,
      //     description: "Unlock_your_perfect_look".tr,
      //     image: Assets.demo2),
    ];
    super.onInit();
  }
}

class BookingModel {
  final String? text;
  final String? description;
  final String? image;

  BookingModel({this.text, this.description, this.image});
}
