// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_test/flutter_test.dart';

// 🌎 Project imports:
import 'package:flant/flant.dart';

void main() {
  testWidgets('should emit finish event when finished',
      (WidgetTester tester) async {
    int i = 0;
    final Widget app = MaterialApp(
      home: Material(
        child: FlanCountDown(
          time: 1,
          onFinish: () {
            i++;
          },
        ),
      ),
    );
    await tester.pumpWidget(app);
    expect(i, equals(0));
    await tester.pumpAndSettle(const Duration(milliseconds: 50));
    expect(i, equals(1));
  });

  testWidgets('should emit finish event when finished and millisecond is true',
      (WidgetTester tester) async {
    int i = 0;
    final Widget app = MaterialApp(
      home: Material(
        child: FlanCountDown(
          time: 1,
          onFinish: () {
            i++;
          },
        ),
      ),
    );
    await tester.pumpWidget(app);
    expect(i, equals(0));
    await tester.pumpAndSettle(const Duration(milliseconds: 50));
    expect(i, equals(1));
  });

  testWidgets('should re-render after some time when millisecond is false',
      (WidgetTester tester) async {
    const Widget app = MaterialApp(
      home: Material(
        child: FlanCountDown(
          time: 100,
          format: 'SSS',
          millisecond: true,
        ),
      ),
    );
    await tester.pumpWidget(app);

    final String? preStr = tester.widget<Text>(find.byType(Text)).data;
    await tester.pumpAndSettle(const Duration(milliseconds: 50));
    final String? laterStr = tester.widget<Text>(find.byType(Text)).data;
    expect(preStr, isNot(laterStr));
  });

  testWidgets('should not start counting when auto-start prop is false',
      (WidgetTester tester) async {
    const Widget app = MaterialApp(
      home: Material(
        child: FlanCountDown(
          time: 100,
          format: 'SSS',
          autoStart: false,
        ),
      ),
    );
    await tester.pumpWidget(app);
    await tester.pumpAndSettle(const Duration(milliseconds: 50));
    expect(tester.widget<Text>(find.byType(Text)).data, equals('100'));
  });

  testWidgets('should start counting after calling the start method',
      (WidgetTester tester) async {
    const Widget app = MaterialApp(
      home: Material(
        child: FlanCountDown(
          time: 100,
          format: 'SSS',
          autoStart: false,
          millisecond: true,
        ),
      ),
    );
    final Finder textFinder = find.byType(Text);
    await tester.pumpWidget(app);
    final String? pre = tester.widget<Text>(textFinder).data;
    tester.firstState<FlanCountDownState>(find.byType(FlanCountDown)).start();
    await tester.pumpAndSettle(const Duration(milliseconds: 50));
    final String? later = tester.widget<Text>(textFinder).data;
    expect(pre, isNot(later));
  });

  testWidgets('should pause counting after calling the pause method',
      (WidgetTester tester) async {
    const Widget app = MaterialApp(
      home: Material(
        child: FlanCountDown(
          time: 100,
          format: 'SSS',
          millisecond: true,
        ),
      ),
    );
    final Finder textFinder = find.byType(Text);
    await tester.pumpWidget(app);
    final String? pre = tester.widget<Text>(textFinder).data;
    tester.firstState<FlanCountDownState>(find.byType(FlanCountDown)).pause();
    await tester.pumpAndSettle(const Duration(milliseconds: 50));
    final String? later = tester.widget<Text>(textFinder).data;
    expect(pre, equals(later));
  });

  testWidgets('should reset time after calling the reset method',
      (WidgetTester tester) async {
    final GlobalKey<FlanCountDownState> cKey = GlobalKey<FlanCountDownState>();
    final Widget app = MaterialApp(
      home: Material(
        child: FlanCountDown(
          key: cKey,
          time: 100,
          format: 'SSS',
          autoStart: false,
          millisecond: true,
        ),
      ),
    );
    final Finder textFinder = find.byType(Text);
    final Finder countDownFinder = find.byType(FlanCountDown);
    await tester.pumpWidget(app);
    final String? pre = tester.widget<Text>(textFinder).data;
    tester.firstState<FlanCountDownState>(countDownFinder).start();
    await tester.pumpAndSettle(const Duration(milliseconds: 50));
    tester.firstState<FlanCountDownState>(countDownFinder).reset();
    await tester.pumpAndSettle();
    final String? later = tester.widget<Text>(textFinder).data;
    expect(pre, equals(later));
  });

  testWidgets('should format complete time correctly',
      (WidgetTester tester) async {
    const Widget app = MaterialApp(
      home: Material(
        child: FlanCountDown(
          time: 30 * 60 * 60 * 1000 - 1,
          autoStart: false,
          format: 'DD-HH-mm-ss-SSS',
        ),
      ),
    );
    await tester.pumpWidget(app);

    final String? text = tester.widget<Text>(find.byType(Text)).data;
    expect(text, equals('01-05-59-59-999'));
  });

  testWidgets('should format incomplete time correctly',
      (WidgetTester tester) async {
    const Widget app = MaterialApp(
      home: Material(
        child: FlanCountDown(
          time: 30 * 60 * 60 * 1000 - 1,
          autoStart: false,
          format: 'HH-mm-ss-SSS',
        ),
      ),
    );
    await tester.pumpWidget(app);

    final String? text = tester.widget<Text>(find.byType(Text)).data;

    expect(text, equals('29-59-59-999'));
  });

  testWidgets('should format SS milliseconds correctly',
      (WidgetTester tester) async {
    const Widget app = MaterialApp(
      home: Material(
        child: FlanCountDown(
          time: 1500,
          autoStart: false,
          format: 'ss-SS',
        ),
      ),
    );
    await tester.pumpWidget(app);

    final String? text = tester.widget<Text>(find.byType(Text)).data;
    expect(text, equals('01-50'));
  });

  testWidgets('should format S milliseconds correctly',
      (WidgetTester tester) async {
    const Widget app = MaterialApp(
      home: Material(
        child: FlanCountDown(
          time: 1500,
          autoStart: false,
          format: 'ss-S',
        ),
      ),
    );
    await tester.pumpWidget(app);

    final String? text = tester.widget<Text>(find.byType(Text)).data;
    expect(text, equals('01-5'));
  });

  // testWidgets('should pause counting when deactivated',
  //     (WidgetTester tester) async {
  //   const Widget app = MaterialApp(
  //     home: Scaffold(
  //       // ignore: dead_code
  //       body: FlanCountDown(
  //         time: 10000,
  //       ),
  //     ),
  //   );
  //   final Finder textFinder = find.byType(Text);
  //   await tester.pumpWidget(app);
  //   final String? pre = tester.widget<Text>(textFinder).data;
  //   await tester.pumpFrames(app, const Duration(milliseconds: 50));
  //   final String? later = tester.widget<Text>(textFinder).data;
  //   expect(pre, equals(later));
  // });

  testWidgets('should emit change event when counting',
      (WidgetTester tester) async {
    // ignore: unused_local_variable
    CurrentTime? v;
    final Widget app = MaterialApp(
      home: Material(
        child: FlanCountDown(
          time: 1,
          onChange: (CurrentTime value) {
            v = value;
          },
        ),
      ),
    );
    await tester.pumpWidget(app);
    expect(v, isNull);
    await tester.pumpFrames(app, const Duration(milliseconds: 50));
    expect(v, equals(const CurrentTime()));
  });
}
