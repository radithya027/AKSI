import 'package:get/get.dart';

import '../../../../presentation/izin/controllers/izin.controller.dart';

class IzinControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IzinController>(
      () => IzinController(),
    );
  }
}
