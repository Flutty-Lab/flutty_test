import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutty_test/flutty_test.dart';

void main() {
  test('wrapWithMaterialApp returns a MaterialApp', () {
    final widget = wrapWithMaterialApp(const Text('Hello'));
    expect(widget, isA<MaterialApp>());
  });

  testWidgets('pumpApp pumps a widget in MaterialApp', (tester) async {
    await tester.pumpApp(const Text('Hello'));
    expect(find.text('Hello'), findsOneWidget);
  });
}
