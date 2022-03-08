import 'package:flutter/material.dart';

class FormatModel {
  late final String label;
  late final TextInputType textInputType;
  late TextEditingController textEditingController;

  FormatModel({required this.label, required this.textInputType})
      : textEditingController = TextEditingController();

  Map<String, dynamic> toJson() => {
        "label": label,
        "type": textInputType.index,
        "text": textEditingController.text,
      };

  FormatModel.fromJson(Map<String, dynamic> json) {
    label = json["label"];

    switch (json["type"]) {
      case 2:
        textInputType = TextInputType.number;
        break;
      case 3:
        textInputType = TextInputType.phone;
        break;
      case 4:
        textInputType = TextInputType.datetime;
        break;
      default:
        textInputType = TextInputType.text;
    }

    textEditingController = TextEditingController(text: json["text"]);
  }
}
