import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:kriptografi_idea/app/modules/enkripsi/controllers/enkripsi_controller.dart';
import 'package:kriptografi_idea/app/themes/app_colors.dart';

class HasilEnkripsiView extends GetView<EnkripsiController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hasil Enkripsi'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: primaryColor,
                    width: 2,
                  ),
                ),
                child: TextField(
                  controller: controller.controllerPlainText,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.zero),
                    ),
                    labelText: 'Plain Text',
                  ),
                  maxLines: 5,
                  readOnly: true,
                ),
              ),
              const SizedBox(height: 24),
              Center(
                child: CustomPaint(
                  size: Size.square(300),
                  painter: controller.qrPainter,
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: primaryColor,
                    width: 2,
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextButton.icon(
                      onPressed: controller.simpanQrCode,
                      icon: Icon(Ionicons.save_sharp),
                      label: Text("Simpan"),
                    ),
                    TextButton.icon(
                      onPressed: controller.shareQrCode,
                      icon: Icon(Ionicons.share_social_sharp),
                      label: Text("Bagikan"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
