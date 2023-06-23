import 'package:get/get.dart';

import '../../feature_Reminders/screens/reminders_screens.dart';

class NavigationController extends GetxController {
  final currentIndex = 0.obs;

  void changeIndex(int index) {
    currentIndex.value = index;
  }
}
