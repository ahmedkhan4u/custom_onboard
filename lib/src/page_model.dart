import 'package:flutter/material.dart';

class PageModel {
  final String? title;
  final String? body;
  final String? imagePath;
  final Color? pageColor;
  final Color? titleColor;
  final Color? bodyColor;

  PageModel({
    required this.title,
    required this.body,
    required this.imagePath,
    this.pageColor,
    this.titleColor,
    this.bodyColor
  });
}
