import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:kriptografi_idea/app/themes/app_colors.dart';
import 'package:kriptografi_idea/app/themes/app_text.dart';
import '../controllers/tentang_controller.dart';

class TentangView extends GetView<TentangController> {
  final String judul =
      "Penerapan Kriptografi Pada Data Diri Dengan QR Code Menggunakan International Data Encryption Algorithm Berbasis Android";
  final String nama = "Ani Asriani Zainuddin";
  final String nim = "217280076";

  final List<Map<String, dynamic>> listDosen = [
    {
      "jenis": "Pembimbing 1",
      "nama": "Muh. Basri, ST., MT",
    },
    {
      "jenis": "Pembimbing 2",
      "nama": "Marlina, S.Kom., M.Kom",
    },
    {
      "jenis": "Penguji 1",
      "nama": "Ir. Untung suwardoyo., S.Kom., M.T",
    },
    {
      "jenis": "Penguji 2",
      "nama": "Baharuddin, S.Kom., M.A.P",
    }
  ];

  final String pembimbing1 = "Muh. Basri, ST., MT";
  final String pembimbing2 = "Marlina, S.Kom., M.Kom";
  final String penguji1 = "Ir. Untung suwardoyo., S.Kom., M.T";
  final String penguji2 = "Baharuddin, S.Kom., M.A.P";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tentang'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(
              image: AssetImage("assets/images/logo.png"),
              width: 150,
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(8),
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(
                  color: primaryColor,
                  width: 2,
                ),
              ),
              child: Text(
                judul,
                style: kTitleStyle.copyWith(fontWeight: FontWeight.normal),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 14),
            Container(
              padding: const EdgeInsets.all(8),
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(
                  color: primaryColor,
                  width: 2,
                ),
              ),
              child: Text(
                "$nama \n$nim",
                style: kTitleStyle,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 14),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border.all(
                  color: primaryColor,
                  width: 2,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  ...listDosen
                      .map(
                        (dosen) => ListTile(
                          title: Text(
                            dosen["nama"],
                            style: TextStyle(
                              color: primaryColor,
                            ),
                          ),
                          subtitle: Text(
                            dosen["jenis"],
                            style: TextStyle(
                              color: secondaryColor,
                            ),
                          ),
                        ),
                      )
                      .toList()
                  // for (var item in listDosen)
                  // ..._dosenInfo("Pembimbing", 1, pembimbing1),
                  // ..._dosenInfo("Pembimbing", 2, pembimbing2),
                  // ..._dosenInfo("Penguji", 1, penguji1),
                  // ..._dosenInfo("Penguji", 2, penguji2),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

List<Widget> _dosenInfo(String jenis, int angka, String nama) {
  return [
    ListTile(
      title: Text(nama),
      subtitle: Text("$jenis $angka"),
    ),
  ];
}
