import 'package:coupler_app/feature_Reminders/locales/en_locale.dart';
import 'package:get/get.dart';

import '../feature_Auth/locales/en_locale.dart';
import '../feature_Dashboard/locales/en_locale.dart';
import '../feature_GetAcquainted/locales/en_locale.dart';
import '../feature_UsSettings/locales/en_locale.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          'hello': 'Hello World',
          'lbl_Home': 'Home',
          'lbl_Ok': 'Ok',
          'lbl_Cancel': 'Cancel',
          'hd_Us': 'Us',
          'btn_Close': 'Close',
          'btn_Add': 'Add',
          'hd_Settings': 'Settings',
          ...authLocales_EN,
          ...dashboardLocales_EN,
          ...remindersLocales_EN,
          ...getAcquaintedLocales_EN,
          ...usSettingsLocales_EN,
        },
        'et_EE': {
          'hello': 'Hallo Welt',
        }
      };
}
