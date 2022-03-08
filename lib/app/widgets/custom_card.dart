import 'package:flutter/material.dart';
import 'package:kriptografi_idea/app/themes/app_colors.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({Key? key, required this.teks}) : super(key: key);

  final String teks;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: primaryColor,
        boxShadow: const [
          BoxShadow(
            color: secondaryColor,
            blurRadius: 3,
            offset: Offset(3, 3),
          )
        ],
      ),
      child: Text(
        teks,
        style: TextStyle(color: Colors.white),
        textAlign: TextAlign.justify,
      ),
    );
  }
}
