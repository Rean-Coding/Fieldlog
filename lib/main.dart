import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'src/app.dart';

// Week 4: ProviderScope is the Riverpod root. Every provider in the app
// lives inside this scope. Tests override providers here.
// main.dart still contains nothing else — runApp() and the root only.
void main() {
  runApp(
    const ProviderScope(
      child: FieldLogApp(),
    ),
  );
}
