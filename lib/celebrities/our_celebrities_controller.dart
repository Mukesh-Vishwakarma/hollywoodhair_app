import 'package:get/get.dart';
import 'package:hollywood_hair/model/all_transformations_model.dart';
import '../../api_provider/api_provider.dart';
import '../model/celebrities_model.dart';
import '../util/assets.dart';

class CelebritiesController extends GetxController {
  RxList<TransformationsData> transformationData = <TransformationsData>[].obs;
  var isPageLoad = true.obs;
  var celebritiesModel = <CelebritiesModel>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    celebrities();
    isPageLoad.value = false;
    super.onInit();
  }

  Future<void> delayedFunction() async {
    await Future.delayed(const Duration(seconds: 2));
    isLoading.value = false;
  }

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

}
