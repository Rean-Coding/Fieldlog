import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:fieldlog_flutter/src/app.dart';

void main() {
  testWidgets('Onboarding renders app name, description, and CTA', (tester) async {
    await tester.pumpWidget(const FieldLogApp());

    expect(find.text('FieldLog'), findsOneWidget);
    expect(find.text('A simple log you can take anywhere.'), findsOneWidget);
    expect(find.text('Get started'), findsOneWidget);
    expect(find.byType(TextField), findsOneWidget);
  });

  testWidgets('Tapping Get started with empty name shows guidance', (tester) async {
    await tester.pumpWidget(const FieldLogApp());

    await tester.tap(find.text('Get started'));
    await tester.pump();

    expect(find.text('Please enter your name first.'), findsOneWidget);
  });

  testWidgets('Entering name + Get started navigates to profile route', (tester) async {
    await tester.pumpWidget(const FieldLogApp());

    await tester.enterText(find.byType(TextField), 'Metrey');
    await tester.tap(find.text('Get started'));
    await tester.pumpAndSettle();

    expect(find.text('Hello, Metrey!'), findsOneWidget);
    expect(find.text('Profile'), findsOneWidget); // AppBar title
  });
}
