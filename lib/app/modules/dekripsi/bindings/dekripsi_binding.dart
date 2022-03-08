import 'package:get/get.dart';

import '../controllers/dekripsi_controller.dart';

class DekripsiBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DekripsiController>(
      () => DekripsiController(),
    );
  }
}
