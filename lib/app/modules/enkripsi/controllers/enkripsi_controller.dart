import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:kriptografi_idea/app/data/controllers/idea.dart';
import 'package:kriptografi_idea/app/data/models/format_model.dart';
import 'package:kriptografi_idea/app/routes/app_pages.dart';
import 'package:kriptografi_idea/app/themes/app_colors.dart';
import 'package:kriptografi_idea/app/widgets/modal_tambah.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';

class EnkripsiController extends GetxController {
  late final IDEA _idea;
  late String cipherText;

  late QrCode qrCode;
  late QrPainter qrPainter;
  late String? _pathQrCode;

  final List<FormatModel> listFormatDefault = [
    FormatModel(
        label: "Nomor Kartu Keluarga", textInputType: TextInputType.phone),
    FormatModel(
      label: "Nomor Induk Kependudukan",
      textInputType: TextInputType.number,
    ),
    FormatModel(
      label: "Tanggal/Bulan/Tahun Lahir",
      textInputType: TextInputType.datetime,
    ),
    FormatModel(
      label: "Keterangan Tentang Fisik dan/atau Mental",
      textInputType: TextInputType.text,
    ),
    FormatModel(
      label: "NIK Ibu Kandung",
      textInputType: TextInputType.number,
    ),
    FormatModel(
      label: "NIK Ayah Kandung",
      textInputType: TextInputType.number,
    ),
    FormatModel(
      label: "Catatan Peristiwa Penting",
      textInputType: TextInputType.text,
    ),
  ];

  final RxList<FormatModel> listFormatCustom = <FormatModel>[].obs;

  late final TextEditingController controllerKey;

  RxBool modeCustom = false.obs;

  final List<Map<String, dynamic>> listInputType = [
    {"name": "Teks", "value": TextInputType.text},
    {"name": "Nomor", "value": TextInputType.number},
  ];

  late final TextEditingController controllerTambahLabel;
  late final TextEditingController controllerTambahTipe;

  @override
  void onInit() {
    _idea = IDEA();

    controllerKey = TextEditingController();

    controllerTambahLabel = TextEditingController();
    controllerTambahTipe = TextEditingController();

    super.onInit();
  }

  @override
  void onClose() {
    for (var format in listFormatDefault) {
      format.textEditingController.dispose();
    }

    for (var format in listFormatCustom) {
      format.textEditingController.dispose();
    }

    controllerKey.dispose();

    controllerTambahLabel.dispose();
    controllerTambahTipe.dispose();
  }

  void changeMode() {
    print(modeCustom.value);
    modeCustom.value = !modeCustom.value;
  }

  void submitEnkripsi() async {
    try {
      List<FormatModel> listFormat =
          modeCustom.isFalse ? listFormatDefault : listFormatCustom;
      List<Map<String, dynamic>> listFormatData = [];

      // Validasi
      validasiFormFormat(listFormat, listFormatData);

      String plainText = jsonEncode(listFormatData);

      String kunci = controllerKey.text;

      // Periksa jika kunci tidak kosong
      if (kunci.isEmpty) {
        showMessage(message: "Kunci harus diisi!", error: true);
        return;
      }

      cipherText = _idea.enkripsi(plainText, kunci);

      // Membuat dan validasi qr code
      bool success = await buatQrCode(cipherText);

      // Jika QR code berhasil dibuat
      if (success) {
        Get.toNamed(Routes.HASIL_ENKRIPSI);
        resetFormFormat(listFormat);
        controllerKey.clear();
      }
    } catch (e) {
      showMessage(message: e.toString(), error: true);
    }
  }

  void validasiFormFormat(
      List<FormatModel> listFormat, List<Map<String, dynamic>> listFormatData) {
    if (listFormat.isEmpty) throw ("Silahkan tambahkan format terlebih dahulu");

    for (var format in listFormat) {
      // Validasi
      if (format.textEditingController.text.isEmpty) {
        throw ("${format.label} harus diisi!");
      }

      listFormatData.add(format.toJson());
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

  void tambahFormat() {
    Get.bottomSheet(
      ModalTambah(),
      backgroundColor: Colors.white,
    );
  }

  void hapusFormat() {
    listFormatCustom.removeLast();
  }

  void submitTambahFormat() {
    try {
      if (controllerTambahLabel.text.isEmpty) {
        showMessage(message: "Label tidak boleh kosong", error: true);
        return;
      }

      if (controllerTambahTipe.text.isEmpty) {
        showMessage(
            message: "Silahkan pilih tipe terlebih dahulu", error: true);
        return;
      }

      int index = listInputType.indexWhere(
          (inputType) => inputType["name"] == controllerTambahTipe.text);

      listFormatCustom.add(
        FormatModel(
          label: controllerTambahLabel.text,
          textInputType: listInputType[index]["value"],
        ),
      );

      resetFormTambah();

      Get.back();
    } catch (e) {
      log(e.toString());
      showMessage(message: e.toString(), error: true);
    }
  }

  void resetFormTambah() {
    controllerTambahLabel.clear();
    controllerTambahTipe.clear();
  }

  void resetFormFormat(List<FormatModel> listFormat) {
    for (var format in listFormat) {
      format.textEditingController.clear();
    }
  }

  Future<bool> buatQrCode(String cipherText) async {
    final qrValidationResult = QrValidator.validate(
      data: cipherText,
      version: QrVersions.auto,
      errorCorrectionLevel: QrErrorCorrectLevel.L,
    );

    if (qrValidationResult.status == QrValidationStatus.valid) {
      qrCode = qrValidationResult.qrCode ??
          QrCode.fromData(
            data: cipherText,
            errorCorrectLevel: QrErrorCorrectLevel.L,
          );

      qrPainter = QrPainter.withQr(
        qr: qrCode,
        gapless: true,
        emptyColor: Colors.white,
      );

      _pathQrCode = await buatFileQrCode();

      return true;
    }

    return false;
  }

  Future<String?> buatFileQrCode() async {
    try {
      Directory tempDir = await getTemporaryDirectory();
      String tempPath = tempDir.path;
      final ts = DateTime.now().millisecondsSinceEpoch.toString();
      String path = '$tempPath/qr_enkripsi_$ts.png';

      final picData =
          await qrPainter.toImageData(2048, format: ui.ImageByteFormat.png);

      final buffer = picData!.buffer;
      await File(path).writeAsBytes(
        buffer.asUint8List(picData.offsetInBytes, picData.lengthInBytes),
      );

      return path;
    } catch (e) {
      log(e.toString());
      showMessage(message: e.toString(), error: true);
    }

    return null;
  }

  void simpanQrCode() async {
    String? path = _pathQrCode;

    if (path == null) {
      showMessage(
          message: "Terjadi masalah saat membuat file QR code", error: true);
      return;
    }

    try {
      final bool success = await GallerySaver.saveImage(path) ?? false;

      showMessage(
        message: "QR code ${success ? 'berhasil' : 'gagal'} disimpan",
        error: !success,
      );
    } catch (e) {
      log(e.toString());
      showMessage(message: e.toString(), error: true);
    }
  }

  void shareQrCode() async {
    String? path = _pathQrCode;

    if (path == null) {
      showMessage(
          message: "Terjadi masalah saat membuat file QR code", error: true);
      return;
    }

    try {
      await Share.shareFiles(
        [path],
        mimeTypes: ["image/png"],
        subject: 'QR Code',
        text: 'Enkripsi menggunakan metode IDEA',
      );
    } catch (e) {
      log(e.toString());
      showMessage(message: e.toString(), error: true);
    }
  }
}
