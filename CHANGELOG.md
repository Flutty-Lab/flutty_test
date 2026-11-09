## 0.3.0

- Require Flutter >=3.47.0 / Dart >=3.13.0
- Remove the discontinued `golden_toolkit` dependency: `Device`, `GoldenBuilder`, `multiScreenGolden`, `screenMatchesGolden`, `testGoldens`, `pumpWidgetBuilder`, `loadAppFonts` and the `GoldenToolkit` configuration are now vendored in `package:flutty_test/golden_toolkit.dart` (BSD-3, originally eBay) with the same public API and the same golden file paths
- Vendor the Roboto font loaded by `loadAppFonts`
- Migrate the vendored helpers to the modern `WidgetTester.view` / `platformDispatcher` test APIs
- Add dartdoc comments on the public helpers

## 0.2.1

- Improve README and example app

## 0.2.0

- Add all real code from private lib

## 0.1.0

- Initial release
