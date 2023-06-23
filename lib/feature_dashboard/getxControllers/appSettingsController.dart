import 'package:get/get.dart';

import '../models/app_settings_model.dart';

class AppSettingsController extends GetxController {
  var appSettings = AppSettingsModel(false, false).obs;

  changeAppSettings(AppSettingsModel updateSettings) =>
      appSettings.value = updateSettings;
}
