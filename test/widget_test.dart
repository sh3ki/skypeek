import 'package:flutter_test/flutter_test.dart';
import 'package:skypeek/main.dart';

void main() {
  testWidgets('SkyPeek smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const SkyPeekApp());
    expect(find.byType(SkyPeekApp), findsOneWidget);
  });
}
