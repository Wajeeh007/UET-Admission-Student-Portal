import 'dart:convert';
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:online_admission/model/merit_model.dart';

class MeritListViewModel extends GetxController {

  Rx<Uint8List> csvBytes = Uint8List(0).obs;
  RxList<String> meritListInString = <String>[].obs;
  RxString meritListLink = ''.obs;
  Map<String, dynamic> downloadLinks = <String, dynamic>{};
  RxMap<String, dynamic> downloadLinks1 = <String, dynamic>{}.obs;
  RxBool overlay = false.obs;
  RxList<MeritModel> meritList = <MeritModel>[].obs;

  @override
  void onInit() {
    meritListLink.value = Get.arguments[0]['listLink'];
    getMeritList();
    super.onInit();
  }

  getMeritList() async {
    overlay.value = true;
    final csvRef = FirebaseStorage.instanceFor(
        bucket: 'admissionapp-9c884.appspot.com').refFromURL(
        meritListLink.value);
    await csvRef.getData(104857600).then((value) {
      csvBytes.value = value!;
      final string = String.fromCharCodes(csvBytes.value);
      LineSplitter ls = const LineSplitter();
      meritListInString.value = ls.convert(string);
      meritListInString.forEach((element) {
        List<String> elementSplit = element.split(",");
        meritList.add(MeritModel(meritNumber: elementSplit[0],
            studentName: elementSplit[1],
            fatherName: elementSplit[2],
            aggregate: elementSplit[3],
            eligibility: elementSplit[4]));
        meritList.refresh();
      });
      overlay.value = false;
    });
  }

}