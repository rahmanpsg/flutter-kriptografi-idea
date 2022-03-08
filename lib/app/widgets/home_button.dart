import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:kriptografi_idea/app/themes/app_colors.dart';
import 'package:kriptografi_idea/app/themes/app_text.dart';

class HomeButton extends StatelessWidget {
  const HomeButton(
      {Key? key, required this.icon, required this.teks, required this.page})
      : super(key: key);

  final IconData icon;
  final String teks;
  final String page;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: primaryColor,
          width: 2,
        ),
      ),
      elevation: 5,
      shadowColor: Colors.white,
      child: InkWell(
        onTap: () {
          Get.toNamed(page);
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              Icon(
                icon,
                color: primaryColor,
                size: 40,
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  teks,
                  style: kButtonStyle.copyWith(
                    color: primaryColor,
                  ),
                ),
              ),
              Icon(
                Ionicons.arrow_forward_circle_sharp,
                color: primaryColor,
                size: 35,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
