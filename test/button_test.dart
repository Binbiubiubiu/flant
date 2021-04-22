// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_test/flutter_test.dart';

// 🌎 Project imports:
import 'package:flant/flant.dart';

void main() {
  testWidgets('should emit click event', (WidgetTester tester) async {
    int a = 1;
    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: FlanButton(
            onClick: () => a += 1,
          ),
        ),
      ),
    );
    await tester.tap(find.byType(FlanButton));
    await tester.pump();
    expect(a, 2);
  });

  testWidgets('should not emit click event when disabled',
      (WidgetTester tester) async {
    int a = 1;
    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: FlanButton(
            disabled: true,
            onClick: () => a += 1,
          ),
        ),
      ),
    );
    await tester.tap(find.byType(FlanButton));
    await tester.pump();
    expect(a, 1);
  });

  testWidgets('should not emit click event when loading',
      (WidgetTester tester) async {
    int a = 1;
    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: FlanButton(
            loading: true,
            onClick: () => a += 1,
          ),
        ),
      ),
    );
    await tester.tap(find.byType(FlanButton));
    await tester.pump();
    expect(a, 1);
  });

  testWidgets('should hide border when color is gradient',
      (WidgetTester tester) async {
    const LinearGradient gradient = LinearGradient(
      colors: <Color>[Colors.black, Colors.white],
    );
    await tester.pumpWidget(
      const MaterialApp(
        home: Material(
          child: FlanButton(
            gradient: gradient,
          ),
        ),
      ),
    );
    final Finder ink = find.byType(Ink);
    expect(ink, findsOneWidget);
    final BoxDecoration boxDecoration =
        tester.widget<Ink>(ink).decoration as BoxDecoration;
    expect(boxDecoration.gradient, gradient);
  });

  testWidgets('should change icon class prefix when using icon-prefix prop',
      (WidgetTester tester) async {
    const IconData icon = IconData(0xF0C8, fontFamily: kFlanIconsFamily);
    await tester.pumpWidget(
      const MaterialApp(
        home: Material(
          child: FlanButton(
            iconName: icon,
          ),
        ),
      ),
    );

    expect(find.byIcon(icon), findsOneWidget);
  });

  testWidgets('hould render loading slot correctly',
      (WidgetTester tester) async {
    const IconData icon = IconData(0xF0C8, fontFamily: kFlanIconsFamily);
    await tester.pumpWidget(
      const MaterialApp(
        home: Material(
          child: FlanButton(
            loading: true,
            loadingSlot: Text('Custom Loading'),
          ),
        ),
      ),
    );
    expect(find.text('Custom Loading'), findsOneWidget);
  });

  testWidgets(
      'should render loading of a specific size when using loading-size prop',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Material(
          child: FlanButton(
            loading: true,
            loadingSize: 10.0,
          ),
        ),
      ),
    );

    expect(find.byType(FlanLoading), findsOneWidget);
    expect(tester.getSize(find.byType(FlanLoading)), const Size(10.0, 10.0));
  });

  testWidgets(
      'should render icon in the right side when setting icon-position to right',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Material(
          child: FlanButton(
            iconName: FlanIcons.plus,
            iconPosition: FlanButtonIconPosition.right,
          ),
        ),
      ),
    );

    expect(find.byIcon(FlanIcons.plus), findsOneWidget);
  });
}
