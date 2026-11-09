import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

import 'golden_toolkit.dart';

const _defaultWidth = 375.0;

/// Small phone [Device] (375x667) with iPhone-style safe area insets.
const Device smallPhone = Device(
  name: 'smallPhone',
  size: Size(375, 667),
  safeArea: EdgeInsets.only(top: 44, bottom: 34),
);

/// Same [Device] as [smallPhone] but with text scaled by 2.
const Device smallPhoneWithZoom2 = Device(
  name: 'smallPhoneTextScale2',
  size: Size(375, 667),
  textScale: 2,
  safeArea: EdgeInsets.only(top: 44, bottom: 34),
);

/// Golden test of a single [widget] rendered at several text scale factors.
///
/// Generates a light (`<title>_light`) and a dark (`<title>_dark`) golden,
/// each containing the widget at default size, x2 and max text scale.
void testGoldensWithTextScale(
  String title, {
  required Widget widget,
  required double height,
  ThemeData? lightTheme,
  ThemeData? darkTheme,
  double? width,
  Iterable<LocalizationsDelegate<dynamic>>? localizations,
}) {
  GoldenBuilder builder(Color color) => GoldenBuilder.column(bgColor: color)
    ..addScenario('Default font size', widget)
    ..addTextScaleScenario('Large font size', widget, textScaleFactor: 2)
    ..addTextScaleScenario('Largest font', widget);

  _testGoldens(
    title,
    widget: builder(Colors.white).build(),
    height: height,
    width: width,
    themeMode: ThemeMode.light,
    lightTheme: lightTheme,
    darkTheme: darkTheme,
    localizations: localizations,
  );
  _testGoldens(
    title,
    widget: builder(Colors.black).build(),
    height: height,
    width: width,
    themeMode: ThemeMode.dark,
    lightTheme: lightTheme,
    darkTheme: darkTheme,
    localizations: localizations,
  );
}

/// Golden test of a single [widget] on a fixed surface ([width] x [height]).
///
/// Generates a light (`<title>_light`) and a dark (`<title>_dark`) golden.
void simpleTestGoldens(
  String title, {
  required Widget widget,
  required double height,
  ThemeData? lightTheme,
  ThemeData? darkTheme,
  double? width,
  Iterable<LocalizationsDelegate<dynamic>>? localizations,
}) {
  _testGoldens(
    title,
    widget: widget,
    height: height,
    width: width,
    themeMode: ThemeMode.light,
    lightTheme: lightTheme,
    darkTheme: darkTheme,
    localizations: localizations,
  );
  _testGoldens(
    title,
    widget: widget,
    height: height,
    width: width,
    themeMode: ThemeMode.dark,
    lightTheme: lightTheme,
    darkTheme: darkTheme,
    localizations: localizations,
  );
}

/// Full-screen golden test of a [widget] on multiple [Device]s.
///
/// Generates one golden per device named `<title>_<mode>.<device>` for light
/// mode ([smallPhone], [smallPhoneWithZoom2]) and dark mode ([Device.iphone11]).
/// Use [onlyLight] / [onlyDark] to restrict to a single mode, [overrideDevices]
/// or [additionalDevices] to customize the simulated devices, and
/// [waitDurationForAnimationInMs] to let animations complete before capture.
void screenTestGoldens(
  String title, {
  required Widget widget,
  Future<void> Function(WidgetTester)? initScreen,
  Future<void> Function(WidgetTester)? afterPumpAction,
  int? waitDurationForAnimationInMs,
  bool onlyDark = false,
  bool onlyLight = false,
  List<Device> additionalDevices = const [],
  List<Device>? overrideDevices,
  Iterable<LocalizationsDelegate<dynamic>>? localizations,
}) {
  assert(
    !onlyDark || !onlyLight,
    'Only one of onlyDark or onlyLight can be true',
  );

  void executeTest(ThemeMode mode, List<Device> devices) => _runTestGoldens(
    title: title,
    widget: widget,
    mode: mode,
    afterPumpAction: afterPumpAction,
    localizations: localizations,
    test: (tester) async {
      await initScreen?.call(tester);
      await multiScreenGolden(
        tester,
        '${title}_${mode.name}',
        autoHeight: true,
        devices: devices,
        customPump: waitDurationForAnimationInMs != null
            ? (tester) async => tester.pump(
                // We need to provide a duration to make the fake timer
                // advance, otherwise it remains on the 0 time slot and
                // raises an exception.
                Duration(milliseconds: waitDurationForAnimationInMs),
              )
            : null,
      );
    },
  );

  if (onlyDark || onlyLight) {
    executeTest(onlyDark ? ThemeMode.dark : ThemeMode.light, [
      ...(overrideDevices ??
          [Device.iphone11, smallPhone, smallPhoneWithZoom2]),
      ...additionalDevices,
    ]);
  } else {
    executeTest(ThemeMode.light, [
      ...(overrideDevices ?? [smallPhone, smallPhoneWithZoom2]),
      ...additionalDevices,
    ]);
    executeTest(ThemeMode.dark, [Device.iphone11]);
  }
}

void _testGoldens(
  String title, {
  required Widget widget,
  required double height,
  required ThemeMode themeMode,
  ThemeData? lightTheme,
  ThemeData? darkTheme,
  double? width,
  Future<void> Function(WidgetTester)? afterPumpAction,
  Iterable<LocalizationsDelegate<dynamic>>? localizations,
}) {
  _runTestGoldens(
    title: title,
    widget: widget,
    lightTheme: lightTheme,
    darkTheme: darkTheme,
    surfaceSize: Size(width ?? _defaultWidth, height),
    mode: themeMode,
    afterPumpAction: afterPumpAction,
    localizations: localizations,
    test: (tester) async {
      await screenMatchesGolden(tester, '${title}_${themeMode.name}');
    },
  );
}

void _runTestGoldens({
  required String title,
  required Widget widget,
  required Future<void> Function(WidgetTester) test,
  required ThemeMode mode,
  ThemeData? lightTheme,
  ThemeData? darkTheme,
  Future<void> Function(WidgetTester)? afterPumpAction,
  Size? surfaceSize,
  Iterable<LocalizationsDelegate<dynamic>>? localizations,
}) {
  TestWidgetsFlutterBinding.ensureInitialized();
  GoldenToolkit.runWithConfiguration(() async {
    return testGoldens('${title}_${mode.name}', (tester) async {
      await loadAppFonts();

      await tester.pumpWidgetBuilder(
        widget,
        wrapper: _materialAppWrapper(
          mode: mode,
          localizations: localizations,
          lightTheme: lightTheme,
          darkTheme: darkTheme,
        ),
        surfaceSize: surfaceSize ?? const Size(800, 600),
      );
      await afterPumpAction?.call(tester);
      await test.call(tester);
    }, tags: 'goldens');
  }, config: GoldenToolkitConfiguration(enableRealShadows: true));
}

WidgetWrapper _materialAppWrapper({
  ThemeData? lightTheme,
  ThemeData? darkTheme,
  Iterable<LocalizationsDelegate<dynamic>>? localizations,
  NavigatorObserver? navigatorObserver,
  Iterable<Locale>? localeOverrides,
  ThemeMode? mode = ThemeMode.light,
}) {
  final delegates = <LocalizationsDelegate<dynamic>>[
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    ...?localizations,
  ];

  return (child) => MaterialApp(
    localizationsDelegates: delegates,
    supportedLocales: localeOverrides ?? const [Locale('fr')],
    theme: lightTheme ?? ThemeData.light(),
    darkTheme: darkTheme ?? ThemeData.dark(),
    themeMode: mode,
    debugShowCheckedModeBanner: false,
    home: Material(child: child),
    navigatorObservers: [?navigatorObserver],
  );
}
