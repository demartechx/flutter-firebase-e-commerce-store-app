

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:t_store/common/widgets/loaders/loaders.dart';
import 'package:t_store/data/repositories/user/user_repository.dart';
import 'package:t_store/features/authentication/models/user_model.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  final userRepository = Get.put(UserRepository());

  /// save user record from any registeration provider

  Future<void> saveUserRecord(UserCredential? userCredentials) async {
    try{
      if(userCredentials != null){
        // Convert name to first and last name
        final nameParts = UserModel.nameParts(userCredentials.user!.displayName ?? '');
        final username = UserModel.generateUsername(userCredentials.user!.displayName ?? '');

        // Map Data
        final user = UserModel(
        id: userCredentials.user!.uid, 
        username: username, 
        email: userCredentials.user!.email ?? '', 
        firstName: nameParts[0], 
        lastName: nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '', 
        phoneNumber: userCredentials.user!.phoneNumber ?? '', 
        profilePicture: userCredentials.user!.photoURL ?? ''
        );

        //dave user data
        await userRepository.saveUserRecord(user);
      }
      
    } catch (e) {
      TLoaders.warningSnackBar(title: 'Data not saved', message: 'Something went wrong while saving your information. You can re-save your data in your profile',);
    }
  }
}