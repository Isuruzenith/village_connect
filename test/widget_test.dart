import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:village_connect/main.dart';

void main() {
  testWidgets('App launches successfully', (WidgetTester tester) async {
    await tester.pumpWidget(const VillageConnectApp());
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
