import 'package:get/get.dart';

import '../controllers/enkripsi_controller.dart';

class EnkripsiBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EnkripsiController>(
      () => EnkripsiController(),
    );
  }
}
