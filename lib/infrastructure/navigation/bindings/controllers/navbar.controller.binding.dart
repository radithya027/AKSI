import 'package:get/get.dart';

import '../../../../presentation/navbar/controllers/navbar.controller.dart';

class NavbarControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NavbarController>(
      () => NavbarController(),
    );
  }
}
