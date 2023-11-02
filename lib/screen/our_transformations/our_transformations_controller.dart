import 'package:get/get.dart';
import 'package:hollywood_hair/model/all_transformations_model.dart';
import 'package:hollywood_hair/util/assets.dart';
import '../../api_provider/api_provider.dart';
import '../../model/salon_model.dart';

class OurTransformationsController extends GetxController {
  RxList<TransformationsData> transformationData = <TransformationsData>[].obs;
  var isPageLoad = true.obs;

  @override
  void onInit() {
    allTransformationApi();
    super.onInit();
  }

  //  ****** all Transformations

  allTransformationApi() async {
    try {
      AllTransformationsModel allTransformationsModel =
          await ApiProvider.base().funGetAllTransformations();
      if (allTransformationsModel.result == 1) {
        print("hiiiiii${allTransformationsModel.data}");
        transformationData.value = allTransformationsModel.data!;
      }
      isPageLoad.value = false;
    } catch (exception) {
      isPageLoad.value = false;
    }
  }
}
