import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:kriptografi_idea/app/modules/dekripsi/controllers/dekripsi_controller.dart';
import 'package:kriptografi_idea/app/themes/app_colors.dart';

class HasilDekripsiView extends GetView<DekripsiController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hasil Dekripsi'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Obx(
            () => Column(
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
                    controller: controller.controllerCipherText,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.zero),
                      ),
                      labelText: 'Cipher Text',
                    ),
                    maxLines: 10,
                    readOnly: true,
                  ),
                ),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: primaryColor,
                      width: 2,
                    ),
                  ),
                  child: TextField(
                    controller: controller.controllerKey,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.zero),
                      ),
                      labelText: 'Kunci',
                      prefixIcon: Icon(Ionicons.key_sharp),
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                TextButton.icon(
                  onPressed: controller.submitDekripsi,
                  icon: Icon(Ionicons.lock_open_sharp),
                  label: Text("Dekripsi"),
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(
                      Size(400, 0),
                    ),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        side: BorderSide(
                          color: primaryColor,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                AnimatedSize(
                  duration: Duration(seconds: 1),
                  curve: Curves.easeInOutBack,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: controller.listFormat.isNotEmpty
                            ? primaryColor
                            : Colors.white,
                        width: 2,
                      ),
                    ),
                    child: Column(
                      children: [
                        ...controller.listFormat
                            .map(
                              (format) => Column(
                                children: <Widget>[
                                  TextFormField(
                                    controller: format.textEditingController,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.all(Radius.zero),
                                      ),
                                      labelText: format.label,
                                    ),
                                    keyboardType: format.textInputType,
                                    textInputAction: TextInputAction.next,
                                  ),
                                  const SizedBox(height: 8),
                                ],
                              ),
                            )
                            .toList()
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
