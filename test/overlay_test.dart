// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_test/flutter_test.dart';

// 🌎 Project imports:
import 'package:flant/flant.dart';

void main() {
  testWidgets('should allow to custom style with custom-style prop',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Material(
          child: FlanOverlay(
            show: true,
            customStyle: BoxDecoration(color: Colors.red),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    final Finder bg = find.byType(DecoratedBox);
    final BoxDecoration style =
        tester.firstWidget<DecoratedBox>(bg).decoration as BoxDecoration;
    expect(style.color, equals(Colors.red));
  });

  testWidgets('should change animation duration when using duration prop',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Material(
          child: FlanOverlay(
            show: true,
            duration: Duration(milliseconds: 1),
          ),
        ),
      ),
    );
    final Finder bg = find.byType(FlanTransitionVisiable);
    final FlanTransitionVisiable visiable =
        tester.firstWidget<FlanTransitionVisiable>(bg);
    expect(visiable.duration, equals(const Duration(milliseconds: 1)));
  });

  testWidgets('should render default slot correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Material(
          child: FlanOverlay(
            show: true,
            child: Text('Custom Default'),
          ),
        ),
      ),
    );

    expect(find.text('Custom Default'), findsOneWidget);
  });

  testWidgets('should render default slot correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Material(
          child: FlanOverlay(
            show: true,
            child: Text('Custom Default'),
          ),
        ),
      ),
    );

    expect(find.text('Custom Default'), findsOneWidget);
  });

  testWidgets('should allow to touchmove when lock-scroll is false',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: FlanOverlay(
            show: true,
            lockScroll: false,
            child: ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  width: double.infinity,
                  height: 100.0,
                  child: Text(index.toString()),
                );
              },
              itemCount: 20,
            ),
          ),
        ),
      ),
    );

    await tester.dragFrom(const Offset(150.0, 0.0), const Offset(0.0, -2000.0));
    await tester.pumpAndSettle();

    expect(find.text('18'), findsOneWidget);
  });

  testWidgets('should not allow to touchmove when lock-scroll is true',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: FlanOverlay(
            show: true,
            lockScroll: true,
            child: ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  width: double.infinity,
                  height: 100.0,
                  child: Text(index.toString()),
                );
              },
              itemCount: 20,
            ),
          ),
        ),
      ),
    );

    await tester.dragFrom(const Offset(150.0, 0.0), const Offset(0.0, -2000.0));
    await tester.pumpAndSettle();

    expect(find.text('18'), findsNothing);
  });
}
