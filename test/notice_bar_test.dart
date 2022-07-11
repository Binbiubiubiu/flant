import 'package:flant/flant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('should emit close event when close icon is clicked',
      (WidgetTester tester) async {
    int a = 0;
    await tester.pumpWidget(MaterialApp(
      home: Material(
        child: FlanNoticeBar(
          mode: FlanNoticeBarMode.closeable,
          onClose: () {
            a++;
          },
        ),
      ),
    ));
    await tester.pumpAndSettle(const Duration(seconds: 2));
    final Finder closeBtn = find.byIcon(FlanIcons.cross);
    await tester.tap(closeBtn);
    expect(a, equals(1.0));
  });

  testWidgets('should render icon slot correct', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Material(
          child: FlanNoticeBar(
            child: Text('Content'),
            leftIconSlot: Text('Custom Left Icon'),
            rightIconSlot: Text('Custom Right Icon'),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle(const Duration(seconds: 2));
    expect(find.text('Content'), findsOneWidget);
    expect(find.text('Custom Left Icon'), findsOneWidget);
    expect(find.text('Custom Right Icon'), findsOneWidget);
  });

  testWidgets('should emit replay event after replay',
      (WidgetTester tester) async {
    double a = 0.0;
    await tester.pumpFrames(
      MaterialApp(
        home: Material(
          child: FlanNoticeBar(
            text: 'foo',
            scrollable: true,
            onReplay: () {
              print(a);
              a++;
            },
          ),
        ),
      ),
      const Duration(seconds: 10),
    );
    // await tester.pumpAndSettle(const Duration(seconds: 2));

    expect(a, isNot(equals(0.0)));
  });

  testWidgets('should start scrolling when content width > wrap width',
      (WidgetTester tester) async {
    const String t =
        'foofoofoofoofoofoofoofoofoofoofooffoofoofoofoofoofoofoofoofoofoofoof';
    const Widget app = MaterialApp(
      home: Material(
        child: FlanNoticeBar(
          delay: 0.2,
          text: t,
        ),
      ),
    );
    final Finder text = find.text(t);

    await tester.pumpWidget(app);

    final Offset pre = tester.getTopLeft(text);
    await tester.pumpFrames(app, const Duration(seconds: 1));
    final Offset later = tester.getTopLeft(text);

    expect(pre, isNot(equals(later)));
  });

  testWidgets('should not start scrolling when content width > wrap width',
      (WidgetTester tester) async {
    const String t = 'foofoofoofoo';
    const Widget app = MaterialApp(
      home: Material(
        child: SizedBox(
          width: 80.0,
          child: FlanNoticeBar(
            delay: 0.2,
            text: t,
          ),
        ),
      ),
    );
    final Finder text = find.text(t);

    await tester.pumpWidget(app);

    final Offset pre = tester.getTopLeft(text);
    await tester.pumpFrames(app, const Duration(seconds: 1));
    final Offset later = tester.getTopLeft(text);

    expect(pre, equals(later));
  });
}
