import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:kriptografi_idea/app/themes/app_colors.dart';
import 'package:kriptografi_idea/app/widgets/custom_card.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../controllers/dekripsi_controller.dart';

class DekripsiView extends GetView<DekripsiController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dekripsi'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            CustomCard(
              teks:
                  "Dekripsi (Decryption) adalah sebuah proses pembalikan yang mengubah teks-kode atau pesan yang tidak bisa dimengerti (ciphertext) menjadi sebuah teks-asli atau pesan yang dapat dimengerti (plaintext).",
            ),
            const SizedBox(height: 12),
            Expanded(
              flex: 5,
              child: QRView(
                key: controller.qrKey,
                onQRViewCreated: controller.onQRViewCreated,
                overlay: QrScannerOverlayShape(
                  borderColor: primaryColor,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border.all(
                  color: primaryColor,
                  width: 2,
                ),
              ),
              child: Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextButton.icon(
                      onPressed: controller.changeKamera,
                      icon: Icon(Ionicons.camera_reverse_sharp),
                      label: Text("Tukar Kamera"),
                    ),
                    TextButton.icon(
                      onPressed: controller.cameraActive.value.index ==
                              CameraFacing.front.index
                          ? null
                          : controller.toggleFlash,
                      icon: Icon(controller.flashActive.isFalse
                          ? Icons.flashlight_on_sharp
                          : Icons.flashlight_off_sharp),
                      label: Text(
                        "${controller.flashActive.isFalse ? 'Nyalakan' : 'Matikan'} Flash",
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
