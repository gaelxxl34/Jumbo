import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:jumbo/common_widget/otp_screen/otp_screen.dart';
import 'package:jumbo/utils/constants/image_strings.dart';
import 'package:jumbo/utils/validators/validation.dart';
import 'package:provider/provider.dart';


import '../../features/authentication/controllers/auth/signup_controller.dart';
import '../../features/views/user_view/user_auth_services/signup.dart';
import '../../translation_service.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/sizes.dart';
import '../../utils/constants/text_strings.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
                        Text(TTexts.loginTitle, style: Theme.of(context).textTheme.headlineMedium),
                        // Text( as String, ),
                        SizedBox(height: TSizes.lg,),
                        TextFormField(
                          keyboardType: TextInputType.phone,
                          controller: controller.phoneN,
                            validator: (value){
                               return TValidator.validateNumber(value);
                            },
                            decoration: InputDecoration(
                            prefixIcon: Icon(Icons.phone),
                            hintText: '+243',
                          ),
                        ),
                        SizedBox(height: TSizes.sm,),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                              onPressed: (){
                                if (_formKey.currentState!.validate()) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Processing Data.....'), backgroundColor: TColors.black,),
                                  );
                                  SignUpController.instance.phoneAuthentification(controller.phoneN.text.trim());
                                }
                              },
                              child: Text(TTexts.otpGet),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: TSizes.sm,),
                  TextButton(
                    onPressed: () {
                      Get.to(()=> SignUpPage());
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(TTexts.loginBottom, style: Theme.of(context).textTheme.bodyMedium),
                        SizedBox(width: 3,),
                        Text(TTexts.tCreate.toUpperCase(),   style: TextStyle(color: TColors.primary, fontWeight: FontWeight.bold, fontSize: 13)),

                      ],
                    )
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
