import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:window_size/window_size.dart';

import 'core/utils/bloc/global_bloc_observer.dart';
import 'core/utils/extensions/target_platform.dart';
import 'whats_app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  if (!kIsWeb && defaultTargetPlatform.isDesktop) {
    setWindowTitle('WhatsApp');
    setWindowMinSize(const Size(500, 400));
  }

  if (kDebugMode) Bloc.observer = GlobalBlocObserver();

  runApp(const WhatsApp());
}
