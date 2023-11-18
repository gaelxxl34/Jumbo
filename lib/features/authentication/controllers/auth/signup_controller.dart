import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jumbo/common_widget/global_login/login_page.dart';
import 'package:jumbo/common_widget/otp_screen/otp_screen.dart';
import 'package:jumbo/features/views/user_view/user_auth_services/signup.dart';
import 'package:jumbo/utils/constants/colors.dart';

import '../../../../repository/authentification_repository/authentification_repository.dart';
import '../../../../repository/user_repository/user_repository.dart';
import '../../models/user_model.dart';


class SignUpController extends GetxController{
  static SignUpController get instance => Get.find();


  // textfield to get the data from the sign up textfield
  final phoneN = TextEditingController();
  final firstname = TextEditingController();
  final lastname = TextEditingController();
  final email = TextEditingController();

  final UserRepo = Get.put(UserRepository());
  final AuthRepo = Get.put(AuthentificationRepository());


//-- this is a method for login screen
  Future<void> phoneAuthentification(String phoneNumber) async{
    final UserLogin = await AuthRepo.findUserNo(phoneNumber);
    print('hello '+phoneNumber);
    if(UserLogin > 0){
      AuthentificationRepository.instance.phoneAuthentification(phoneNumber);
      Get.to(() => OtpScreen(PhoneNum: phoneN.text,));
    }else {
      Get.snackbar("Veuillez vous inscrire", "Numéro de téléphone inconnu", colorText: TColors.primary, duration: Duration(seconds: 3));
      Get.to(() => SignUpPage());
    }

  }

  // -- the function below help to get the user data for sign up screen
  Future<void> createUser(UserModel user) async {
    //check if phone number is taken
    final usersFound = await UserRepo.findUsers(user.Phone);
    print('hello '+user.Phone);
    if(usersFound > 0) {
      Get.snackbar("Veuillez vous connecter", "Le numéro de téléphone existe déjà", colorText: TColors.primary, duration: Duration(seconds: 3));
      Get.to(() => LoginPage());
    }else {
      print('hello new userfound'+user.Phone);
      phoneAuthentificationSignUp(user.Phone);
      Get.to(() => OtpScreen(PhoneNum: phoneN.text,));
      await UserRepo.createUser(user);
    }
  }
  void phoneAuthentificationSignUp(String PhoneNo) {
    AuthentificationRepository.instance.phoneAuthentification(PhoneNo);
  }

}




