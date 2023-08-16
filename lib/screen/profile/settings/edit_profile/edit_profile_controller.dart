import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:hollywood_hair/util/app_colors.dart';
import 'package:hollywood_hair/util/assets.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileController extends GetxController {

  final formLoginKey = GlobalKey<FormState>();

  var emailController = TextEditingController();
  var nameController = TextEditingController();
  var contactController = TextEditingController();

  var name ="".obs;
  var email ="".obs;
  var contact ="".obs;
  var countryCode ="+91".obs;


  var fileImage = "".obs;
  var fileCompressImage = "".obs;
  var urlImage = "".obs;





  imageBottomSheet(context) {
    return Get.bottomSheet(
      Wrap(children: <Widget>[
        Container(
          margin: EdgeInsets.only(bottom: 30),
          color: AppColors.lightBackgroundColor,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: 8, bottom: 30),
                  child: Image.asset(
                    Assets.imagesIcLine,
                    height: 36,
                    width: 36,
                    // color: Colors.grey,
                  ),
                ),
                Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          getImageFormDevice(
                            ImageSource.camera,
                          );
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                                height: 40,
                                width: 40,
                                margin: EdgeInsets.only(bottom: 8),
                                child: Image.asset(
                                  Assets.cameraPng,
                                  color: AppColors.primaryColor,
                                )),
                            Container(
                              child: Text(
                                "camera".tr,
                                style: const TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 14,
                                  color: AppColors.primaryColor,
                                ),
                              ),
                            ),
                            // ,SizedBox(height: 30,)
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          // Get.back();
                          Navigator.pop(context);
                          getImageFormDevice(
                            ImageSource.gallery,
                          );
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                                height: 50,
                                width: 50,
                                margin: EdgeInsets.only(bottom: 8),
                                child: Image.asset(
                                  Assets.upload,
                                  color: AppColors.primaryColor,
                                )),
                            Container(
                              child: Text(
                                "gallery".tr,
                                style: const TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 14,
                                  color: AppColors.primaryColor,
                                ),
                              ),
                            ),
                            // ,SizedBox(height: 30,)
                          ],
                        ),
                      )
                    ]),
                SizedBox(
                  height: 15,
                )
              ]),
        )
      ]),
      isScrollControlled: false,
      backgroundColor: AppColors.lightBackgroundColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15.0),
            topRight: Radius.circular(15.0),
          )),
    );
  }



  getImageFormDevice(sourceType) async {
    var pickedFile =
    await ImagePicker().pickImage(source: sourceType, imageQuality: 50);
    print(pickedFile);
    if (pickedFile != null) {
      fileImage.value = pickedFile.path;
      getImageAfterCompress();
    } else {
      print('No image selected.');
    }
  }

  getImageAfterCompress() async {
    var date = DateTime.now();
    String imgPath = date.millisecondsSinceEpoch.toString();
    final dir = Directory.systemTemp;
    final targetPath = dir.absolute.path + "/$imgPath.jpg";
    var compressedFile = await FlutterImageCompress.compressAndGetFile(
        fileImage.value, targetPath,
        quality: 90);
    fileCompressImage.value = compressedFile!.path;
    print('profileImageCompressFile:---$fileCompressImage');
  }

  getProfileImage() {
    if (fileImage.isNotEmpty) {
      return ClipOval(
        child: SizedBox.fromSize(
          size: Size.fromRadius(50), // Image radius
          child: Image.file(
            File(fileImage.value),
            fit: BoxFit.cover,
          ),
        ),
      );
    } else if (urlImage.isNotEmpty) {
      return ClipOval(
          child: SizedBox.fromSize(
              size: const Size.fromRadius(90),
              child: Image.network(
                urlImage.value.toString(),
                fit: BoxFit.cover,
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) {
                    // Image has finished loading
                    return child;
                  } else {
                    // Image is still loading, show a placeholder or loading indicator
                    return Image.asset(
                      Assets.imagesIcUser,
                      fit: BoxFit.cover,
                    ); // Replace Placeholder with your desired loading widget
                  }
                },
                errorBuilder: (BuildContext context, Object exception,
                    StackTrace? stackTrace) {
                  return Image.asset(
                    Assets.imagesIcUser,
                    fit: BoxFit.cover,
                  );
                },
              )));
    } else {
      return Image.asset(
        Assets.imagesIcUser,
      );
    }
  }



}