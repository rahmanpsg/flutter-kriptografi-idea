import 'package:flutter/material.dart';

import 'package:ionicons/ionicons.dart';
import 'package:kriptografi_idea/app/routes/app_pages.dart';
import 'package:kriptografi_idea/app/widgets/custom_card.dart';
import 'package:kriptografi_idea/app/widgets/home_button.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kriptografi IDEA'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            CustomCard(
              teks:
                  "International Data Encryption Algorithm (IDEA) adalah algoritma enkripsi blok kunci yang aman dan rahasia yang dikembangkan oleh James Massey dan Xuejia Lai.",
            ),
            const SizedBox(height: 50),
            HomeButton(
              icon: Ionicons.lock_closed_sharp,
              teks: "Enkripsi",
              page: Routes.ENKRIPSI,
            ),
            const SizedBox(height: 20),
            HomeButton(
              icon: Ionicons.lock_open_sharp,
              teks: "Dekripsi",
              page: Routes.DEKRIPSI,
            ),
            const SizedBox(height: 20),
            HomeButton(
              icon: Ionicons.person_sharp,
              teks: "Tentang",
              page: Routes.TENTANG,
            ),
            Spacer(),
            Text("Teknik Informatika UM Pare ©2022")
          ],
        ),
      ),
    );
  }
}
