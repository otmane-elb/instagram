import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PagesController extends GetxController {
  static PagesController get instance => Get.find();
  late Rx<PageController> pageController;
  Rx<int> page = Rx<int>(0);

  void navigationTapped(int page) {
    this.page.value = page;
    pageController.value.jumpToPage(page);
  }

  @override
  void onInit() {
    pageController = Rx<PageController>(PageController());

    super.onInit();
  }

  @override
  void dispose() {
    pageController.value.dispose();
    super.dispose();
  }
}
