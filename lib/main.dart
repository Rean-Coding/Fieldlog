import 'package:flutter/material.dart';

import 'src/app.dart';

// RULE (Week 1): main.dart contains only runApp() and the root widget reference.
// No business logic, no theme, no routes — those belong in src/app.dart and
// inside feature folders. If you are tempted to add code here, you are wrong.
void main() {
  runApp(const FieldLogApp());
}
