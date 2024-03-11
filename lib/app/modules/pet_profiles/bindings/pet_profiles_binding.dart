import 'package:get/get.dart';

import '../controllers/pet_profiles_controller.dart';

class PetProfilesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PetProfilesController>(
      () => PetProfilesController(),
    );
  }
}
