import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_work/presentation/core/widgets/index.dart';

void main() {
  group('AddTextListCustom Tests', () {
    testWidgets('render the widget with initial values',
        (WidgetTester tester) async {
      const title = 'Add Items';
      const hintText = 'Enter an item';
      const buttonText = 'Add';
      final initialList = ['Item 1', 'Item 2'];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AddTextListCustom(
              textList: initialList,
              title: title,
              hintText: hintText,
              buttonText: buttonText,
              onChanged: (list) {},
            ),
          ),
        ),
      );

      expect(find.text(title), findsOneWidget);

      for (final item in initialList) {
        expect(find.text(item), findsOneWidget);
      }

      expect(find.byType(TextField), findsOneWidget);
      expect(find.text(buttonText), findsOneWidget);
    });

    testWidgets('add text to the list when the button is pressed',
        (WidgetTester tester) async {
      const title = 'Add Items';
      const hintText = 'Enter an item';
      const buttonText = 'Add';
      final initialList = <String>[];

      List<String> updatedList = [];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AddTextListCustom(
              textList: initialList,
              title: title,
              hintText: hintText,
              buttonText: buttonText,
              onChanged: (list) {
                updatedList = list;
              },
            ),
          ),
        ),
      );

      const newItem = 'New Item';
      await tester.enterText(find.byType(TextField), newItem);

      await tester.tap(find.text(buttonText));
      await tester.pump(); // Procesa el evento

      expect(find.text(newItem), findsOneWidget);

      expect(updatedList, contains(newItem));
    });

    testWidgets('remove text from the list when the delete button is pressed',
        (WidgetTester tester) async {
      const title = 'Add Items';
      const hintText = 'Enter an item';
      const buttonText = 'Add';
      final initialList = ['Item 1', 'Item 2'];

      List<String> updatedList = [];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AddTextListCustom(
              textList: initialList,
              title: title,
              hintText: hintText,
              buttonText: buttonText,
              onChanged: (list) {
                updatedList = list;
              },
            ),
          ),
        ),
      );

      for (final item in initialList) {
        expect(find.text(item), findsOneWidget);
      }

      await tester.tap(find.byIcon(Icons.delete_forever).first);
      await tester.pump();

      expect(find.text(initialList[0]), findsNothing);
      expect(find.text(initialList[1]), findsOneWidget);

      expect(updatedList, isNot(contains(initialList[0])));
    });
  });
}
