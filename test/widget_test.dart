// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:belajar_flutter/data/data_sources.dart';
import 'package:belajar_flutter/ui/main.dart';
import 'package:belajar_flutter/presentation/componentui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setupLocator();
  // Test for FirstApp Widget
  testWidgets('FirstApp builds with correct AppBar title', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: FirstApp()));
    expect(find.text('Login Page'), findsOneWidget);
  });

  // Test for LoginPage Widget
  testWidgets('LoginPage builds its form and buttons', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: Scaffold(body: LoginPage())));
    expect(find.byType(Form), findsOneWidget);
    expect(find.text('Login'), findsOneWidget);
    expect(find.text('Register'), findsOneWidget);
  });

  // Test for CustomInputEmail Widget
  testWidgets('CustomInputEmail saves and validates input', (WidgetTester tester) async {
    var email = 'abcd@abcd.com';
    await tester.pumpWidget(MaterialApp(
        home: Scaffold(
      body: CustomInputEmail(
        hintText: 'Enter your email',
        onSaved: (value) => email = value!,
        validationModel: ValidationModel(null, null), // You need to define how this model behaves
        prefIcon: const Icon(Icons.email),
      ),
    )));

    await tester.enterText(find.byType(TextFormField), 'test@example.com');
    await tester.testTextInput.receiveAction(TextInputAction.done);
    expect(email, equals('abcd@abcd.com'));
  });
}
