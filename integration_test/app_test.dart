import 'package:fieldlog_flutter/main.dart' as app;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('happy path — sign in, see logs, add an entry', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    // 1. Sign-in screen is shown
    expect(find.text('Sign in'), findsOneWidget);

    // 2. Enter credentials
    await tester.enterText(find.byType(TextField).first, 'test@example.com');
    await tester.enterText(find.byType(TextField).last, 'password123');
    await tester.tap(find.text('Sign in').last);
    await tester.pumpAndSettle();

    // 3. Logs screen shows; either empty state or list
    expect(find.text('Logs'), findsOneWidget);

    // 4. Add an entry via the FAB
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    // 5. New entry is visible (PENDING badge OK)
    expect(find.textContaining('Quick note'), findsOneWidget);
  });
}
