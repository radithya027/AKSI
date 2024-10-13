import 'package:get/get.dart';

import '../../../../presentation/homepage/controllers/homepage.controller.dart';

class HomepageControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomepageController>(
      () => HomepageController(),
    );
  }
}
