import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:jumbo/common_widget/global_login/login_page.dart';
import 'package:jumbo/common_widget/onboarding_screen/screen_two.dart';
import 'package:jumbo/common_widget/onboarding_screen/slanding_method.dart';
import 'package:jumbo/utils/constants/colors.dart';
import 'package:jumbo/utils/constants/text_strings.dart';

import '../../utils/constants/image_strings.dart';
import '../../utils/constants/sizes.dart';




class OnboardingScreenOne extends StatelessWidget {
  const OnboardingScreenOne({super.key});

  @override
  Widget build(BuildContext context) {
    //it will helps to return the size of the screen
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image(
                  width: size.width,
                  height: size.height * 0.5,
                  fit: BoxFit.cover,
                  image: AssetImage(TImages.onBoardingImage1),
                ),
                ClipPath(
                  clipper: SlandingClipper(),
                  child: Container(
                    height: size.height * 0.5,
                    color: TColors.primary,
                  ),
                )
              ],
            ),
            Positioned(
              top: size.height * 0.58,
              child: Container(
                width: size.width,
                padding: EdgeInsets.all(TSizes.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      TTexts.onBoardingTitle1,
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: TColors.white,
                        fontSize: 30,
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    Text(
                      TTexts.onBoardingSubTitle1,
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 15,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: TSizes.lg / 4),
                    width: 15,
                    height: 15,
                    decoration: BoxDecoration(
                        border: Border.all(color: TColors.dark, width: 2),
                        shape: BoxShape.circle,
                        color: TColors.white),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: TSizes.lg / 4),
                    width: 15,
                    height: 15,
                    decoration: BoxDecoration(
                        border: Border.all(color: TColors.dark, width: 2),
                        shape: BoxShape.circle,
                        color: TColors.primary),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: TSizes.lg / 4),
                    width: 15,
                    height: 15,
                    decoration: BoxDecoration(
                        border: Border.all(color: TColors.dark, width: 2),
                        shape: BoxShape.circle,
                        color: TColors.primary),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: TSizes.lg * 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () => Get.to(()=> LoginPage()),
                      child: Text(
                        TTexts.skip,
                          style: Theme.of(context).textTheme.titleLarge
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: TSizes.sm),
                    child: FloatingActionButton(

                      onPressed: (){
                        Get.to(()=> OnboardingScreenTwo());
                      },

                      backgroundColor: Theme.of(context).brightness == Brightness.light ? Colors.black45 : Colors.white70,
                      child: Icon(
                        Icons.navigate_next_rounded,
                        color: Theme.of(context).brightness == Brightness.light ? Colors.white : Colors.black,
                        size: 30,
                      ),
                    ),

                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}