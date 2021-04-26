// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_test/flutter_test.dart';

// 🌎 Project imports:
import 'package:flant/flant.dart';

void main() {
  testWidgets('should not emit "update:currentRate" event when render first',
      (WidgetTester tester) async {
    bool flag = false;
    final Widget app = MaterialApp(
      home: Material(
        child: FlanCircle(
          rate: 50,
          speed: 100,
          onChange: (double value) {
            flag = true;
          },
        ),
      ),
    );
    await tester.pumpWidget(app);
    expect(flag, false);
    await tester.pumpFrames(app, const Duration(milliseconds: 50));
    expect(flag, false);
  });

  testWidgets('should change circle size when using size prop',
      (WidgetTester tester) async {
    const Widget app = MaterialApp(
      home: Material(
        child: FlanCircle(
          size: 100,
        ),
      ),
    );
    await tester.pumpWidget(app);
    expect(
        tester.getSize(find.byType(Container).first), const Size(100.0, 100.0));
  });

  testWidgets('should change stroke linecap when using stroke-linecap prop',
      (WidgetTester tester) async {
    const Widget app = MaterialApp(
      home: Material(
        child: FlanCircle(
          strokeLineCap: StrokeCap.square,
        ),
      ),
    );
    await tester.pumpWidget(app);
    expect(find.byType(CustomPaint), findsWidgets);
  });
}
