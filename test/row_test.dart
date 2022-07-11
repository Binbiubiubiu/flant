import 'package:flant/flant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('should use Row class when wrap prop is false',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Material(
          child: FlanRow(
            wrap: false,
          ),
        ),
      ),
    );
    expect(find.byType(Row), findsOneWidget);
  });
}
