import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';

import '../../../../common_widget/global_login/login_page.dart';
import '../../../../common_widget/onboarding_screen/custom_sliverappbar.dart';
import '../../../../common_widget/otp_screen/otp_screen.dart';
import '../../../../translation_service.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../../utils/validators/validation.dart';
import '../../../authentication/controllers/auth/signup_controller.dart';
import '../../../authentication/models/user_model.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpController());
    final size = MediaQuery.of(context).size;
    final orientation = MediaQuery.of(context).orientation;


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
                      child: Image(image: AssetImage(TImages.appLogo), width: size.width * 0.25, height: size.height * 0.25,), // Increase the size of the icon as needed
                    ),
                    Positioned(
                      bottom: 5, // Position the text at the bottom of the AppBar
                      left: 0,
                      right: 0,
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(TTexts.logoText, style: Theme.of(context).textTheme.headlineSmall),
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
                children: [
                  SizedBox(height: TSizes.lg,),
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(TTexts.signTitle, style: Theme.of(context).textTheme.headlineMedium),
                        SizedBox(height: TSizes.lg,),
                        TextFormField(
                          controller: controller.lastname,
                          validator: (value){
                            return TValidator.validateUsername(value);
                          },
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.person_pin),
                            hintText: (TTexts.username),
                          ),
                        ),
                        SizedBox(height: TSizes.sm,),
                        TextFormField(
                          keyboardType: TextInputType.phone,
                          controller: controller.phoneN,
                          validator: (value){
                            return TValidator.validateNumber(value);
                          },
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.phone),
                            hintText: '+256',
                          ),
                        ),
                        SizedBox(height: TSizes.sm,),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: controller.email,
                          validator: (value){
                            return TValidator.validateEmail(value);
                          },
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.email),
                            hintText: TTexts.email,
                          ),
                        ),
                        SizedBox(height: TSizes.sm,),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                              onPressed: (){

                                if (_formKey.currentState!.validate()) {
                                  final users = UserModel(
                                    userName: controller.lastname.text.trim(),
                                    email: controller.email.text.trim(),
                                    Phone: controller.phoneN.text.trim(),
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Processing Data.....'), backgroundColor: TColors.black,),
                                  );
                                  SignUpController.instance.createUser(users);
                                }

                              },
                              child: Text(TTexts.otpGet)
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: TSizes.sm,),
                  TextButton(
                    onPressed: () {
                      Get.to(()=> LoginPage());
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(TTexts.signupBottom, style: Theme.of(context).textTheme.bodyMedium),
                        SizedBox(width: 3,),
                        Text(TTexts.tConnect.toUpperCase(),   style: TextStyle(color: TColors.primary, fontWeight: FontWeight.bold, fontSize: 13)),

                      ],
                    ),
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
