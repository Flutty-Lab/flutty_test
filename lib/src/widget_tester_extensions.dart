/// ***************************************************
/// Copyright 2019-2020 eBay Inc.
///
/// Use of this source code is governed by a BSD-style
/// license that can be found in the LICENSE file or at
/// https://opensource.org/licenses/BSD-3-Clause
///
/// Vendored from golden_toolkit 0.15.0 (discontinued on pub.dev),
/// migrated from the deprecated TestWindow API to [WidgetTester.view]
/// and [WidgetTester.platformDispatcher].
/// ***************************************************
library;

import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import 'configuration.dart';
import 'device.dart';

/// Convenience extensions on WidgetTester
extension WidgetTesterImageLoadingExtensions on WidgetTester {
  /// Waits for images to decode. Use this to ensure that images are properly displayed
  /// in Goldens. The implementation of this can be configured as part of GoldenToolkitConfiguration
  ///
  /// If you have assets that are not loading with this implementation, please file an issue and we will explore solutions.
  Future<void> waitForAssets() => GoldenToolkit.configuration.primeAssets(this);
}

/// Convenience extensions for more easily configuring WidgetTester for pre-set configurations
extension WidgetFlutterBindingExtensions on TestWidgetsFlutterBinding {
  /// Configure the Test device for the duration of the supplied operation and revert
  ///
  /// [device] the desired configuration to apply
  ///
  /// [body] the closure you wish to be executed with the device configuration applied
  ///
  Future<void> runWithDeviceOverrides(
    Device device, {
    required Future<void> Function() body,
  }) async {
    await applyDeviceOverrides(device);
    try {
      await body();
    } finally {
      await resetDeviceOverrides();
    }
  }

  /// Configure the Test device to match the configuration of the supplied device
  ///
  /// Note: these settings will persist across multiple tests in the same file. It is recommended
  /// that you reset upon completion.
  ///
  /// [device] the desired configuration to apply
  ///
  Future<void> applyDeviceOverrides(Device device) async {
    final view = platformDispatcher.implicitView!;
    await setSurfaceSize(Size(device.size.width, device.size.height));
    view.physicalSize = device.size * device.devicePixelRatio;
    view.devicePixelRatio = device.devicePixelRatio;
    platformDispatcher.textScaleFactorTestValue = device.textScale;
    platformDispatcher.platformBrightnessTestValue = device.brightness;
    view.padding = FakeViewPadding(
      bottom: device.safeArea.bottom,
      left: device.safeArea.left,
      right: device.safeArea.right,
      top: device.safeArea.top,
    );
  }

  /// Resets any configuration that may be been specified by applyDeviceOverrides
  ///
  /// Only needs to be called if you are concerned about the result of applyDeviceOverrides bleeding over across tests.
  Future<void> resetDeviceOverrides() async {
    final view = platformDispatcher.implicitView!;
    view.resetDevicePixelRatio();
    platformDispatcher.clearPlatformBrightnessTestValue();
    view.resetPadding();
    platformDispatcher.clearTextScaleFactorTestValue();
    view.resetPhysicalSize();
    await setSurfaceSize(null);
  }
}
