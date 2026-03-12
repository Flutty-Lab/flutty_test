import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutty_test/flutty_test.dart';

void main() {
  group('flutty_test library', () {
    test('should export golden_utils', () {
      expect(smallPhone, isNotNull);
      expect(smallPhoneWithZoom2, isNotNull);
    });

    test('smallPhone device has correct properties', () {
      expect(smallPhone.name, 'smallPhone');
      expect(smallPhone.size, const Size(375, 667));
      expect(smallPhone.safeArea, const EdgeInsets.only(top: 44, bottom: 34));
    });

    test('smallPhoneWithZoom2 device has correct properties', () {
      expect(smallPhoneWithZoom2.name, 'smallPhoneTextScale2');
      expect(smallPhoneWithZoom2.size, const Size(375, 667));
      expect(smallPhoneWithZoom2.textScale, 2);
      expect(smallPhoneWithZoom2.safeArea,
          const EdgeInsets.only(top: 44, bottom: 34));
    });
  });
}
