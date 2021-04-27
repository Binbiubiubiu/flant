// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_test/flutter_test.dart';

// 🌎 Project imports:
import 'package:flant/flant.dart';

void main() {
  testWidgets('should update active value when title is clicked',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Material(
          child: FlanCell(
            child: Text('Custom Default'),
          ),
        ),
      ),
    );
    expect(find.byType(FlanCell), findsOneWidget);
    expect(find.text('Custom Default'), findsOneWidget);
  });
}
