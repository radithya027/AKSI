import 'package:get/get.dart';

import '../../../../presentation/izin_sakit/controllers/izin_sakit.controller.dart';

class IzinSakitControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IzinSakitController>(
      () => IzinSakitController(),
    );
  }
}
