import 'package:get/get.dart';
import 'package:hollywood_hair/model/all_transformations_model.dart';
import 'package:hollywood_hair/util/assets.dart';
import '../../api_provider/api_provider.dart';
import '../../model/salon_model.dart';

class OurTransformationsController extends GetxController {


  RxList<TransformationsData> transformationData = <TransformationsData>[].obs;
  var isPageLoad = true.obs;


  List<SalonModel> salons= <SalonModel>[
    SalonModel(
      image: Assets.salon1,
      address: "Belwederska 44, 00-594 Warszawa",
      location: "Location",
    ),
    SalonModel(
      image: Assets.salon2,
      address: "Wilcza 2/4 00-532 Warszawa",
      location: "Location",
    ),
    SalonModel(
      image: Assets.salon3,
      address: "Jana III Sobieskiego 102A 00-764 Warszawa",
      location: "Location",
    ),
    SalonModel(
      image: Assets.salon4,
      address: "Aleja Niepodległości 727 81-840 Sopot",
      location: "Location",
    ),
    SalonModel(
      image: Assets.salon5,
      address: "plac Wolności 7, 61-738 Poznań",
      location: "Location",
    ),
    SalonModel(
      image: Assets.salon6,
      address: "Altus, Uniwersytecka 13 40-007 Katowice",
      location: "Location",
    ),
    SalonModel(
      image: Assets.salon7,
      address: "Plac Kościuszki 5,50-438 Wrocław",
      location: "Location",
    ),
    SalonModel(
      image: Assets.salon8,
      address: "Street Krzywoustego 80, 70-245 Szczecin",
      location: "Location",
    ),
    SalonModel(
      image: Assets.salon9,
      address: "Zwierzyniecka 30/5,31-105 Kraków",
      location: "Location",
    ),
  ];


  @override
  void onInit() {
    allTransformationApi();
    super.onInit();
  }




  //  ****** all Transformations

  allTransformationApi() async {
    try {
      isPageLoad.value = true;
      AllTransformationsModel allTransformationsModel =  await ApiProvider.base().funGetAllTransformations();
      if(allTransformationsModel.result == 1){
        print("hiiiiii${allTransformationsModel.data}");
        isPageLoad.value = false;
        transformationData.value = allTransformationsModel.data!;
      }

    } catch (exception) {
      isPageLoad.value = false;
    }
  }
}
