import 'package:flutter_test/flutter_test.dart';
import 'package:task_planner_app/main.dart';

void main() {
  testWidgets('Study Planner App loads successfully', (
    WidgetTester tester,
  ) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const StudyPlannerApp());

    // Verify the app widget is created
    expect(find.byType(StudyPlannerApp), findsOneWidget);
  });
}
