import 'package:flutter/material.dart';

/// Wraps a widget in a [MaterialApp] for testing purposes.
Widget wrapWithMaterialApp(Widget widget) {
  return MaterialApp(
    home: Scaffold(body: widget),
  );
}
