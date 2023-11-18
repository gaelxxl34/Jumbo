
import 'package:get/get.dart';
import 'package:jumbo/features/views/user_view/user_home/home_navbar.dart';

import '../../../../repository/authentification_repository/authentification_repository.dart';



class OTPController extends GetxController{
  static OTPController instance = Get.find();

  void verifyOTP(String otp) async{
    var isVerify = await AuthentificationRepository.instance.verifyOTP(otp);
    isVerify ? Get.offAll(const HomeNavbar()) : Get.back();
  }

}
