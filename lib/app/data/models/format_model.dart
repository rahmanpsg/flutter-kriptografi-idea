import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FormatModel {
  late final String label;
  late final TextInputType textInputType;
  late final TextEditingController textEditingController;
  late final List<TextInputFormatter> inputFormatters;
  late final FocusNode focusNode;

  FormatModel({
    required this.label,
    required this.textInputType,
    this.inputFormatters = const [],
  })  : textEditingController = TextEditingController(),
        focusNode = FocusNode();

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
