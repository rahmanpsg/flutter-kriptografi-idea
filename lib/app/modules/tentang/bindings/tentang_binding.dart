import 'package:get/get.dart';

import '../controllers/tentang_controller.dart';

class TentangBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TentangController>(
      () => TentangController(),
    );
  }
}
