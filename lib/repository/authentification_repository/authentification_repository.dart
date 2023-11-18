import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jumbo/common_widget/global_login/login_page.dart';
import 'package:jumbo/common_widget/onboarding_screen/screen_one.dart';
import 'package:jumbo/features/views/user_view/user_home/home_navbar.dart';



class AuthentificationRepository extends GetxController{
  static AuthentificationRepository get instance => Get.find();

  // variables
  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;
  var verificationId = ''.obs;
  final _db = FirebaseFirestore.instance;

  // Add a method to initialize the firebaseUser field
  void initializeFirebaseUser() {
    firebaseUser.value = _auth.currentUser;
  }


  @override
  void onReady() {
    Future.delayed(Duration(seconds: 5));
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, _setIniationScreen);
    // setIniationScreen(firebaseUser.value);
  }


  _setIniationScreen(User? user) {
    user == null ? Get.offAll(() => const HomeNavbar()) : Get
        .offAll(() => const HomeNavbar());
  }

  Future<void> phoneAuthentification(String PhoneNo) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: PhoneNo,
        verificationCompleted: (credential) async {
        await _auth.signInWithCredential(credential);
        },
        codeSent: (verificationId, resendToken){
        this.verificationId.value = verificationId;
        },
        codeAutoRetrievalTimeout: (verificationId){
        this.verificationId.value = verificationId;
        },
        verificationFailed: (e){
        if(e.code == "invalid-phone-number"){
          Get.snackbar("Erreur", "Le numéro fourni n\'est pas valide");
        }
        else {
          Get.snackbar('Erreur', 'Relaxe et reessaye plus tard', colorText: Colors.red, duration: Duration(seconds: 3));
        }
        },
    );
  }

  Future<int> findUserNo(String Phone) async{
    final snapshot = await _db.collection('Users').where("PhoneNo", isEqualTo: Phone).get();
    return snapshot.docs.length;
  }

  Future<bool> verifyOTP(String otp) async{
    var credentials = await _auth.
    signInWithCredential(PhoneAuthProvider.credential(verificationId: this.verificationId.value, smsCode: otp));
    return credentials.user != null ? true : false;
  }




// log out function
    Future<void> logout() async => await _auth.signOut();


}