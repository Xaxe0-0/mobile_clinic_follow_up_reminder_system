
import 'package:flutter_test/flutter_test.dart';
import 'package:clinic_follow_up_reminder_system/main.dart';

void main() {
  testWidgets('Clinic Follow-Up Reminder app loads successfully',
          (WidgetTester tester) async {
        await tester.pumpWidget(const ClinicApp());

        expect(find.text('Welcome back'), findsOneWidget);
        expect(find.text('Sign In'), findsOneWidget);
        expect(
          find.text('Sign in to access your clinic account.'),
          findsOneWidget,
        );
      });
}
