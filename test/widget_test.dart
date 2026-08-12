import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:fieldlog_flutter/src/app.dart';

void main() {
  testWidgets('Onboarding screen shows the app name and CTA', (tester) async {
    await tester.pumpWidget(const FieldLogApp());

    expect(find.text('FieldLog'), findsOneWidget);
    expect(find.text('Get started'), findsOneWidget);
  });

  testWidgets('Tapping "Get started" shows a SnackBar', (tester) async {
    await tester.pumpWidget(const FieldLogApp());

    await tester.tap(find.text('Get started'));
    await tester.pump(); // begin the SnackBar animation

    expect(find.text('Welcome to FieldLog!'), findsOneWidget);
  });
}
