import 'package:coupler_app/color_scheme.dart';
import 'package:coupler_app/feature_Dashboard/screens/dashboard.dart';
import 'package:coupler_app/feature_Navigation/screens/home_container.dart';
import 'package:coupler_app/feature_Reminders/screens/first_survey.dart';
import 'package:coupler_app/feature_Reminders/screens/questionnaire_intro.dart';
import 'package:coupler_app/feature_Reminders/screens/reminders_screens.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'feature_Auth/screens/sign_in.dart';
import 'feature_Navigation/getxControllers/navigation_controller.dart';
import 'feature_UsSettings/getXControllers/user_settings_controller.dart';
import 'locales/locale_en.dart';

void main() async {
  await dotenv.load(fileName: "../.env");
  await Supabase.initialize(
      url: 'http://localhost:64321',
      anonKey: dotenv.env['SUPABASE_LOCAL_ANON_KEY'] ?? '');
  Get.put(NavigationController());
  runApp(MyApp(
    home: SignIn(),
  ));
}

class MyApp extends StatelessWidget {
  MyApp({@required this.home});
  final home;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final UserSettingsController userSettingsController = Get.find();

    return Obx(
      () => GetMaterialApp(
        scrollBehavior: MyCustomScrollBehavior(),
        translations: AppTranslations(),
        locale: const Locale('en', 'US'),
        title: 'Flutter Demo',
        theme: ThemeData(
            primarySwatch: Colors.blue,
            textTheme: GoogleFonts.barlowTextTheme(TextTheme(
                displayLarge: TextStyle(
                    fontSize: 32.0,
                    color: userSettingsController.user.value.darkMode
                        ? Theme.of(context).colorScheme.light
                        : Theme.of(context).colorScheme.dark),
                displayMedium: TextStyle(
                    fontSize: 24.0,
                    color: userSettingsController.user.value.darkMode
                        ? Theme.of(context).colorScheme.light
                        : Theme.of(context).colorScheme.dark),
                displaySmall: TextStyle(
                    fontSize: 18.0,
                    color: userSettingsController.user.value.darkMode
                        ? Theme.of(context).colorScheme.light
                        : Theme.of(context).colorScheme.dark),
                bodyLarge: TextStyle(
                    fontSize: 18,
                    color: userSettingsController.user.value.darkMode
                        ? Theme.of(context).colorScheme.light
                        : Theme.of(context).colorScheme.dark),
                bodyMedium: TextStyle(
                    fontSize: 16.0,
                    color: userSettingsController.user.value.darkMode
                        ? Theme.of(context).colorScheme.light
                        : Theme.of(context).colorScheme.dark),
                bodySmall: TextStyle(
                    fontSize: 14.0,
                    color: userSettingsController.user.value.darkMode
                        ? Theme.of(context).colorScheme.light
                        : Theme.of(context).colorScheme.dark),
                headlineLarge: TextStyle(fontSize: 32, color: userSettingsController.user.value.darkMode ? Theme.of(context).colorScheme.lightPink : Theme.of(context).colorScheme.darkPink),
                headlineMedium: TextStyle(fontSize: 24.0, color: userSettingsController.user.value.darkMode ? Theme.of(context).colorScheme.lightPink : Theme.of(context).colorScheme.darkPink),
                headlineSmall: TextStyle(fontSize: 18.0, color: userSettingsController.user.value.darkMode ? Theme.of(context).colorScheme.lightPink : Theme.of(context).colorScheme.darkPink)))),
        home: home,
        initialRoute: '/sign-in',
        getPages: [
          GetPage(name: '/sign-in', page: () => SignIn()),
          GetPage(name: '/home-screen', page: () => HomeContainer()),
          GetPage(name: '/dashboard', page: () => Dashboard()),
        ],
      ),
    );
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        // etc.
      };
}
