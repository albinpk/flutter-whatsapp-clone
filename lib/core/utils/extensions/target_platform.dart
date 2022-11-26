import 'package:flutter/foundation.dart';

extension PlatformType on TargetPlatform {
  /// Return `true` if is web or [TargetPlatform] is linux, macos or windows.
  bool get isDesktop => !isMobile;

  /// Return `true` if [TargetPlatform] is (native) android, ios or fuchsia.
  bool get isMobile => !kIsWeb && _mobilePlatforms.contains(this);

  /// Return `true` if `kIsWeb` is `true` and platform is mobile.
  bool get isWebMobile => kIsWeb && _mobilePlatforms.contains(this);

  static const _mobilePlatforms = <TargetPlatform>{
    TargetPlatform.android,
    TargetPlatform.iOS,
    TargetPlatform.fuchsia,
  };
}
