

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/features/authentication/screens/login/login.dart';

class OnBoardingController extends GetxController {
  
  static OnBoardingController get instance => Get.find();

  //variables
  final pageController = PageController();
  Rx<int> currentPageIndex = 0.obs;


  //update currrent index when page scroll
  void updatePageIndicator(index) => currentPageIndex.value = index;
  

  //jump to the specific dot selected page
  void dotNavigationClick(index) {
    currentPageIndex.value =index;
    pageController.jumpToPage(index);
  }

  //update current index & jump to next page
  void nextPage(index) {
    if(currentPageIndex.value == 2){
      Get.offAll(const LoginScreen());
    }else{
      int page = currentPageIndex.value + 1;
      pageController.jumpToPage(page);
    }

  }

  //update current index and jump to the last page
  void skipPage(index) {
    // currentPageIndex.value = 2;
    // pageController.jumpToPage(2);
    Get.offAll(const LoginScreen());
  }

}