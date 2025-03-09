import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_work/presentation/core/widgets/index.dart';

void main() {
  group('ElevatedButtonIconTextCustom Tests', () {
    testWidgets('render the button with icon and text',
        (WidgetTester tester) async {
      const buttonText = 'Click Me';
      const icon = Icons.add;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ElevatedButtonIconTextCustom(
              onPressed: () {},
              text: buttonText,
              icon: icon,
            ),
          ),
        ),
      );

      expect(find.byIcon(icon), findsOneWidget);
      expect(find.text(buttonText), findsOneWidget);
    });

    testWidgets('call onPressed when the button is tapped',
        (WidgetTester tester) async {
      var isPressed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ElevatedButtonIconTextCustom(
              onPressed: () {
                isPressed = true;
              },
              text: 'Click Me',
              icon: Icons.add,
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
            body: ElevatedButtonIconTextCustom(
              onPressed: () {},
              text: 'Click Me',
              icon: Icons.add,
            ),
          ),
        ),
      );

      final elevatedButtonFinder = find.byType(ElevatedButton);
      final elevatedButton =
          tester.widget<ElevatedButton>(elevatedButtonFinder);

      expect(elevatedButton.style?.backgroundColor, isNotNull);

      final padding = elevatedButton.style?.padding?.resolve({});
      expect(padding,
          equals(const EdgeInsets.symmetric(horizontal: 20, vertical: 15)));

      final shape = elevatedButton.style?.shape?.resolve({});
      expect(shape, isA<RoundedRectangleBorder>());

      if (shape is RoundedRectangleBorder) {
        expect(shape.borderRadius, equals(BorderRadius.circular(12)));
      }
    });
  });
}
