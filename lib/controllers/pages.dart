import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PagesController extends GetxController {
  static PagesController get instance => Get.find();
  late PageController pageController;

  void navigationTapped(int page) {
    pageController.jumpToPage(page);
  }

  @override
  void onInit() {
    pageController = PageController();
    super.onInit();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
