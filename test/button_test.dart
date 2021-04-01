// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_test/flutter_test.dart';

// 🌎 Project imports:
import 'package:flant/flant.dart';

void main() {
  group('按钮类型', () {
    testWidgets('主要按钮', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        title: 'Flutter Demo',
        home: Scaffold(
          body: FlanButton(
            text: '主要按钮',
            type: FlanButtonType.success,
          ),
        ),
      ));
      expect(find.text('主要按钮'), findsOneWidget);
    });
  });
}
