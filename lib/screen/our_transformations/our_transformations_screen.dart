import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hollywood_hair/util/app_colors.dart';
import 'package:hollywood_hair/util/app_style.dart';
import 'package:hollywood_hair/util/assets.dart';
import 'package:hollywood_hair/util/route/app_pages.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shimmer/shimmer.dart';

import '../../util/theme_service.dart';
import 'our_transformations_controller.dart';

class OurTransformationsScreen extends GetView<OurTransformationsController> {
  OurTransformationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(()=>OurTransformationsController());
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.white,
    ));
    return Scaffold(
      backgroundColor: AppColors.lightBackgroundColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(7.h),
        child: AppBar(
          elevation: 4,
          backgroundColor: AppColors.colorFF,
          leading: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: const Icon(
                Icons.arrow_back,
                color: AppColors.black,
              )),
          title:
          Text("Transformations",
                style: AppStyles.textStyle(
                    fontSize: 14.0, weight: FontWeight.w500)),

            ),
        ),
      body: SingleChildScrollView(
        child: Column(
            children:[
              SizedBox(height: 10,),
              bodyWidget(),
            ]
        ),
      )
    );
  }

  bodyWidget() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
                    child: SizedBox(
                      width: double.infinity,
                      child: Obx(
                        ()=> ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: controller.transformationData.length,
                            itemBuilder: (context, index) {
                              return transformationsWidget(index);
                            }),
                      ),
                    ),
                  )
            // : shimmerDemo()),
      ),
    );
  }


  transformationsWidget(index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Image.network(controller.transformationData[index].imageUrl.toString())),
        const SizedBox(height: 20),
        // Text(controller.transformationData[index].status.toString(),
        //   overflow: TextOverflow.ellipsis,
        //   style: AppStyles.textStyle(
        //     weight: FontWeight.w500,
        //     fontSize: 14.0,
        //   ),
        // ),
      ],
    );
  }


  shimmerDemo() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SizedBox(
        // width: 100.w,
        // height: 100.h,
        child: Shimmer.fromColors(
          baseColor: ThemeService().loadThemeFromBox()
              ? AppColors.color4A
              : Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: SingleChildScrollView(
            child: Column(
              children: [

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Container(
                              width: 50.w,
                              height: 17.h,
                              color: Colors.white,
                            ),
                          ),
                          Container(
                            width: 50.w,
                            height: 10.0,
                            color: Colors.white,
                          ).marginOnly(top: 10),
                          Container(
                            width: 20.w,
                            height: 10.0,
                            color: Colors.white,
                          ).marginOnly(top: 10),
                        ],
                      ),
                    ),
                    SizedBox(width: 10,),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Container(
                              width: 50.w,
                              height: 17.h,
                              color: Colors.white,
                            ),
                          ),
                          Container(
                            width: 50.w,
                            height: 10.0,
                            color: Colors.white,
                          ).marginOnly(top: 10),
                          Container(
                            width: 20.w,
                            height: 10.0,
                            color: Colors.white,
                          ).marginOnly(top: 10),
                        ],
                      ),
                    )
                  ],
                ).marginOnly(top: 00),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Container(
                              width: 50.w,
                              height: 17.h,
                              color: Colors.white,
                            ),
                          ),
                          Container(
                            width: 50.w,
                            height: 10.0,
                            color: Colors.white,
                          ).marginOnly(top: 10),
                          Container(
                            width: 20.w,
                            height: 10.0,
                            color: Colors.white,
                          ).marginOnly(top: 10),
                        ],
                      ),
                    ),
                    SizedBox(width: 10,),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Container(
                              width: 50.w,
                              height: 17.h,
                              color: Colors.white,
                            ),
                          ),
                          Container(
                            width: 50.w,
                            height: 10.0,
                            color: Colors.white,
                          ).marginOnly(top: 10),
                          Container(
                            width: 20.w,
                            height: 10.0,
                            color: Colors.white,
                          ).marginOnly(top: 10),
                        ],
                      ),
                    )
                  ],
                ).marginOnly(top: 30),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Container(
                              width: 50.w,
                              height: 17.h,
                              color: Colors.white,
                            ),
                          ),
                          Container(
                            width: 50.w,
                            height: 10.0,
                            color: Colors.white,
                          ).marginOnly(top: 10),
                          Container(
                            width: 20.w,
                            height: 10.0,
                            color: Colors.white,
                          ).marginOnly(top: 10),
                        ],
                      ),
                    ),
                    SizedBox(width: 10,),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Container(
                              width: 50.w,
                              height: 17.h,
                              color: Colors.white,
                            ),
                          ),
                          Container(
                            width: 50.w,
                            height: 10.0,
                            color: Colors.white,
                          ).marginOnly(top: 10),
                          Container(
                            width: 20.w,
                            height: 10.0,
                            color: Colors.white,
                          ).marginOnly(top: 10),
                        ],
                      ),
                    )
                  ],
                ).marginOnly(top: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
