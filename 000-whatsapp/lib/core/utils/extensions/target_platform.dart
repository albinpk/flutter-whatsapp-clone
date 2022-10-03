import 'package:flutter/foundation.dart';

extension PlatformType on TargetPlatform {
  /// Return `true` if is web or [TargetPlatform] is linux, macos or windows.
  bool get isDesktop => !isMobile;

  /// Return `true` if [TargetPlatform] is (native) android, ios or fuchsia.
  bool get isMobile =>
      !kIsWeb &&
      const <TargetPlatform>{
        TargetPlatform.android,
        TargetPlatform.iOS,
        TargetPlatform.fuchsia,
      }.contains(this);
}
