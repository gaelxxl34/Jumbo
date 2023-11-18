import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:jumbo/translation_service.dart';
import '../../features/authentication/controllers/auth/otp_controller.dart';
import '../../features/views/user_view/user_home/home_navbar.dart';
import '../../utils/constants/image_strings.dart';
import '../../utils/constants/sizes.dart';
import '../../utils/constants/text_strings.dart';

class OtpScreen extends StatefulWidget {

  String PhoneNum;

  OtpScreen({required this.PhoneNum});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final orientation = MediaQuery.of(context).orientation;
    var otp;
    var otpController = Get.put(OTPController());
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            pinned: true,
            floating: false,
            flexibleSpace: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                // Calculate the top margin for the icon based on the AppBar's height
                var top = constraints.biggest.height;
                return Stack(
                  children: [
                    Positioned(
                      top: top / 2 - (size.height * 0.125), // Center the icon vertically in the expanded part
                      left: 0,
                      right: 0,
                      child: Image(image: AssetImage(TImages.appLogo), width: size.width * 0.25,height: size.height * 0.25,), // Increase the size of the icon as needed
                    ),
                    Positioned(
                      bottom: 16, // Position the text at the bottom of the AppBar
                      left: 0,
                      right: 0,
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          TTexts.logoText,
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
            // Set a fixed height for the SliverAppBar when collapsed
            collapsedHeight: orientation == Orientation.portrait ? size.height * 0.3 : 160,
          ),

          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.all(TSizes.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: TSizes.lg,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(child: Text(TTexts.otpTitle + " " + widget.PhoneNum, textAlign: TextAlign.center,), ),
                      SizedBox(height: TSizes.md,),
                      OtpTextField(
                        numberOfFields: 6,
                        fillColor: Colors.black.withOpacity(0.1),
                        filled: true,
                        onSubmit: (code){
                          otp = code;
                          OTPController.instance.verifyOTP(otp);
                        },
                      ),
                      SizedBox(height: TSizes.lg,),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                            onPressed: (){ OTPController.instance.verifyOTP(otp);},
                            child: Text(TTexts.tConnect)
                        ),
                      ),
                    ],
                  ),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
