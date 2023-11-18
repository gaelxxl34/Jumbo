import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:jumbo/features/authentication/controllers/network%20controllers/network_listener.dart';
import 'package:jumbo/translation_service.dart';
import 'package:jumbo/utils/constants/text_strings.dart';
import 'package:jumbo/utils/theme/theme.dart';
import 'package:provider/provider.dart';
import 'common_widget/global_login/login_page.dart';
import 'common_widget/onboarding_screen/screen_one.dart';
import 'features/authentication/controllers/network controllers/network_controller.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NetworkListener()),
        Provider(create: (_) => NetworkController()), // Your NetworkController
      ],
      child: GetMaterialApp(
        title: TTexts.appName,
        themeMode: ThemeMode.system,
        theme: TAppTheme.lightTheme,
        darkTheme: TAppTheme.darkTheme,
        debugShowCheckedModeBanner: false,
        home: OnboardingScreenOne(),

      ),
    );
  }
}

