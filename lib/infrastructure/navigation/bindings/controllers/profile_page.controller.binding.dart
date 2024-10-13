import 'package:get/get.dart';

import '../../../../presentation/profile_page/controllers/profile_page.controller.dart';

class ProfilePageControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfilePageController>(
      () => ProfilePageController(),
    );
  }
}
