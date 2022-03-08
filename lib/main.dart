import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:kriptografi_idea/app/themes/app_theme.dart';

import 'app/routes/app_pages.dart';

void main() {
  runApp(
    GetMaterialApp(
      title: "Kriptografi IDEA",
      theme: AppTheme.basic,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
