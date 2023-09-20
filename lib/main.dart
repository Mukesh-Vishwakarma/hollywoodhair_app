import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logging/logging.dart';
import 'package:shopify_flutter/shopify_config.dart';
import 'package:sizer/sizer.dart';

import 'util/app_constants.dart';
import 'util/app_style.dart';
import 'util/lang/localization_service.dart';
import 'util/log.dart';
import 'util/route/app_pages.dart';
import 'util/route/app_routes.dart';
import 'util/service/auth_service.dart';
import 'util/theme_service.dart';

Future<void> main() async {
  _initLog();
  await GetStorage.init();
  await Get.putAsync(() => AuthServices().init());
  ShopifyConfig.setConfig(
    // storefrontAccessToken: '0be3088788389431389a3ce7a17eb4ba',
    storefrontAccessToken: '549578c139b9579e72a9674e7873a1b5',
    storeUrl: 'a02f54.myshopify.com',
    // adminAccessToken: "shpat_*******************", // optional
  );
  runApp(MyApp());
}

void _initLog() {
  Log.init();
  Log.setLevel(Level.ALL);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark));
    return Sizer(builder: (context, orientation, deviceType) {
      return GetMaterialApp(
        title: AppConstants.appName,
        debugShowCheckedModeBanner: false,
        themeMode: ThemeService().theme,
        theme: AppStyles.lightTheme,
        darkTheme: AppStyles.darkTheme,
        locale: LocalizationService().locale,
        fallbackLocale: LocalizationService.fallbackLocale,
        translations: LocalizationService(),
        getPages: AppRoutes.pages,
        initialRoute: AppPages.initialPage,
        enableLog: true,
      );
    });
  }
}
