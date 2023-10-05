import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hollywood_hair/api_provider/api_provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../model/all_saloon_list_model.dart';
import '../../util/app_colors.dart';
import '../../util/common_function.dart';

class OurSalonsController extends GetxController {

   var pageLoader = true.obs;
   var allSaloonList = <SaloonData>[].obs;

  @override
  void onInit() {
    getAllSaloonList();
    super.onInit();
  }




  getAllSaloonList() async {
    try {
      AllSaloonListModel allSaloonListModel = await ApiProvider.base().getAllSaloonList();

      print('create Data');
      print(allSaloonListModel.result);
      pageLoader.value = false;
      if (allSaloonListModel.result == 1) {
        allSaloonList.value = allSaloonListModel.saloonData!;

      } else {
        successToast(allSaloonListModel.msg!);
      }
    } on HttpException catch (exception) {
      print(exception.message);
    } catch (exception) {
      print(exception.toString());
    }
  }

   networkImageCategory({required image}) {
     return Image.network(
       image,
       fit: BoxFit.cover,
       loadingBuilder: (BuildContext context, Widget child,
           ImageChunkEvent? loadingProgress) {
         if (loadingProgress == null) {
           return child;
         }
         return Shimmer.fromColors(
           baseColor: const Color.fromRGBO(191, 191, 191, 0.5254901960784314),
           highlightColor: Colors.white,
           child: Container(
             width: 50.w,
             height: 17.h,
             color: Colors.grey,
           ),
         );
       },
       errorBuilder:
           (BuildContext context, Object exception, StackTrace? stackTrace) {
         return Container(
           width: 50.w,
           height: 17.h,
           color: AppColors.lightGrey,
           child: const Icon(
             Icons.image_not_supported,
             color: Colors.white,
             size: 30,
           ), // You can use any widget as a placeholder
         );
       },
     );
   }


   Future<void> openMap(String latitude, String longitude) async {

     final cleanLatitude = latitude.replaceAll(RegExp(r'[^\d.]'), '');
     final cleanLongitude = longitude.replaceAll(RegExp(r'[^\d.]'), '');

     final url = Uri.parse('https://www.google.com/maps/search/?api=1&query=$cleanLatitude,$cleanLongitude');

     if (await canLaunch(url.toString())) {
       await launch(url.toString());
     } else {
       throw 'Could not launch $url';
     }
   }





}
