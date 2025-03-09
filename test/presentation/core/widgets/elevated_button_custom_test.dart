import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_work/presentation/core/widgets/index.dart';

void main() {
  group('ElevatedButtonCustom Widget Tests', () {
    testWidgets('render the button with the correct text',
        (WidgetTester tester) async {
      const buttonText = 'Click Me';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ElevatedButtonCustom(
              text: buttonText,
              onPressed: () {},
            ),
          ),
        ),
      );

      final buttonFinder = find.text(buttonText);

      expect(buttonFinder, findsOneWidget);
    });

    testWidgets('call onPressed when the button is tapped',
        (WidgetTester tester) async {
      var isPressed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ElevatedButtonCustom(
              text: 'Click Me',
              onPressed: () {
                isPressed = true;
              },
            ),
          ),
        ),
      );

      final buttonFinder = find.byType(ElevatedButton);

      await tester.tap(buttonFinder);
      await tester.pump();

      expect(isPressed, isTrue);
    });

    testWidgets('apply the correct styles', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ElevatedButtonCustom(
              text: 'Click Me',
              onPressed: () {},
            ),
          ),
        ),
      );

      final elevatedButtonFinder = find.byType(ElevatedButton);
      final elevatedButton =
          tester.widget<ElevatedButton>(elevatedButtonFinder);

      expect(elevatedButton.style?.backgroundColor, isNotNull);
      expect(elevatedButton.style?.foregroundColor, isNotNull);

      final shape = elevatedButton.style?.shape?.resolve({});
      expect(shape, isA<RoundedRectangleBorder>());

      if (shape is RoundedRectangleBorder) {
        expect(shape.borderRadius, equals(BorderRadius.circular(12)));
      }
    });
  });
}
