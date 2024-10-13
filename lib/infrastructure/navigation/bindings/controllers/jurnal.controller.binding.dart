import 'package:get/get.dart';

import '../../../../presentation/jurnal/controllers/jurnal.controller.dart';

class JurnalControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<JurnalController>(
      () => JurnalController(),
    );
  }
}
