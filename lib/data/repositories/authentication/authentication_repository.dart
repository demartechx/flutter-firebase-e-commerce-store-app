import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:t_store/data/repositories/user/user_repository.dart';
import 'package:t_store/features/authentication/screens/login/login.dart';
import 'package:t_store/features/authentication/screens/onboarding/onboarding.dart';
import 'package:t_store/features/authentication/screens/signup/verify_email.dart';
import 'package:t_store/navigation_menu.dart';
import 'package:t_store/utils/exceptions/firebase_auth_exception.dart';
import 'package:t_store/utils/exceptions/firebase_exception.dart';
import 'package:t_store/utils/exceptions/format_exception.dart';
import 'package:t_store/utils/exceptions/platform_exceptions.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  //variables
  final deviceStorage = GetStorage();
  final _auth = FirebaseAuth.instance;

//get authenticated user data
  User? get authUser => _auth.currentUser;

  //called from main.dart an app launch
  @override
  void onReady() {
    FlutterNativeSplash.remove();
    
    screenRedirect();
    
   
   super.onReady();
  }

  //function to show relevant screen
  screenRedirect() {
    final user = _auth.currentUser;

    if(user != null){
      if(user.emailVerified){
       //_auth.signOut;
       //Get.offAll(() =>  const LoginScreen());
       //print(user.email);
        Get.offAll(() => const NavigationMenu());
      }else {
      Get.offAll(()=> VerifyEmailScreen(email: _auth.currentUser?.email));
    }
    } else {
     

    deviceStorage.writeIfNull('IsFirstTime', true);
    deviceStorage.read('IsFirstTime') != true ? Get.offAll(() =>  const LoginScreen()) : Get.offAll( const OnBoardingScreen());
    
    }
  }



  /*------------------------------------------------ Email & Password sign-in ----------------------------------------*/

  //Email Authentication - login

  Future<UserCredential> loginWithEmailAndPassword(String email, String password) async {
    try{
      return await _auth.signInWithEmailAndPassword(email: email, password: password);
      
    } on FirebaseAuthException catch (e) {
      //throw 'Something went wrong. Please try again ${e.code}';
      throw TFirebaseAuthException(e.code).message;

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

  // Re-authenticate user

  Future<void> reAutheticateEmailAndPassword(String email, String password) async {
    try{
      //create a credential
      AuthCredential credential = EmailAuthProvider.credential(email: email, password: password);

      //Re authenticate
      await _auth.currentUser!.reauthenticateWithCredential(credential);
      
    } on FirebaseAuthException catch (e) {
      //throw 'Something went wrong. Please try again ${e.code}';
      throw TFirebaseAuthException(e.code).message;

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

  //Email authentication - Register

  Future<UserCredential> registerWithEmailAndPassword(String email, String password) async {
    try{
      return await _auth.createUserWithEmailAndPassword(email: email, password: password);
      
    } on FirebaseAuthException catch (e) {
      //throw 'Something went wrong. Please try again ${e.code}';
      throw TFirebaseAuthException(e.code).message;

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


  /// Email verification
  Future<void> sendEmailVerification() async {
    try{
       await _auth.currentUser?.sendEmailVerification();
      
    } on FirebaseAuthException catch (e) {
      //throw 'Something went wrong. Please try again ${e.code}';
      throw TFirebaseAuthException(e.code).message;

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


  //forgot password
  Future<void> sendPasswordResetEmail(String email) async {
    try{
       await _auth.sendPasswordResetEmail(email: email);
      
    } on FirebaseAuthException catch (e) {
      //throw 'Something went wrong. Please try again ${e.code}';
      throw TFirebaseAuthException(e.code).message;

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




  ///GOOGLE signin
  Future<UserCredential> signInWithGoolgle() async {
    try{
       //Trigger the authentication flow
       final GoogleSignInAccount? userAccount = await GoogleSignIn().signIn();

      //Obtain the auth details from the request
       final GoogleSignInAuthentication? googleAuth =  await userAccount?.authentication;

       // Create a new credential
       final credentials = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken
       );

       // Once signed in, return the UserCredential
       return await _auth.signInWithCredential(credentials);
      
    } on FirebaseAuthException catch (e) {
      //throw 'Something went wrong. Please try again ${e.code}';
      throw TFirebaseAuthException(e.code).message;

    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;

    } on FormatException catch (_) {
        throw const TFormatException();

    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;

    } catch (e) {
      if(kDebugMode) print('Something went wrong. $e');
      throw 'Something went wrong. $e';
      //return;
    }
  }


  ///Loutout user
  Future<void> logout() async {
    try{
       await _auth.signOut();
       Get.offAll(()=> const LoginScreen());
      
    } on FirebaseAuthException catch (e) {
      //throw 'Something went wrong. Please try again ${e.code}';
      throw TFirebaseAuthException(e.code).message;

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


  ///delete user - remove user auth and firestore account
  Future<void> deleteAccount() async {
    try{
      final repo = Get.put(UserRepository());

      await repo.removeUserRecord(_auth.currentUser!.uid);
       await _auth.currentUser?.delete();
      
    } on FirebaseAuthException catch (e) {
      //throw 'Something went wrong. Please try again ${e.code}';
      throw TFirebaseAuthException(e.code).message;

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