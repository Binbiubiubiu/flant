import 'package:flant/flant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('should render left slot correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Material(
          child: FlanNavBar(
            leftSlot: Text('Custom Left'),
          ),
        ),
      ),
    );
    expect(find.text('Custom Left'), findsOneWidget);
  });

  testWidgets('should render right slot correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Material(
          child: FlanNavBar(
            rightSlot: Text('Custom Right'),
          ),
        ),
      ),
    );
    expect(find.text('Custom Right'), findsOneWidget);
  });

  testWidgets('should render title slot correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Material(
          child: FlanNavBar(
            titleSlot: Text('Custom Title'),
          ),
        ),
      ),
    );
    expect(find.text('Custom Title'), findsOneWidget);
  });

  testWidgets('should emit click-left event when clicking left text',
      (WidgetTester tester) async {
    int a = 0;
    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: FlanNavBar(
            leftText: 'left',
            onClickLeft: () {
              a++;
            },
          ),
        ),
      ),
    );
    final Finder left = find.text('left');
    expect(left, findsOneWidget);
    await tester.tap(left);
    expect(a, equals(1));
  });

  testWidgets('should emit click-right event when clicking right text',
      (WidgetTester tester) async {
    int a = 0;
    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: FlanNavBar(
            rightText: 'right',
            onClickRight: () {
              a++;
            },
          ),
        ),
      ),
    );
    final Finder right = find.text('right');
    expect(right, findsOneWidget);
    await tester.tap(right);
    expect(a, equals(1));
  });

  testWidgets(
      'should have safe-area-inset-top class when using safe-area-inset-top prop',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Material(
          child: FlanNavBar(
            safeAreaInsetTop: true,
          ),
        ),
      ),
    );
    final Finder right = find.byType(SafeArea);
    expect(tester.firstWidget<SafeArea>(right).top, isTrue);
  });
}
