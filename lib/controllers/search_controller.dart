import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearcheController extends GetxController {
  final TextEditingController searchController = TextEditingController();
  final RxBool isShowUsers = false.obs;

  @override
  void onClose() {
    super.onClose();
    searchController.dispose();
  }

  void onFieldSubmitted() {
    if (searchController.text.isNotEmpty) {
      isShowUsers.value = true;
    } else {
      isShowUsers.value = false;
    }
  }
}
