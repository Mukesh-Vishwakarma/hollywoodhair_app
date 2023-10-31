import 'dart:async';
import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hollywood_hair/model/all_saloon_list_model.dart';
import 'package:hollywood_hair/model/press_model.dart';
import 'package:hollywood_hair/model/shopify_model/category_model.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shopify_flutter/models/src/product/products/products.dart';
import 'package:shopify_flutter/shopify_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../api_provider/api_provider.dart';
import '../../../model/celebrities_model.dart';
import '../../../util/app_colors.dart';
import '../../../util/assets.dart';
import '../../product_details/product_details_controller.dart';
import '../../../model/featured_products_model.dart';

class HomeController extends GetxController with GetTickerProviderStateMixin {
  final PageController pageControllerNew = PageController(initialPage: 0);
  final ValueNotifier<int> currentPageNew = ValueNotifier<int>(0);

  final PageController pageController = PageController(initialPage: 0);
  var activePage = 0.obs;
  int currentPage = 0;
  Timer? timer;

  var searchController = TextEditingController();
  final GlobalKey<ScaffoldState> key = GlobalKey();
  var selectCategories = RxInt(-1);
  var categoriesId = 0.obs;
  RxList<Product> topProduct = <Product>[].obs;
  var categories = <CustomCollections>[].obs;

  RxList<Collection> collectionList = <Collection>[
    Collection(
        title: "All",
        id: "ALL",
        products: Products(productList: [], hasNextPage: false))
  ].obs;
  var selectedCollection = "".obs;

  var pageLoaderSalon = true.obs;
  var pageLoaderFeaturedStatus = true.obs;
  var allSaloonList = <SaloonData>[].obs;
  var allFeaturedProductsList = <FeaturedData>[].obs;

  var celebritiesModel = <CelebritiesModel>[].obs;
  final CarouselController carouselController = CarouselController();

  // RxList<TransformationsData> transformationData = <TransformationsData>[].obs;
  var isPageLoad = true.obs;

  var pressModelFirst = <PressModel>[].obs;
  var pressModelSecond = <PressModel>[].obs;
  var transformationsModel = <PressModel>[].obs;

  ScrollController scrollControllerFirst = ScrollController();
  ScrollController scrollControllerSecond = ScrollController();
  List<String> items = List.generate(10, (index) => 'Item $index');
  bool canJumpToFirstPosition = false;

  @override
  void onInit() {
    categoriesListApi();
    getTopProductApi();
    getAllSaloonList();
    getFeaturedProductsList();
    celebrities();
    press();
    transformation();
    scrollPressFirst();
    scrollPressSecond();
    // allTransformationApi();
    // celebritiesScroll();
    super.onInit();
  }

  ShopifyStore shopifyStore = ShopifyStore.instance;

  categoriesListApi() async {
    try {
      List<Collection>? collection = await shopifyStore.getAllCollections();
      print("collection ${collection}");
      collectionList.value = [];
      collectionList.add(Collection(
          title: "All",
          id: "ALL",
          products: Products(productList: [], hasNextPage: false)));
      collection.forEach((element) {
        collectionList.add(element);
        print("objectdhsjhx==> $element");
      });
    } on HttpException catch (exception) {
      print(exception.message);
    } catch (exception) {
      print(exception.toString());
    }
  }

  getTopProductApi() async {
    try {
      List<Product>? _product = await shopifyStore.getNProducts(6);
      topProduct.value = [];
      topProduct.value = _product!;
    } on HttpException catch (exception) {
      print(exception.message);
    } catch (exception) {
      print(exception.toString());
    }
  }

  networkImageWithLoader({required userProfile, height, width}) {
    return Image.network(
      userProfile,
      fit: BoxFit.cover,
      width: 50.w,
      height: 16.h,
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

  networkImageCategory({required userProfile, height, width}) {
    return Image.network(
      userProfile,
      fit: BoxFit.cover,
      width: 55,
      height: 55,
      loadingBuilder: (BuildContext context, Widget child,
          ImageChunkEvent? loadingProgress) {
        if (loadingProgress == null) {
          return child;
        }
        return Shimmer.fromColors(
          baseColor: const Color.fromRGBO(191, 191, 191, 0.5254901960784314),
          highlightColor: Colors.white,
          child: Container(
            width: 55,
            height: 55,
            color: Colors.grey,
          ),
        );
      },
      errorBuilder:
          (BuildContext context, Object exception, StackTrace? stackTrace) {
        return Container(
          width: 55,
          height: 55,
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

  getFindController() {
    try {
      Get.find<ProductDetailsController>().onInit();
    } catch (e) {
      print("kjashb $e");
    }
  }

  // final shopify = Shopify(
  //   apiKey: 'YOUR_SHOPIFY_API_KEY',
  //   password: 'YOUR_SHOPIFY_PASSWORD',
  //   store: 'YOUR_SHOPIFY_STORE_NAME',
  //   domain: 'YOUR_SHOPIFY_DOMAIN',
  // );
  //
  // Future<void> fetchHomeBanner() async {
  //   final query = r'''
  //   {
  //     shop {
  //       homeBanner {
  //         id
  //         image {
  //           originalSrc
  //         }
  //         title
  //         subtitle
  //         buttonText
  //         buttonLink
  //       }
  //     }
  //   }
  // ''';
  //
  //   final result = await shopify.query(query);
  //   final homeBannerData = result.data['shop']['homeBanner'];
  //
  //   // You can now use the homeBannerData in your UI.
  //   print('Home Banner Data: $homeBannerData');
  // }

  ///  Our Saloons
  getAllSaloonList() async {
    try {
      AllSaloonListModel allSaloonListModel =
          await ApiProvider.base().getAllSaloonList();

      print('create Data');
      print(allSaloonListModel.result);
      pageLoaderSalon.value = false;
      if (allSaloonListModel.result == 1) {
        allSaloonList.value = allSaloonListModel.saloonData!;
      }
    } on HttpException catch (exception) {
      print(exception.message);
    } catch (exception) {
      pageLoaderSalon.value = false;
      print(exception.toString());
    }
  }

  ///  Featured Products
  getFeaturedProductsList() async {
    try {
      FeaturedProductsModel featuredProductsModel =
          await ApiProvider.base().getFeaturedProducts();
      pageLoaderFeaturedStatus.value = false;
      if (featuredProductsModel.result == 1) {
        allFeaturedProductsList.value = featuredProductsModel.featuredData!;
      }
    } on HttpException catch (exception) {
      print(exception.message);
    } catch (exception) {
      pageLoaderFeaturedStatus.value = false;
      print("ajsdhbkxznkansz===> ${exception.toString()}");
    }
  }

  /// Images view
  networkImageSalons({required image}) {
    return Image.network(
      image,
      fit: BoxFit.cover,
      width: 50.w,
      height: 16.h,
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
            height: 16.h,
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

    final url = Uri.parse(
        'https://www.google.com/maps/search/?api=1&query=$cleanLatitude,$cleanLongitude');

    if (await canLaunch(url.toString())) {
      await launch(url.toString());
    } else {
      throw 'Could not launch $url';
    }
  }

  // celebritiesScroll(){
  //   // Set up a timer to auto-scroll every 3 seconds
  //   timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
  //     if (currentPage < (celebritiesModel.length / 2).ceil() - 1) {
  //       currentPage++;
  //     } else {
  //       currentPage = 0;
  //     }
  //     pageController.animateToPage(
  //       currentPage,
  //       duration: Duration(milliseconds: 300),
  //       curve: Curves.easeIn,
  //     );
  //   });
  // }

  celebrities() {
    celebritiesModel.add(CelebritiesModel(
        id: "1",
        title: "title",
        image: Assets.cel1,
        socialLink: "https://www.instagram.com/whatannawears/"));
    celebritiesModel.add(CelebritiesModel(
        id: "2",
        title: "title",
        image: Assets.cel2,
        socialLink: "https://www.instagram.com/anna_maria.sieklucka/"));
    celebritiesModel.add(CelebritiesModel(
        id: "3",
        title: "title",
        image: Assets.cel3,
        socialLink: "https://www.instagram.com/dominikazak/"));
    celebritiesModel.add(CelebritiesModel(
        id: "4",
        title: "title",
        image: Assets.cel4,
        socialLink: "https://www.instagram.com/maffashion_official/"));
    celebritiesModel.add(CelebritiesModel(
        id: "5",
        title: "title",
        image: Assets.cel5,
        socialLink: "https://www.instagram.com/karolinagilonofficial/"));
    celebritiesModel.add(CelebritiesModel(
        id: "6",
        title: "title",
        image: Assets.cel6,
        socialLink: "https://www.instagram.com/nosowska.official/"));
    celebritiesModel.add(CelebritiesModel(
        id: "7",
        title: "title",
        image: Assets.cel7,
        socialLink: "https://www.instagram.com/majabohosiewicz/"));
    celebritiesModel.add(CelebritiesModel(
        id: "8",
        title: "title",
        image: Assets.cel8,
        socialLink: "https://www.instagram.com/monika.milller/"));
    celebritiesModel.add(CelebritiesModel(
        id: "9",
        title: "title",
        image: Assets.cel9,
        socialLink: "https://www.instagram.com/mamaginekolog/"));
    celebritiesModel.add(CelebritiesModel(
        id: "10",
        title: "title",
        image: Assets.cel10,
        socialLink: "https://www.instagram.com/tojafrycz/"));
    celebritiesModel.add(CelebritiesModel(
        id: "11",
        title: "title",
        image: Assets.cel11,
        socialLink: "https://www.instagram.com/pamelastefanowicz/"));
    celebritiesModel.add(CelebritiesModel(
        id: "12",
        title: "title",
        image: Assets.cel12,
        socialLink: "https://www.instagram.com/kazadi_official/"));
    celebritiesModel.add(CelebritiesModel(
        id: "13",
        title: "title",
        image: Assets.cel13,
        socialLink: "https://www.instagram.com/soniabohosiewicz/"));
    celebritiesModel.add(CelebritiesModel(
        id: "14",
        title: "title",
        image: Assets.cel14,
        socialLink: "https://www.instagram.com/wersow/"));
    celebritiesModel.add(CelebritiesModel(
        id: "15",
        title: "title",
        image: Assets.cel15,
        socialLink: "https://www.instagram.com/whatannawears/"));
    celebritiesModel.add(CelebritiesModel(
        id: "16",
        title: "title",
        image: Assets.cel16,
        socialLink: "https://www.instagram.com/anna_maria.sieklucka/"));
  }

  press() {
    pressModelFirst.add(PressModel(
        id: "1",
        title: "forbes",
        image: Assets.press1,
        socialLink:
            "https://www.forbes.pl/biznes/hollywood-hair-przedluzanie-wlosow-nowym-trendem-na-rynku-beauty/jvq54gg"));
    pressModelFirst.add(PressModel(
        id: "2",
        title: "feszyn",
        image: Assets.press2,
        socialLink:
            "https://feszyn.com/przed-rozpoczeciem-mojej-dzialalnosci-rynek-przedluzania-wlosow-w-polsce-praktycznie-nie-istnial/"));
    pressModelFirst.add(PressModel(
        id: "3",
        title: "galeriehandlowe",
        image: Assets.press3,
        socialLink:
            "https://www.galeriehandlowe.pl/publikacje/retail-news/artykul/hollywood-hair-poszerza-swoja-ekspansje-i-otwiera-dziesiaty-jubileuszowy-salon-w-szczecinie"));
    pressModelFirst.add(PressModel(
        id: "4",
        title: "inwestycje",
        image: Assets.press4,
        socialLink:
            "https://inwestycje.pl/biznes/hollywood-hair-przyspiesza-swoja-ekspansje/"));
    pressModelFirst.add(PressModel(
        id: "5",
        title: "mamstartup",
        image: Assets.press5,
        socialLink:
            "https://mamstartup.pl/stworzylam-siec-salonow-hollywood-hair-bez-zewnetrznego-finansowania-klaudia-duszynska/"));
    pressModelFirst.add(PressModel(
        id: "6",
        title: "kierunekkosmetyki",
        image: Assets.press6,
        socialLink:
            "https://www.kierunekkosmetyki.pl/artykul,97834,hollywood-hair-poszerza-swoja-ekspansje-i-otwiera-dziesiaty-jubileuszowy-salon-w-szczecinie.html"));
    pressModelFirst.add(PressModel(
        id: "7",
        title: "omnichannelnews",
        image: Assets.press7,
        socialLink:
            "https://omnichannelnews.pl/2023/09/11/kolejne-salony-sieci-hollywood-hair-na-mapie-polski/"));
    pressModelFirst.add(PressModel(
        id: "8",
        title: "stronakobiet",
        image: Assets.press8,
        socialLink:
            "https://stronakobiet.pl/pielegnacja-wlosow-latem-zobacz-porady-ekspertek-ktore-uchronia-twoje-kosmyki-przed-zniszczeniem-ich-podczas-wakacji/ar/c6-17596503"));
    pressModelFirst.add(PressModel(
        id: "9",
        title: "wirtualnekosmetyki",
        image: Assets.press9,
        socialLink:
            "https://wirtualnekosmetyki.pl/-newsy-producenci/kolejne-dwa-salony-hollywood-hair"));
    pressModelSecond.add(PressModel(
        id: "10",
        title: "lelum",
        image: Assets.press10,
        socialLink:
            "https://lelum.pl/olsniewajace-wlosy-dbaj-o-nie-w-trakcie-wakacji-rl-wd-130723"));
    pressModelSecond.add(PressModel(
        id: "11",
        title: "youtube",
        image: Assets.press11,
        socialLink: "https://www.youtube.com/watch?v=XXjXAtOEdsA"));
    pressModelSecond.add(PressModel(
        id: "12",
        title: "marketingibiznes",
        image: Assets.press12,
        socialLink:
            "https://marketingibiznes.pl/biznes/autentycznosc-komunikacji-marki-w-social-media-pozwolila-nam-wzrosnac-od-0-do-blisko-100-pracownikow-klaudia-duszynska-hollywood-hair/"));
    pressModelSecond.add(PressModel(
        id: "13",
        title: "facebook",
        image: Assets.press13,
        socialLink:
            "https://www.facebook.com/hollywoodhairofficial/videos/429832644322304/?extid=CL-UNK-UNK-UNK-IOS_GK0T-GK1C&ref=sharing"));
    pressModelSecond.add(PressModel(
        id: "14",
        title: "trustedcosmetics",
        image: Assets.press14,
        socialLink:
            "https://www.trustedcosmetics.pl/hollywood-hair-z-jubileuszowym-salonem-i-festiwalem-hairchella/"));
    pressModelSecond.add(PressModel(
        id: "15",
        title: "facebook",
        image: Assets.press15,
        socialLink:
            "https://www.facebook.com/hollywoodhairofficial/videos/527495034770497/?extid=CL-UNK-UNK-UNK-IOS_GK0T-GK1C&ref=sharing"));
    pressModelSecond.add(PressModel(
        id: "16",
        title: "wiadomoscikosmetyczne",
        image: Assets.press16,
        socialLink:
            "https://www.wiadomoscikosmetyczne.pl/biznes-kosmetyki/salon-kosmetyczny/hollywood-hair-otwiera-dwa-nowe-salony-tym-razem-w-lublinie-i-w-lodzi-2491038"));
    pressModelSecond.add(PressModel(
        id: "17",
        title: "forbes",
        image: Assets.press17,
        socialLink:
            "https://www.forbes.pl/biznes/hollywood-hair-przedluzanie-wlosow-nowym-trendem-na-rynku-beauty/jvq54gg"));
    pressModelSecond.add(PressModel(
        id: "18",
        title: "zatrzymajmlodosc",
        image: Assets.press18,
        socialLink:
            "https://www.zatrzymajmlodosc.pl/styl-zycia/item/742-planujesz-jeszcze-urlop-pamietaj-o-ochronie-wlosow"));
  }

  transformation() {
    transformationsModel.add(PressModel(
        id: "1", title: "title", image: Assets.trans1, socialLink: ""));
    transformationsModel.add(PressModel(
        id: "1", title: "title", image: Assets.trans2, socialLink: ""));
    transformationsModel.add(PressModel(
        id: "1", title: "title", image: Assets.trans3, socialLink: ""));
    transformationsModel.add(PressModel(
        id: "1", title: "title", image: Assets.trans4, socialLink: ""));
    transformationsModel.add(PressModel(
        id: "1", title: "title", image: Assets.trans5, socialLink: ""));
    transformationsModel.add(PressModel(
        id: "1", title: "title", image: Assets.trans6, socialLink: ""));
    transformationsModel.add(PressModel(
        id: "1", title: "title", image: Assets.trans7, socialLink: ""));
    transformationsModel.add(PressModel(
        id: "1", title: "title", image: Assets.trans8, socialLink: ""));
    transformationsModel.add(PressModel(
        id: "1", title: "title", image: Assets.trans9, socialLink: ""));
    transformationsModel.add(PressModel(
        id: "1", title: "title", image: Assets.trans10, socialLink: ""));
  }

// allTransformationApi() async {
//   try {
//     isPageLoad.value = true;
//     AllTransformationsModel allTransformationsModel =  await ApiProvider.base().funGetAllTransformations();
//     if(allTransformationsModel.result == 1){
//       print("hiiiiii${allTransformationsModel.data}");
//       isPageLoad.value = false;
//       transformationData.value = allTransformationsModel.data!;
//     }
//
//   } catch (exception) {
//     isPageLoad.value = false;
//   }
// }

  scrollPressFirst() {
    const scrollDuration = Duration(seconds: 5);

    Timer.periodic(scrollDuration, (timer) {
      if (scrollControllerFirst.hasClients) {
        final maxExtent = scrollControllerFirst.position.maxScrollExtent;
        final currentPosition = scrollControllerFirst.position.pixels;
        if (currentPosition >= maxExtent) {
          Timer(Duration(seconds: 1), () {
            // _scrollController.animateTo(0.0, duration: scrollDuration, curve: Curves.linear);
            // canJumpToFirstPosition = false;

            scrollControllerFirst.jumpTo(0.0);
          });
        } else {
          scrollControllerFirst.animateTo(
            currentPosition + 200.0, // Adjust the scroll distance as needed
            duration: scrollDuration,
            curve: Curves.linear,
          );
        }
      }
    });
  }

  scrollPressSecond() {
    const scrollDuration = Duration(seconds: 5);

    Timer.periodic(scrollDuration, (timer) {
      if (scrollControllerSecond.hasClients) {
        final maxExtent = scrollControllerSecond.position.maxScrollExtent;
        final currentPosition = scrollControllerSecond.position.pixels;
        if (currentPosition >= maxExtent) {
          Timer(Duration(seconds: 1), () {
            // _scrollController.animateTo(0.0, duration: scrollDuration, curve: Curves.linear);
            // canJumpToFirstPosition = false;

            scrollControllerSecond.jumpTo(0.0);
          });
        } else {
          scrollControllerSecond.animateTo(
            currentPosition + 200.0, // Adjust the scroll distance as needed
            duration: scrollDuration,
            curve: Curves.linear,
          );
        }
      }
    });
  }

  void autoScroll() {
    Future.delayed(const Duration(seconds: 3), () {
      if (pageController.page! < currentPage - 1) {
        pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeIn,
        );
      } else {
        pageController.jumpToPage(0);
      }
      autoScroll();
    });
  }
}
