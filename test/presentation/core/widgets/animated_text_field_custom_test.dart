import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_work/presentation/core/widgets/index.dart';

void main() {
  group('AnimatedTextFieldCustom Tests', () {
    testWidgets('render the widget with initial values',
        (WidgetTester tester) async {
      const labelText = 'Enter your name';
      const icon = Icons.person;
      final controller = TextEditingController();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AnimatedTextFieldCustom(
              controller: controller,
              labelText: labelText,
              icon: icon,
            ),
          ),
        ),
      );

      expect(find.byIcon(icon), findsOneWidget);
      expect(find.text(labelText), findsOneWidget);

      final animatedContainerFinder = find.byType(AnimatedContainer);
      final animatedContainer =
          tester.widget<AnimatedContainer>(animatedContainerFinder);
      expect(animatedContainer.constraints?.maxWidth, 0);
    });

    testWidgets('show the animated line when focused',
        (WidgetTester tester) async {
      const labelText = 'Enter your name';
      const icon = Icons.person;
      final controller = TextEditingController();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AnimatedTextFieldCustom(
              controller: controller,
              labelText: labelText,
              icon: icon,
            ),
          ),
        ),
      );

      final textFieldFinder = find.byType(TextFormField);
      await tester.tap(textFieldFinder);
      await tester.pumpAndSettle(); // Espera a que la animación termine

      final animatedContainerFinder = find.byType(AnimatedContainer);
      final animatedContainer =
          tester.widget<AnimatedContainer>(animatedContainerFinder);
      expect(animatedContainer.constraints?.maxWidth, 150);
    });

    testWidgets('show validation error when the field is empty',
        (WidgetTester tester) async {
      const labelText = 'Enter your name';
      const icon = Icons.person;
      final controller = TextEditingController();
      final formKey = GlobalKey<FormState>();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Form(
              key: formKey,
              child: AnimatedTextFieldCustom(
                controller: controller,
                labelText: labelText,
                icon: icon,
              ),
            ),
          ),
        ),
      );

      formKey.currentState!.validate();
      await tester.pump();

      expect(find.text('Requerido'), findsOneWidget);
    });

    testWidgets('call onChanged when text is entered',
        (WidgetTester tester) async {
      const labelText = 'Enter your name';
      const icon = Icons.person;
      final controller = TextEditingController();
      var enteredText = '';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AnimatedTextFieldCustom(
              controller: controller,
              labelText: labelText,
              icon: icon,
              onChanged: (value) {
                enteredText = value;
              },
            ),
          ),
        ),
      );

      const newText = 'Fabian Guerrero';
      await tester.enterText(find.byType(TextFormField), newText);

      expect(enteredText, newText);
    });
  });
}
