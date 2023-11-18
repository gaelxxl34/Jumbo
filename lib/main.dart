import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:jumbo/features/views/user_view/user_home/home_navbar.dart';
import 'package:jumbo/repository/authentification_repository/authentification_repository.dart';
import 'package:jumbo/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app.dart';
import 'features/authentication/controllers/network controllers/dependency_injection.dart';
import 'features/authentication/controllers/network controllers/network_controller.dart';
import 'features/authentication/controllers/network controllers/network_listener.dart';
import 'features/web version/home page/web_home_page.dart';
import 'firebase_options.dart';
import 'translation_service.dart';


late SharedPreferences sharedPreferences;

Future<void> main() async {
  Widget initialScreen = kIsWeb ? const App()  : const WebHomePage();
  WidgetsFlutterBinding.ensureInitialized();
  sharedPreferences = await SharedPreferences.getInstance();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Get.putAsync(() async => AuthentificationRepository());
  print('Is Web: ${kIsWeb}');
  DependencyInjection.init();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);



  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NetworkListener()),
        // Add other providers here if needed
      ],
      child: initialScreen,
    ),
  );
}




