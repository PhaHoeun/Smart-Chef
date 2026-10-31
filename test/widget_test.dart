import 'package:flutter_test/flutter_test.dart';
import 'package:smartchef_flutter/main.dart';

void main() {
  testWidgets('SmartChef app loads smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const SmartChefApp());
    expect(find.byType(SmartChefApp), findsOneWidget);
  });
}
