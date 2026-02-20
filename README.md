# flutty_test

[![pub package](https://img.shields.io/pub/v/flutty_test.svg)](https://pub.dev/packages/flutty_test)
[![pub points](https://img.shields.io/pub/points/flutty_test)](https://pub.dev/packages/flutty_test/score)
[![likes](https://img.shields.io/pub/likes/flutty_test)](https://pub.dev/packages/flutty_test/score)

Testing utilities, helpers and matchers for Flutty packages.

## Installation

```yaml
dev_dependencies:
  flutty_test: ^0.1.0
```

## Usage

```dart
import 'package:flutty_test/flutty_test.dart';

void main() {
  testWidgets('my widget test', (tester) async {
    // Pump a widget wrapped in MaterialApp
    await tester.pumpApp(MyWidget());
    expect(find.text('Hello'), findsOneWidget);
  });
}
```

## API Documentation

See the [API docs](https://pub.dev/documentation/flutty_test/latest/) for full documentation.
