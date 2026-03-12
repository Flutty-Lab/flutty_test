import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutty_test/l10n/arb/_app_localizations.dart';
import 'package:flutty_test/l10n/arb/_app_localizations_fr.dart';

void main() {
  group('AppLocalizations', () {
    test('should support French locale', () {
      expect(AppLocalizations.supportedLocales, contains(const Locale('fr')));
    });

    test('should have correct number of supported locales', () {
      expect(AppLocalizations.supportedLocales.length, 1);
    });

    test('delegate should be not null', () {
      expect(AppLocalizations.delegate, isNotNull);
    });

    test('localizationsDelegates should contain required delegates', () {
      expect(AppLocalizations.localizationsDelegates.length,
          greaterThanOrEqualTo(4));
    });

    test('lookupAppLocalizations should return AppLocalizationsFr for French',
        () {
      final localizations = lookupAppLocalizations(const Locale('fr'));
      expect(localizations, isA<AppLocalizationsFr>());
      expect(localizations.localeName, 'fr');
    });

    test('lookupAppLocalizations should throw for unsupported locale', () {
      expect(
        () => lookupAppLocalizations(const Locale('en')),
        throwsA(isA<FlutterError>()),
      );
    });
  });

  group('AppLocalizationsFr', () {
    test('should create instance with default locale', () {
      final localizations = AppLocalizationsFr();
      expect(localizations.localeName, 'fr');
    });

    test('should create instance with explicit locale', () {
      final localizations = AppLocalizationsFr('fr');
      expect(localizations.localeName, 'fr');
    });
  });

  group('AppLocalizationsDelegate', () {
    testWidgets('should support French locale', (tester) async {
      const delegate = AppLocalizations.delegate;
      expect(delegate.isSupported(const Locale('fr')), isTrue);
    });

    testWidgets('should not support unsupported locales', (tester) async {
      const delegate = AppLocalizations.delegate;
      expect(delegate.isSupported(const Locale('en')), isFalse);
      expect(delegate.isSupported(const Locale('es')), isFalse);
    });

    testWidgets('should load French localizations', (tester) async {
      const delegate = AppLocalizations.delegate;
      final localizations = await delegate.load(const Locale('fr'));
      expect(localizations, isA<AppLocalizationsFr>());
    });
  });
}
