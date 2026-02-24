import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:village_connect/main.dart';

void main() {
  testWidgets('App launches successfully', (WidgetTester tester) async {
    await tester.pumpWidget(const VillageConnectApp());
    // Wait for the splash screen timer to finish
    await tester.pump(const Duration(seconds: 3));
    await tester.pumpAndSettle();
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
