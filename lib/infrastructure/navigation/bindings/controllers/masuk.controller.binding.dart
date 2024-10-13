import 'package:get/get.dart';

import '../../../../presentation/masuk/controllers/masuk.controller.dart';

class MasukControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MasukController>(
      () => MasukController(),
    );
  }
}
