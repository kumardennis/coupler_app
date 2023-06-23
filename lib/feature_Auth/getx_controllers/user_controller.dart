import 'package:get/get.dart';

import '../models/user_model.dart';

class UserController extends GetxController {
  var user = UserModel(0, '', '', '', '', '', '', '', '', '').obs;

  loadUser(UserModel updatedUser) => user.value = updatedUser;
}
