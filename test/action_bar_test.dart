import 'package:flant/flant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('should allow to disable safe-area-inset-bottom prop',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Material(
          child: FlanActionBar(
            safeAreaInsetBottom: false,
          ),
        ),
      ),
    );
    expect(tester.firstWidget<SafeArea>(find.byType(SafeArea)).bottom, isFalse);
  });
}
