import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:get/get.dart';
import 'package:hollywood_hair/util/app_colors.dart';
import 'package:hollywood_hair/util/app_style.dart';
import 'package:hollywood_hair/util/assets.dart';
import 'package:hollywood_hair/util/progress_dialog.dart';


class TryOnController extends GetxController {
  late List<CameraDescription> cameras;
  late CameraController cameraController;

  RxInt direction = 0.obs;
  Rx<File> captureImage = Rx<File>(File(""));

  var noDataFound = true.obs;

  double desiredAspectRatio = 16 / 9;

  @override
  void onInit() {
    startCamera(0);
    super.onInit();
  }


  void toggleDirection() {
    direction.value = direction.value == 0 ? 1 : 0;
  }

  Future<void> saveImageToGallery() async {
    if (captureImage.value.existsSync()) {
      final filePath = captureImage.value.path;

      try {
        GallerySaver.saveImage(albumName: "HollyWood Hair",filePath).then((value)  {
          print(value);
          print("susssssss");
        });

      } catch (e) {
        print('Error saving image: $e');
        Get.snackbar("Hello",
          "hiii",
          titleText: Text("Error",
          style: AppStyles.textStyle(),),
          messageText: Text("Failed to save the image to the gallery.",
          style: AppStyles.textStyle(),),
          backgroundColor: AppColors.primaryColor,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } else {
      Get.snackbar(
        'Image Not Found',
        'The captured image does not exist.',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }


  Future<void> startCamera(int direction) async {
    noDataFound.value = true;
    cameras = await availableCameras();
    cameraController = CameraController(
      cameras[direction],
      ResolutionPreset.ultraHigh,
      enableAudio: false,
    );
    try {
      await cameraController.initialize();
      noDataFound.value = false;
    } catch (e) {
      print("Error initializing camera: $e");
    }
    captureImage.value = File("");
    update();
  }

  @override
  void onClose() {
    cameraController.dispose();
    super.onClose();
  }

  var tag = 0.obs;
  List<String> styleList = <String>["Style", "Colour", "Length"];

  var image = 0.obs;
  List<String> imageList = <String>[
    Assets.ellipse2,
    Assets.ellipse5,
    Assets.ellipse3,
    Assets.ellipse4,
    Assets.ellipse1,
    Assets.ellipse6,
    Assets.ellipse3,
    Assets.ellipse2,
  ];
}
