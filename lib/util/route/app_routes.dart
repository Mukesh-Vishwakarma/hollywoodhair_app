import 'package:get/get.dart';
import 'package:hollywood_hair/screen/auth_screen/change_password/change_password_binding.dart';
import 'package:hollywood_hair/screen/auth_screen/change_password/change_password_screen.dart';
import 'package:hollywood_hair/screen/auth_screen/forgot_password/forgot_password_binding.dart';
import 'package:hollywood_hair/screen/auth_screen/forgot_password/forgot_password_screen.dart';
import 'package:hollywood_hair/screen/auth_screen/otp/otp_binding.dart';
import 'package:hollywood_hair/screen/auth_screen/otp/otp_screen.dart';
import 'package:hollywood_hair/screen/auth_screen/signIn/signIn_binding.dart';
import 'package:hollywood_hair/screen/auth_screen/signIn/signIn_screen.dart';
import 'package:hollywood_hair/screen/auth_screen/signUp/signUp_binding.dart';
import 'package:hollywood_hair/screen/auth_screen/signUp/signUp_screen.dart';
import 'package:hollywood_hair/screen/base_screen/base_home_binding.dart';
import 'package:hollywood_hair/screen/base_screen/base_home_screen.dart';
import 'package:hollywood_hair/screen/favourite_screen/favourite_binder.dart';
import 'package:hollywood_hair/screen/favourite_screen/favourite_screen.dart';
import 'package:hollywood_hair/screen/home_screen/home_binder.dart';
import 'package:hollywood_hair/screen/home_screen/home_screen.dart';
import 'package:hollywood_hair/screen/all_products/all_product_binder.dart';
import 'package:hollywood_hair/screen/all_products/all_product_screen.dart';
import 'package:hollywood_hair/screen/profile/profile_binding.dart';
import 'package:hollywood_hair/screen/profile/profile_screen.dart';
import 'package:hollywood_hair/screen/profile/settings/contact/contact_binding.dart';
import 'package:hollywood_hair/screen/profile/settings/contact/contact_screen.dart';
import 'package:hollywood_hair/screen/profile/settings/edit_profile/edit_profile_binding.dart';
import 'package:hollywood_hair/screen/profile/settings/edit_profile/edit_profile_screen.dart';
import 'package:hollywood_hair/screen/profile/settings/faq/faq_binding.dart';
import 'package:hollywood_hair/screen/profile/settings/faq/faq_screen.dart';
import 'package:hollywood_hair/screen/profile/settings/languages/languages_binding.dart';
import 'package:hollywood_hair/screen/profile/settings/languages/languages_screen.dart';
import 'package:hollywood_hair/screen/profile/settings/setting_binding.dart';
import 'package:hollywood_hair/screen/profile/settings/setting_screen.dart';
import 'package:hollywood_hair/screen/profile/settings/static/static_binding.dart';
import 'package:hollywood_hair/screen/profile/settings/static/static_screen.dart';
import 'package:hollywood_hair/screen/splash/splash_binding.dart';
import 'package:hollywood_hair/screen/splash/splash_screen.dart';

import 'app_pages.dart';

class AppRoutes {
  static var transitionDuration = const Duration(
    milliseconds: 550,
  );

  static final pages = [
    GetPage(
      name: AppPages.initialPage,
      page: () => SplashScreen(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: AppPages.signInScreen,
      page: () => SignInScreen(),
      binding: SignINBinding(),
    ),
    GetPage(
      name: AppPages.signUpScreen,
      page: () => SignUpScreen(),
      binding: SignUpBinding(),
    ),
    GetPage(
      name: AppPages.forgotScreen,
      page: () => ForgotPasswordScreen(),
      binding: ForgotBinding(),
    ),
    GetPage(
      name: AppPages.otpScreen,
      page: () => OtpScreen(),
      binding: OtpBinding(),
    ),
    GetPage(
      name: AppPages.changePasswordScreen,
      page: () => ChangePasswordScreen(),
      binding: ChangePasswordBinding(),
    ),
    GetPage(
      name: AppPages.profileScreen,
      page: () => ProfileScreen(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: AppPages.settingScreen,
      page: () => SettingScreen(),
      binding: SettingBinding(),
    ),
    GetPage(
      name: AppPages.languagesScreen,
      page: () => LanguageScreen(),
      binding: LanguagesBinding(),
    ),
    GetPage(
      name: AppPages.staticScreen,
      page: () => StaticScreen(),
      binding: StaticBinding(),
    ),
    GetPage(
      name: AppPages.contactScreen,
      page: () => ContactScreen(),
      binding: ContactBinding(),
    ),
    GetPage(
      name: AppPages.faqScreen,
      page: () => FaqScreen(),
      binding: FaqBinding(),
    ),
    GetPage(
      name: AppPages.editProfileScreen,
      page: () => EditProfileScreen(),
      binding: EditProfileBinding(),
    ),
    GetPage(
      name: AppPages.baseScreen,
      page: () => BaseHomeScreen(),
      binding: BaseHomeBinding(),
    ),
    GetPage(
      name: AppPages.homeScreen,
      page: () => HomeScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppPages.favouriteScreen,
      page: () => FavouriteScreen(),
      binding: FavouriteBinding(),
    ),GetPage(
      name: AppPages.allProductScreen,
      page: () => AllProductScreen(),
      binding: AllProductBinding(),
    ),
  ];
}
