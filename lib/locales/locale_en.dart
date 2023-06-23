import 'package:coupler_app/feature_Reminders/locales/en_locale.dart';
import 'package:get/get.dart';

import '../feature_Auth/locales/en_locale.dart';
import '../feature_Dashboard/locales/en_locale.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          'hello': 'Hello World',
          'lbl_Home': 'Home',
          'lbl_Ok': 'Ok',
          'lbl_Cancel': 'Cancel',
          ...authLocales_EN,
          ...dashboardLocales_EN,
          ...remindersLocales_EN
        },
        'et_EE': {
          'hello': 'Hallo Welt',
        }
      };
}
