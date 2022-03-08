import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:kriptografi_idea/app/data/controllers/idea.dart';
import 'package:kriptografi_idea/app/data/models/format_model.dart';
import 'package:kriptografi_idea/app/routes/app_pages.dart';
import 'package:kriptografi_idea/app/themes/app_colors.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class DekripsiController extends GetxController {
  late final IDEA _idea;

  late final GlobalKey qrKey;
  late final QRViewController qrViewController;

  Rx<String> cipherText = "".obs;

  Rx<CameraFacing> cameraActive = CameraFacing.back.obs;
  Rx<bool> flashActive = false.obs;

  late final TextEditingController controllerCipherText;
  late final TextEditingController controllerKey;

  final RxList<FormatModel> listFormat = <FormatModel>[].obs;

  @override
  void onInit() {
    _idea = IDEA();

    qrKey = GlobalKey(debugLabel: "QR");

    controllerCipherText = TextEditingController();
    controllerKey = TextEditingController();

    super.onInit();
  }

  void onQRViewCreated(QRViewController controller) {
    qrViewController = controller;

    qrViewController.scannedDataStream.listen((scanData) {
      // barcode.value = scanData;
      log(scanData.code.toString());

      cipherText.value = scanData.code ?? "";

      controllerCipherText.text = cipherText.value;

      Get.toNamed(Routes.HASIL_DEKRIPSI);
    });
  }

  void changeKamera() async {
    try {
      await qrViewController.flipCamera();

      cameraActive.value = await qrViewController.getCameraInfo();
    } catch (e) {
      log(e.toString());
      showMessage(
        message: "Gagal mengganti kamera",
        error: true,
      );
    }
  }

  void toggleFlash() async {
    try {
      await qrViewController.toggleFlash();

      flashActive.value = await qrViewController.getFlashStatus() ?? false;
    } catch (e) {
      log(e.toString());
      showMessage(
        message: "Gagal menyalakan/mematikan flash",
        error: true,
      );
    }
  }

  void submitDekripsi() async {
    String kunci = controllerKey.text;

    // Periksa jika data qr code kosong
    if (cipherText.value.isEmpty) {
      showMessage(message: "QR Code tidak dikenali!", error: true);
      return;
    }

    // Periksa jika kunci tidak kosong
    if (kunci.isEmpty) {
      showMessage(message: "Kunci harus diisi!", error: true);
      return;
    }

    try {
      String plainText = _idea.dekripsi(cipherText.value, kunci);

      String formatJson = plainText.substring(0, plainText.indexOf("]") + 1);

      final listFormatData = jsonDecode(formatJson);

      log(listFormatData.toString());

      listFormat.clear();

      for (Map<String, dynamic> format in listFormatData) {
        listFormat.add(FormatModel.fromJson(format));
      }

      SystemChannels.textInput.invokeMethod('TextInput.hide');
    } catch (e) {
      listFormat.clear();

      log(e.toString());
      showMessage(message: "QR Code tidak dapat di dekripsi", error: true);
    }
  }

  void showMessage({
    required String message,
    bool error = false,
  }) {
    Get.snackbar(
      "Informasi",
      message,
      colorText: Colors.white,
      icon: error
          ? Icon(
              Ionicons.warning_outline,
              color: Colors.white,
            )
          : Icon(
              Ionicons.checkmark_done_outline,
              color: Colors.white,
            ),
      backgroundColor: error ? warningColor : secondaryColor,
      // snackPosition: SnackPosition.BOTTOM,
    );
  }
}
