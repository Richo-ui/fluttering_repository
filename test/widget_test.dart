// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:list_and_recommendation_anime/main.dart';

void main() {
  testWidgets('Anime recommendation homepage renders', (WidgetTester tester) async {
    await tester.pumpWidget(const AnimeHubApp());

    expect(find.text('Find your next story'), findsOneWidget);
    expect(find.text('Frieren: Beyond Journey\'s End'), findsOneWidget);
    expect(find.byType(TextField), findsOneWidget);
    expect(find.byType(BottomNavigationBar), findsOneWidget);
  });
}
