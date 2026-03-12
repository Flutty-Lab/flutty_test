# flutty_test

[![pub package](https://img.shields.io/pub/v/flutty_test.svg)](https://pub.dev/packages/flutty_test)
[![pub points](https://img.shields.io/pub/points/flutty_test)](https://pub.dev/packages/flutty_test/score)
[![likes](https://img.shields.io/pub/likes/flutty_test)](https://pub.dev/packages/flutty_test/score)

Testing utilities, helpers and matchers for Flutty packages.

## Installation

```yaml
dev_dependencies:
  flutty_test: ^0.2.1
```

## Usage

```dart
import 'package:flutty_test/flutty_test.dart';

void main() {
  simpleTestGoldens(
    'MyWidget',
    widget: const MyWidget(),
    height: 80,
  );
}
```

### Multi-device golden (screens)

```dart
import 'package:flutter/material.dart';
import 'package:flutty_test/flutty_test.dart';

void main() {
  screenTestGoldens(
    'MyScreen',
    widget: const MaterialApp(home: MyScreen()),
  );
}
```

### With localization delegates

```dart
import 'package:flutter/material.dart';
import 'package:flutty_test/flutty_test.dart';
import 'package:flutty_test/l10n/arb/_app_localizations.dart';

void main() {
  simpleTestGoldens(
    'LocalizedWidget',
    widget: const MaterialApp(home: LocalizedWidget()),
    height: 120,
    localizations: AppLocalizations.localizationsDelegates,
  );
}
```

## API Documentation

See the [API docs](https://pub.dev/documentation/flutty_test/latest/) for full documentation.
