import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Extension on [WidgetTester] to simplify pumping widgets in tests.
extension PumpApp on WidgetTester {
  /// Pumps a [MaterialApp] wrapping the given [widget].
  Future<void> pumpApp(Widget widget) async {
    await pumpWidget(
      MaterialApp(
        home: Scaffold(body: widget),
      ),
    );
  }
}
