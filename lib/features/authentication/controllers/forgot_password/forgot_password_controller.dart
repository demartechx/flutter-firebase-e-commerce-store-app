

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:t_store/common/widgets/loaders/loaders.dart';
import 'package:t_store/data/repositories/authentication/authentication_repository.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/network/network_manager.dart';
import 'package:t_store/utils/validators/popups/full_screen_loader.dart';

import '../../screens/password_configuration/reset_password.dart';

class ForgotPasswordController extends GetxController {
  static ForgotPasswordController get instance => Get.find();

  //Variables
  final email = TextEditingController();
  GlobalKey<FormState> forgotPasswordFormKey = GlobalKey<FormState>();

  //send reset password email
  sendPasswordResetEmail () async {
    try{
         //start loading
      TFullScreenLoader.openLoadingDialog(
          'Login you in...', TImages.docerAnimation);

      //check internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected){
      //Remove Loader
      TFullScreenLoader.stopLoading();
      return;
      }

      //form validation
      if (!forgotPasswordFormKey.currentState!.validate()){
        //Remove Loader
      TFullScreenLoader.stopLoading();
      return;
      }

      //register user in the firebase authentication & save user data in firebase
      await AuthenticationRepository.instance.sendPasswordResetEmail(
          email.text.trim());

      //Remove Loader
      TFullScreenLoader.stopLoading();

      //show success screen
      TLoaders.successSnackBar(title: 'Email sent', message: 'Email link sent to reset your password');

      //Redirect
      Get.to(()=> ResetPassword(email: email.text.trim()));


    } catch (e) {
      //Remove loader
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
      
    }

  }

  resendPasswordResetEmail(String email) async {
    try{
         //start loading
      TFullScreenLoader.openLoadingDialog(
          'Procesing your request...', TImages.docerAnimation);

      //check internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected){
      //Remove Loader
      TFullScreenLoader.stopLoading();
      return;
      }

      //register user in the firebase authentication & save user data in firebase
      await AuthenticationRepository.instance.sendPasswordResetEmail(
          email);

      //Remove Loader
      TFullScreenLoader.stopLoading();

      //show success screen
      TLoaders.successSnackBar(title: 'Email sent', message: 'Email link sent to reset your password');


    } catch (e) {
      //Remove loader
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
      
    }
  }

}