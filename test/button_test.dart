import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flant/flant.dart';

void main() {
  group("按钮类型", () {
    testWidgets("主要按钮", (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        title: 'Flutter Demo',
        home: Scaffold(
          body: FlanButton(
            text: "主要按钮",
            type: FlanButtonType.success,
          ),
        ),
      ));
      expect(find.text("主要按钮"), findsOneWidget);
    });
  });
}
