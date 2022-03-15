import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:kriptografi_idea/app/themes/app_colors.dart';
import 'package:kriptografi_idea/app/widgets/custom_card.dart';

import '../controllers/enkripsi_controller.dart';

class EnkripsiView extends GetView<EnkripsiController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enkripsi'),
        centerTitle: true,
        actions: [
          Obx(() => IconButton(
                onPressed: controller.changeMode,
                icon: Icon(
                  controller.modeCustom.isFalse
                      ? Ionicons.create_outline
                      : Ionicons.copy_outline,
                ),
                tooltip: "Ubah Format",
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Obx(
            () => Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                CustomCard(
                  teks:
                      "Enkripsi (Encryption) adalah sebuah proses penyandian yang mengubah teks-asli atau pesan yang dapat dimengerti (plaintext) menjadi teks-kode atau pesan yang tidak bisa dimengerti (ciphertext).",
                ),
                const SizedBox(height: 12),
                AnimatedSize(
                  duration: Duration(seconds: 1),
                  curve: Curves.fastOutSlowIn,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: primaryColor,
                        width: 2,
                      ),
                    ),
                    child: Column(
                      children: <Widget>[
                        if (controller.modeCustom.isTrue)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              IconButton(
                                onPressed: controller.tambahFormat,
                                icon: Icon(Ionicons.add_circle_sharp),
                                color: primaryColor,
                                tooltip: "Tambah",
                              ),
                              IconButton(
                                onPressed: controller.listFormatCustom.isEmpty
                                    ? null
                                    : controller.hapusFormat,
                                icon: Icon(Ionicons.remove_circle_sharp),
                                color: primaryColor,
                                tooltip: "Hapus",
                              )
                            ],
                          ),
                        if (controller.modeCustom.isTrue)
                          Divider(
                            thickness: 1,
                            color: primaryColor,
                          ),
                        if (controller.listFormat.isNotEmpty)
                          ...controller.listFormat
                              .map(
                                (format) => Column(
                                  children: <Widget>[
                                    TextFormField(
                                      controller: format.textEditingController,
                                      focusNode: format.focusNode,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.all(Radius.zero),
                                        ),
                                        labelText: format.label,
                                      ),
                                      keyboardType: format.textInputType,
                                      textInputAction: TextInputAction.next,
                                      inputFormatters: format.inputFormatters,
                                      readOnly: format.textInputType.index == 4,
                                      onTap: () {
                                        format.textInputType.index != 4
                                            ? null
                                            : controller.showCalendar(
                                                format.textEditingController);
                                      },
                                    ),
                                    const SizedBox(height: 8),
                                  ],
                                ),
                              )
                              .toList()
                        else
                          Text(
                            "Silahkan klik pada tombol tambah untuk menambahkan format yang anda inginkan...",
                            textAlign: TextAlign.center,
                          )
                      ],
                    ),
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
                    focusNode: controller.focusNodeKey,
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
                  onPressed: controller.submitEnkripsi,
                  icon: Icon(Icons.lock),
                  label: Text("Enkripsi"),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
