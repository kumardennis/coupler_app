import 'package:get/get.dart';

import '../models/couple_model.dart';

class CoupleController extends GetxController {
  var couple = CoupleModel(
          id: 0,
          isActive: false,
          partner1: null,
          partner2: null,
          isAccepted: false,
          initiatedById: 0)
      .obs;
  var coupleExists = true.obs;

  loadCouple(CoupleModel updatedUser) => couple.value = updatedUser;
  changeCoupleExists(bool value) => coupleExists.value = value;
}
