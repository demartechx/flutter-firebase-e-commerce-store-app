import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:t_store/data/repositories/authentication/authentication_repository.dart';
import 'package:t_store/features/authentication/models/user_model.dart';
import 'package:t_store/utils/exceptions/firebase_exception.dart';
import 'package:t_store/utils/exceptions/format_exception.dart';
import 'package:t_store/utils/exceptions/platform_exceptions.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;


  Future<void> saveUserRecord(UserModel user) async {
     
    try{
      return await _db.collection("Users").doc(user.id).set(user.toJson());

    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;

    } on FormatException catch (_) {
        throw const TFormatException();

    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;

    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }


  ///Fetch user details based on user ID
  Future<UserModel> fetchUserDetails() async {
     
    try{
      final documentSnapshot = await _db.collection("Users").doc(AuthenticationRepository.instance.authUser?.uid).get();
      if(documentSnapshot.exists){
        return UserModel.fromSnapshot(documentSnapshot);
      }else{
        return UserModel.empty();
      }

    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;

    } on FormatException catch (_) {
        throw const TFormatException();

    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;

    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  //update user data in firestore
  Future<void> updateUserDetails(UserModel updatedUser) async {
     
    try{
      return await _db.collection("Users").doc(updatedUser.id).update(updatedUser.toJson());

    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;

    } on FormatException catch (_) {
        throw const TFormatException();

    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;

    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }


  //update user data in firestore
  Future<void> updateSingleField(Map<String, dynamic> json) async {
     
    try{
      return await _db.collection("Users").doc(AuthenticationRepository.instance.authUser?.uid).update(json);

    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;

    } on FormatException catch (_) {
        throw const TFormatException();

    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;

    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  //remove user data in firestore
  Future<void> removeUserRecord(String userId) async {
     
    try{
      return await _db.collection("Users").doc(userId).delete();

    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;

    } on FormatException catch (_) {
        throw const TFormatException();

    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;

    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
  

}