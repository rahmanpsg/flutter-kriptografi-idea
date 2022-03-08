import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:kriptografi_idea/app/modules/enkripsi/controllers/enkripsi_controller.dart';
import 'package:kriptografi_idea/app/themes/app_colors.dart';

class ModalTambah extends GetView<EnkripsiController> {
  const ModalTambah({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      height: 200,
      child: Column(
        children: <Widget>[
          TextField(
            controller: controller.controllerTambahLabel,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.zero),
              ),
              hintText: "Label",
            ),
          ),
          TextField(
            controller: controller.controllerTambahTipe,
            readOnly: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.zero),
              ),
              hintText: "Tipe",
              suffixIcon: PopupMenuButton<String>(
                icon: const Icon(Icons.arrow_drop_down),
                onSelected: (String value) {
                  print(value);
                  controller.controllerTambahTipe.text = value;
                },
                itemBuilder: (BuildContext context) {
                  return controller.listInputType
                      .map<PopupMenuItem<String>>(
                        (inputType) => PopupMenuItem(
                          child: Text(
                            inputType['name'],
                          ),
                          value: inputType['name'],
                        ),
                      )
                      .toList();
                },
              ),
            ),
          ),
          TextButton.icon(
            onPressed: controller.submitTambahFormat,
            icon: Icon(Ionicons.add_circle_sharp),
            label: Text("Tambah"),
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
    );
  }
}
