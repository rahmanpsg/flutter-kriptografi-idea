import 'package:get/get.dart';

import '../modules/dekripsi/bindings/dekripsi_binding.dart';
import '../modules/dekripsi/views/dekripsi_view.dart';
import '../modules/enkripsi/bindings/enkripsi_binding.dart';
import '../modules/enkripsi/views/enkripsi_view.dart';
import '../modules/hasil_dekripsi/views/hasil_dekripsi_view.dart';
import '../modules/hasil_enkripsi/views/hasil_enkripsi_view.dart';
import '../modules/home/views/home_view.dart';
import '../modules/tentang/bindings/tentang_binding.dart';
import '../modules/tentang/views/tentang_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
    ),
    GetPage(
      name: _Paths.TENTANG,
      page: () => TentangView(),
      binding: TentangBinding(),
      transition: Transition.native,
    ),
    GetPage(
      name: _Paths.ENKRIPSI,
      page: () => EnkripsiView(),
      binding: EnkripsiBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: _Paths.DEKRIPSI,
      page: () => DekripsiView(),
      binding: DekripsiBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: _Paths.HASIL_ENKRIPSI,
      page: () => HasilEnkripsiView(),
      transition: Transition.circularReveal,
    ),
    GetPage(
      name: _Paths.HASIL_DEKRIPSI,
      page: () => HasilDekripsiView(),
    ),
  ];
}
