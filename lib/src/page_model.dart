import 'package:flutter/material.dart';

class PageModel {
  final String? title;
  final String? body;
  final String? imagePath;
  final Color? pageColor;
  final Color? titleTextColor;
  final Color? bodyTextColor;

  PageModel(
      {required this.title,
      required this.body,
      required this.imagePath,
      this.pageColor,
      this.titleTextColor,
      this.bodyTextColor});
}
