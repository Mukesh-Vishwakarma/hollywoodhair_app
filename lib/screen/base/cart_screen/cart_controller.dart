import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hollywood_hair/model/shopify_model/get_cart_model.dart';
import 'package:hollywood_hair/util/app_constants.dart';
import 'package:hollywood_hair/util/common_function.dart';
import 'package:shopify_flutter/models/models.dart';
import 'package:shopify_flutter/models/src/shopify_user/address/address.dart';
import 'package:shopify_flutter/models/src/shopify_user/addresses/addresses.dart';
import 'package:shopify_flutter/shopify/shopify.dart';
import '../../../api_provider/api_provider.dart';
import '../../../model/shopify_model/get_address_model.dart';
import '../../../model/shopify_model/user_orders_model.dart';
import '../../../util/app_colors.dart';
import '../../../util/app_style.dart';
import '../../../util/route/app_pages.dart';

class CartController extends GetxController with GetTickerProviderStateMixin {
  var promoCodeController = TextEditingController(text: 'EG746C2HANN5');
  var cartList = <CartData>[].obs;
  ShopifyCheckout shopifyCheckout = ShopifyCheckout.instance;
  ShopifyAuth shopifyAuth = ShopifyAuth.instance;
  var checkoutId = "";
  var noCartCreated = true.obs;
  var dataLoading = true.obs;
  late Checkout checkout;

  final shopifyStore = ShopifyStore.instance;
  var userOrdersModel = UserOrdersModel().obs;
  var orderStatus = true.obs;

  var myPreviousProductCount = 0;
  var myCurrentProductCount = 0;

  var defaultAddress = true;
  Addresses? addresses;
  var addressesListNew = GetAddressModel().obs;

  var sippingAddress = false.obs;
  var companyName = "".obs;
  var customerAddressName = "".obs;
  var mobileNo = "".obs;
  var city = "".obs;
  var country = "".obs;
  var postelCode = "".obs;
  var address1 = "".obs;
  var address2 = "".obs;
  var addressId = "".obs;
  var firstName = "".obs;
  var lastName = "".obs;

  var addressLoaderStatus = false.obs;
  var openBottomSheetAddress = false.obs;

  var shippingAddressStatus = false.obs;

  @override
  void onInit() async {
    try {
      checkoutId = GetStorage().read(AppConstants.checkOutID) ?? "";
      if (checkoutId.isNotEmpty) {
        getCart();
      } else {
        noCartCreated.value = true;
        dataLoading = false.obs;
      }
    } catch (e) {
      noCartCreated.value = true;
      dataLoading = false.obs;
    }

    try {
      sippingAddress.value = GetStorage().read(AppConstants.sippingAddress);
      if (sippingAddress.value != null) {
        getAddress();
      }
    } catch (e) {
      print("sadzxcksdzxdszf===> $e");
    }

    print("sadzxcksdzx===> $checkoutId");

    try {
      getUserAddress("start");
    } catch (e) {
      print("sxcksdzxdszf===> $e");
    }

    super.onInit();
  }

  Future<void> getCart() async {
    print("mesjnbsage===> ");
    try {
      noCartCreated.value = true;
      Checkout checkoutModel = await shopifyCheckout
          .getCheckoutInfoQuery(checkoutId, getShippingInfo: false);
      dataLoading.value = false;
      noCartCreated.value = false;
      checkout = checkoutModel;
      print("xzVjhj 1 ===>$checkout");
      print("xzVjhj 2 ===>${checkout.shippingAddress}");
      if (checkout.shippingAddress == null) {
        shippingAddressStatus.value = false;
        print("sdbzn 1=> ");
      } else {
        shippingAddressStatus.value = true;
        print("sdbzn 2=> ");
      }
    } catch (error) {
      dataLoading.value = false;
      noCartCreated.value = true;
      GetStorage().write(AppConstants.checkOutID, "");
      print("message===> $error");
    }
  }

  void updateCartItemQuantity(lineItemID, int newQuantity) async {
    try {
      final cart = await shopifyCheckout
          .updateLineItemsInCheckout(checkoutId: checkoutId, lineItems: [
        LineItem(
            id: lineItemID.id,
            variantId: lineItemID.variantId,
            quantity: newQuantity,
            title: lineItemID.title),
      ]);
      getCart();
      print('Updated Cart: $cart');
    } catch (error) {
      print('Error updating cart: $error');
    }
  }

  void removeCartItems(lineItemID, int newQuantity) async {
    try {
      dataLoading.value = true;
      final cart = await shopifyCheckout
          .removeLineItemsFromCheckout(checkoutId: checkoutId, lineItems: [
        LineItem(
            id: lineItemID.id,
            variantId: lineItemID.variantId,
            quantity: newQuantity,
            title: lineItemID.title),
      ]);
      getCart();
      update();
      print('Updated Cart: $cart');
    } catch (error) {
      print('Error updating cart: $error');
    }
  }

  applyPromoCode() async {
    try {
      dataLoading.value = true;
      await shopifyCheckout.checkoutDiscountCodeApply(
          checkoutId, promoCodeController.text.trim());
      getCart();
      update();
    } catch (error) {
      // Handle errors if the update fails
      print('Error updating cart: $error');
    }
  }

  Future<void> goToCheckout() async {
    try {
      var result = await Get.toNamed(AppPages.checkout,
          arguments: [checkout.webUrl.toString()]);

      print("sdkjhbzxknlk=> $result");
      print("sdkjhbzxsjdhknlk=> ${checkout.webUrl.toString()}");
      if (result == "successful") {
        try {
          checkoutId = GetStorage().read(AppConstants.checkOutID) ?? "";
          GetStorage().write(AppConstants.myOrderedProductsCount,
              userOrdersModel.value.orders!.length);
          noCartCreated.value = true;
        } catch (e) {
          noCartCreated.value = true;
        }
      }
    } catch (e){
      print("dasbnjkm==> $e");
    }
  }

  updateAddress(
      {required company,
      required name,
      required phone,
      required city,
      required country,
      required zip,
      required address1,
      required address2,
      required id,
      required firstName,
      required lastName}) async {
    try {
      addressLoaderStatus.value = true;
      var checkOutID = await GetStorage().read(AppConstants.checkOutID) ?? "";
      final checkout = await shopifyCheckout.shippingAddressUpdate(
        checkOutID,
        Address(
          address1: address1.toString(),
          address2: address2.toString(),
          company: company.toString(),
          city: city.toString(),
          country: country.toString(),
          firstName: firstName.toString(),
          lastName: lastName.toString(),
          phone: phone.toString(),
          province: city.toString(),
          zip: zip.toString(),
        ),
      );
      changeAddress(
          company: country,
          name: name,
          phone: phone,
          city: city,
          country: country,
          zip: zip,
          address1: address1,
          address2: address2,
          id: id,
          firstName: firstName,
          lastName: lastName);
      addressLoaderStatus.value = false;
      shippingAddressStatus.value = true;
      defaultToast(
          "Address successfully change.", "Successful!", AppColors.lightGreen);
    } catch (exception) {
      defaultToast("Please check country or postcode.", "Invalid address",
          AppColors.primaryColorDark);
      // successToast("Invalid country or postcode.");
      addressLoaderStatus.value = false;
    }
  }

  getUserAddress(status) async {
    try {
      if (status != "start") {
        addressLoaderStatus.value = true;
      }
      final input = await GetStorage().read(AppConstants.userId);
      final customerId = input.split('/').last;
      GetAddressModel getAddressModel =
          await ApiProvider.shopify().getAddressShopify(customerId: customerId);
      print(await ShopifyAuth.instance.currentCustomerAccessToken);
      print(" vgfjsnzxvgfvcg");
      addresses = Addresses(addressList: []);
      addressesListNew.value = getAddressModel;
      if (status != "start") {
        addAddress();
        addressLoaderStatus.value = false;
      }
    } on HttpException catch (exception) {
      print(exception.message);
      addressLoaderStatus.value = false;
    } catch (exception) {
      print(exception.toString());
      addressLoaderStatus.value = false;
    }
  }

  changeAddress({
    required company,
    required name,
    required phone,
    required city,
    required country,
    required zip,
    required address1,
    required address2,
    required id,
    required firstName,
    required lastName,
  }) {
    try {
      GetStorage().write(AppConstants.sippingAddress, true);
      GetStorage().write(AppConstants.companyName, company.toString());
      GetStorage().write(AppConstants.customerAddressName, name.toString());
      GetStorage().write(AppConstants.mobileNo, phone.toString());
      GetStorage().write(AppConstants.city, city.toString());
      GetStorage().write(AppConstants.country, country.toString());
      GetStorage().write(AppConstants.postelCode, zip.toString());
      GetStorage().write(AppConstants.address1, address1.toString());
      GetStorage().write(AppConstants.address2, address2.toString());
      GetStorage().write(AppConstants.addressId, id.toString());
      GetStorage().write(AppConstants.firstName, firstName);
      GetStorage().write(AppConstants.lastName, lastName);
      print("asdygzhj==> $id");
      getAddress();
    } catch (e) {
      print("jsdzsnz==> $e");
    }
  }

  getAddress() async {
    print("hagsdjanjakm");
    companyName.value = await GetStorage().read(AppConstants.companyName) ?? "";
    customerAddressName.value =
        await GetStorage().read(AppConstants.customerAddressName) ?? "";
    mobileNo.value = await GetStorage().read(AppConstants.mobileNo) ?? "";
    city.value = await GetStorage().read(AppConstants.city) ?? "";
    country.value = await GetStorage().read(AppConstants.country) ?? "";
    postelCode.value = await GetStorage().read(AppConstants.postelCode) ?? "";
    address1.value = await GetStorage().read(AppConstants.address1) ?? "";
    address2.value = await GetStorage().read(AppConstants.address2) ?? "";
    addressId.value = await GetStorage().read(AppConstants.addressId) ?? "";
    firstName.value = await GetStorage().read(AppConstants.firstName) ?? "";
    lastName.value = await GetStorage().read(AppConstants.lastName) ?? "";

    // updateAddress(
    //     company: companyName.value,
    //     name: customerAddressName.value,
    //     phone: mobileNo.value,
    //     city: city.value,
    //     country: country.value,
    //     zip: postelCode.value,
    //     address1: address1.value,
    //     address2: address2.value,
    //     id: addressId.value,
    //     firstName: firstName.value,
    //     lastName: lastName.value);

    print("hagsdjanjakm ${companyName.value}");
  }

  addAddress() {
    return Get.bottomSheet(
        SizedBox(
          height: 270,
          child: Column(
            children: [
              Container(
                height: 5,
                width: 100,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ).marginOnly(top: 5),
              const Spacer(),
              ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
                child: Container(
                  height: 250,
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 0),
                  color: Colors.white,
                  child: (addressesListNew.value.addresses!.isNotEmpty)
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text("Select your delivery location",
                                style: TextStyle(
                                  color: AppColors.primaryColorDark,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w500,
                                )).marginOnly(top: 20, left: 10, bottom: 15),
                            Expanded(
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: const BouncingScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  itemCount:
                                      addressesListNew.value.addresses!.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return getAddressBottomSheet(
                                        addressesListNew
                                            .value.addresses![index]);
                                  }).marginOnly(left: 10, right: 10),
                            ),
                          ],
                        )
                      : Container(),
                ),
              ),
            ],
          ),
        ),
        isScrollControlled: true);
  }

  getAddressBottomSheet(AddressesList address) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 5.0, right: 5.0),
          child: GestureDetector(
            onTap: () {
              Get.back();
              updateAddress(
                  company: address.country,
                  name: address.name,
                  phone: address.phone,
                  city: address.city,
                  country: address.country,
                  zip: address.zip,
                  address1: address.address1,
                  address2: address.address2,
                  id: address.id,
                  firstName: address.firstName,
                  lastName: address.lastName);

              print("ajhsdghnj==> ${address.id}");
            },
            child: Container(
              width: 200,
              decoration: BoxDecoration(
                border: Border.all(
                  color: (shippingAddressStatus.value)
                      ? (addressId.value.toString() == address.id.toString())
                          ? AppColors.primaryColor
                          : AppColors.black
                      : AppColors.black,
                  width: 1.0,
                ),
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(address.name.toString(),
                        style: const TextStyle(
                          color: AppColors.black,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
                        )),
                    address.company != null
                        ? Text(
                            address.company ?? "",
                            style: AppStyles.textStyle(
                              color: AppColors.black,
                              fontSize: 14.0,
                              weight: FontWeight.w400,
                            ),
                          ).marginOnly(top: 10)
                        : const SizedBox(),
                    address.phone != null
                        ? Text(
                            address.phone ?? "",
                            style: AppStyles.textStyle(
                              color: AppColors.black,
                              fontSize: 14.0,
                              weight: FontWeight.normal,
                            ),
                          )
                        : const SizedBox(),
                    address.address1 != null
                        ? Text(address.address1 ?? "",
                            style: AppStyles.textStyle(
                              color: AppColors.black,
                              fontSize: 14.0,
                            ))
                        : const SizedBox(),
                    Row(
                      children: [
                        address.city != null
                            ? Text(
                                "${address.city}",
                                style: AppStyles.textStyle(
                                  color: AppColors.black,
                                  fontSize: 14.0,
                                ),
                              )
                            : const SizedBox(),
                        address.countryCode != null
                            ? Text(
                                ", ${address.countryCode} ",
                                style: AppStyles.textStyle(
                                  color: AppColors.black,
                                  fontSize: 14.0,
                                ),
                              )
                            : const SizedBox(),
                      ],
                    ),
                    Row(
                      children: [
                        address.country != null
                            ? Text(
                                address.country.toString(),
                                style: AppStyles.textStyle(
                                  color: AppColors.black,
                                  fontSize: 14.0,
                                ),
                              )
                            : const SizedBox(),
                        address.zip != null
                            ? Text(
                                "  ${address.zip}",
                                style: AppStyles.textStyle(
                                  color: AppColors.black,
                                  fontSize: 14.0,
                                ),
                              )
                            : const SizedBox(),
                      ],
                    ),
                  ],
                ),
              ),
            ).marginOnly(bottom: 10),
          ),
        ),
        if (shippingAddressStatus.value)
          if (addressId.value.toString() == address.id.toString())
            const Positioned(
              right: 8,
              top: 3,
              child: Icon(
                Icons.check_circle,
                color: AppColors.primaryColor,
              ),
            ),
      ],
    );
  }
}
