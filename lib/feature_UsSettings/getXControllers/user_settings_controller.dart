import 'package:get/get.dart';

import '../models/user_settings.dart';

class UserSettingsController extends GetxController {
  var user = UserSettings(darkMode: false, blueAccent: false).obs;

  loadUser(UserSettings updatedUser) => user.value = updatedUser;
}
