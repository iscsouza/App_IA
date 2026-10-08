import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:pro_salario/main.dart';

void main() {
  testWidgets('SalaryTrackerApp smoke test', (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({});

    // Build our app and trigger a frame.
    await tester.pumpWidget(const SalaryTrackerApp());

    // Wait for asynchronous SharedPreferences loading & initial frame
    await tester.pump(const Duration(milliseconds: 500));

    // Verify that salary screen loads.
    expect(find.text('Salário'), findsOneWidget);
    expect(find.text('Seu Salário este Mês'), findsOneWidget);
  });
}
