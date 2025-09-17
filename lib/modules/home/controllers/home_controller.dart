import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final RxString heroTitle = 'Hi, I’m Gufran'.obs;
  final RxString heroSubtitle = 'A passionate developer crafting innovative solutions'.obs;
  final RxString ctaButtonText = 'View My Work'.obs;

  final VoidCallback? onViewWorkCallback;

  HomeController({this.onViewWorkCallback});

  void onViewWork() {
    onViewWorkCallback?.call();
  }

  @override
  void onInit() {
    super.onInit();
  
  }

  @override
  void onClose() {
    super.onClose();
  }
}
