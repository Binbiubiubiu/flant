// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_test/flutter_test.dart';

// 🌎 Project imports:
import 'package:flant/flant.dart';

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
