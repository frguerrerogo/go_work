import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_work/presentation/core/widgets/index.dart';

void main() {
  group('IconButtonCustom Tests', () {
    testWidgets('should render the icon and container correctly',
        (WidgetTester tester) async {
      const icon = Icons.add;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: IconButtonCustom(
              onTap: () {},
              icon: icon,
              background: true,
            ),
          ),
        ),
      );

      expect(find.byIcon(icon), findsOneWidget);
      expect(find.byType(Container), findsOneWidget);
    });

    testWidgets('should call onTap when the button is tapped',
        (WidgetTester tester) async {
      var isTapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: IconButtonCustom(
              onTap: () {
                isTapped = true;
              },
              icon: Icons.add,
              background: true,
            ),
          ),
        ),
      );

      final buttonFinder = find.byType(GestureDetector);

      await tester.tap(buttonFinder);
      await tester.pump();

      expect(isTapped, isTrue);
    });

    testWidgets('should apply the correct styles', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: IconButtonCustom(
              onTap: () {},
              icon: Icons.add,
              background: true,
            ),
          ),
        ),
      );

      final containerFinder = find.byType(Container);
      final container = tester.widget<Container>(containerFinder);

      expect(container.decoration, isA<BoxDecoration>());

      final boxDecoration = container.decoration as BoxDecoration;

      expect(boxDecoration.color, isNotNull);
      expect(boxDecoration.shape, BoxShape.circle);

      expect(container.constraints?.maxWidth, 25);
      expect(container.constraints?.maxHeight, 25);

      expect(
          container.margin, equals(const EdgeInsets.symmetric(horizontal: 15)));

      final iconFinder = find.byType(Icon);
      final icon = tester.widget<Icon>(iconFinder);
      expect(icon.color, isNotNull);
      expect(icon.size, 18);
    });
  });
}
