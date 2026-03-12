import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutty_test/golden_utils.dart';

import 'package:flutty_test_example/main.dart';

void main() {
  group('golden_utils examples', () {
    test(
      'simpleTestGoldens example',
      () {
        simpleTestGoldens(
          'ExampleCard',
          widget: const SizedBox(width: 300, child: ExampleCard()),
          height: 120,
        );
      },
      skip: 'Example-only: requires golden update/approval workflow to run.',
    );

    test(
      'screenTestGoldens example',
      () {
        screenTestGoldens(
          'ExampleScreen',
          widget: const MaterialApp(
            home: Scaffold(body: Center(child: ExampleCard())),
          ),
        );
      },
      skip: 'Example-only: requires golden update/approval workflow to run.',
    );
  });
}
