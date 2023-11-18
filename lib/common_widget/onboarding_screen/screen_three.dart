import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'dart:math' as math;

import 'package:jumbo/common_widget/onboarding_screen/slanding_method.dart';
import 'package:jumbo/utils/constants/colors.dart';
import 'package:jumbo/utils/constants/image_strings.dart';
import 'package:jumbo/utils/constants/text_strings.dart';

import '../../utils/constants/sizes.dart';
import '../global_login/login_page.dart';

class OnboardingScreenThree extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                  height: size.height * 0.6,
                  fit: BoxFit.cover,
                  image: AssetImage(TImages.onBoardingImage3),
                ),
                Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.rotationY(math.pi),
                  child: ClipPath(
                    clipper: SlandingClipper(),
                    child: Container(
                      height: size.height * 0.4,
                      color: TColors.primary,
                    ),
                  ),
                )
              ],
            ),
            Positioned(
              top: size.height * 0.65,
              child: Container(
                width: size.width,
                padding: EdgeInsets.all(TSizes.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      TTexts.onBoardingTitle3,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    Text(
                      TTexts.onBoardingSubTitle3,
                      textAlign: TextAlign.start,
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
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: TSizes.lg / 4),
                    width: 15,
                    height: 15,
                    decoration: BoxDecoration(
                        border: Border.all(color: TColors.dark, width: 2),
                        shape: BoxShape.circle,
                        color: TColors.white),
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
                        Get.to(()=> LoginPage());
                      },
                      backgroundColor: Theme.of(context).brightness == Brightness.light ? Colors.black45 : Colors.white70,
                      child: Icon(
                        color: Theme.of(context).brightness == Brightness.light ? Colors.white : Colors.black,
                        Icons.done_rounded,
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