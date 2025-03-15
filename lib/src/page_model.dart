import 'package:flutter/material.dart';

/// A model class representing an onboarding page.

class PageModel {
  /// The title of the onboarding page.
  final String? title;

  /// The body text or description of the onboarding page.
  final String? body;

  /// The file path of the image displayed on the onboarding page.
  final String? imagePath;

  /// The background color of the onboarding page.
  final Color? pageColor;

  /// The text color of the title on the onboarding page.
  final Color? titleTextColor;

  /// The text color of the body on the onboarding page.
  final Color? bodyTextColor;

  PageModel(
      {required this.title,
      required this.body,
      required this.imagePath,
      this.pageColor,
      this.titleTextColor,
      this.bodyTextColor});
}
