import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hollywood_hair/util/app_style.dart';
import 'package:hollywood_hair/util/assets.dart';
import 'package:sizer/sizer.dart';

import '../../util/app_colors.dart';
import 'tryOn_controller.dart';

class PreviewScreen extends GetView<TryOnController> {
  const PreviewScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.black,
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 10.h,left: 15),
              child: Align(
                alignment: Alignment.topLeft,
                child: InkWell(
                  onTap: (){
                    Get.back();
                  },
                  child: Container(
                    height: 32,
                    width: 32,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.colorFF.withOpacity(0.15)),
                    child: Icon(
                      Icons.arrow_back,
                      color: AppColors.lightBackgroundColor,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ),
            Obx(() => Padding(
              padding: const EdgeInsets.only(top: 25.0),
              child: Container(
                      height: 70.h,
                      width: 100.w,
                      child: Image.file(
                        controller.captureImage.value,
                        fit: BoxFit.cover,
                      ),
                    ),
            )
                ),
            SizedBox(height: 20,),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: InkWell(
                  onTap: (){
                    controller.saveImageToGallery();
                    Get.back();
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                    color: AppColors.lightBackgroundColor,
                      borderRadius: BorderRadius.circular(8)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Save",
                        style: AppStyles.textStyle(
                          fontSize: 16.0,
                          weight: FontWeight.w500,
                        ),),
                        SizedBox(width: 10,),
                        SvgPicture.asset(Assets.download,
                        height: 15,
                        width: 10,)
                        // Icon(Icons.file_download)
                      ],
                    ),
                  ),
                ),
            )
          ],
        )
    );
  }
}
