import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hollywood_hair/screen/splash/splash_controller.dart';
import 'package:hollywood_hair/util/app_colors.dart';
import 'package:hollywood_hair/util/assets.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.splashColor,
        body: Stack(
          children: [
//             Column(
//       crossAxisAlignment: CrossAxisAlignment.end,
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//
//
//             // SvgPicture.asset(
//             //   Assets.icSplash3,
//             //   height: 20,
//             //   width: 20,
//             // )
//
//             Padding(
//               padding: const EdgeInsets.only(left: 40, right: 40, top: 100),
//               child: SvgPicture.asset(
//                 controller.image,
//               ),
//             ),
//             // Image.asset(
//             //   Assets.splashButtom,
//             // ),
//       ],
//     ),
            Padding(
              padding: const EdgeInsets.only(left: 50, right: 50, top: 80),
              child: Image.asset(
                controller.image,
                // height: 100,
                fit: BoxFit.fitWidth,
                width: double.infinity,
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: SizedBox(
                height: 55.h,
                child: Stack(
                  children: [
                    Image.asset(
                      Assets.icSplash2,
                      // height: 100,
                      fit: BoxFit.fill,
                      width: double.infinity,
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Image.asset(
                        Assets.icSplash3,
                        // height: 100,
                        // width: 200,
                      ),
                    ).marginOnly(top: 100),
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
