import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'utils/bloc/global_bloc_observer.dart';
import 'whats_app.dart';

void main() {
  if (kDebugMode) Bloc.observer = GlobalBlocObserver();

  runApp(const WhatsApp());
}
