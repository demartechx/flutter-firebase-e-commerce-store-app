


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/common/widgets/loaders/animation_loader.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';

///A utility class for managing a full-screen loading dialog
class TFullScreenLoader {
///open a full-screen loaidng dialog with a given text and animation
///
///Prarameters:
/// - text: The text to be displayed in the loading dialog
///  - animation: The Lottie animation to be shown



static void openLoadingDialog(String text, String animation) {
  showDialog(
    context: Get.overlayContext!, 
    barrierDismissible: false,
    useSafeArea: false,
    builder: (_) => PopScope(
      canPop: false,
      child: Container(
        color: THelperFunctions.isDarkMode(Get.context!) ? TColors.dark : TColors.white,
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            const SizedBox(height: 250,),
            TAnimationLoaderWidget(text: text, animation: animation,)
          ],
        ),
      )
      ),
    );
}

///stop the currently open loading dialog
///The method doesn't return anuthing
static stopLoading(){
  Navigator.of(Get.overlayContext!).pop(); //close the dialog using the navigator
}



}