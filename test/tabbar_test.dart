import 'package:flant/flant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';

const Color activeColor = FlanThemeVars.blue;

Color? getTextColor(WidgetTester tester, Finder text) {
  return tester.renderObject<RenderParagraph>(text).text.style?.color;
}

void main() {
  testWidgets('should match active tab by click item',
      (WidgetTester tester) async {
    String current = '';
    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: StatefulBuilder(
            // ignore: always_specify_types
            builder: (BuildContext context, setState) {
              return FlanTabbar(
                value: current,
                onChange: (String value) {
                  current = value;
                  setState(() {});
                },
                children: <FlanTabbarItem>[
                  FlanTabbarItem(
                    textBuilder: (BuildContext context, bool active) =>
                        const Text('Tab'),
                  ),
                  FlanTabbarItem(
                    textBuilder: (BuildContext context, bool active) =>
                        const Text('Tab'),
                  ),
                  FlanTabbarItem(
                    textBuilder: (BuildContext context, bool active) =>
                        const Text('Tab'),
                  ),
                  FlanTabbarItem(
                    textBuilder: (BuildContext context, bool active) =>
                        const Text('Tab'),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
    final Finder items = find.text('Tab');
    await tester.tap(items.at(0));
    await tester.pump();
    expect(getTextColor(tester, items.at(0)), activeColor);

    await tester.tap(items.at(1));
    await tester.pump();
    expect(getTextColor(tester, items.at(1)), activeColor);

    await tester.tap(items.at(2));
    await tester.pump();
    expect(getTextColor(tester, items.at(2)), activeColor);

    await tester.tap(items.at(3));
    await tester.pump();
    expect(getTextColor(tester, items.at(3)), activeColor);
  });

  testWidgets('should match active tab by click item when using name prop',
      (WidgetTester tester) async {
    String current = '';
    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: StatefulBuilder(
            // ignore: always_specify_types
            builder: (BuildContext context, setState) {
              return FlanTabbar(
                value: current,
                onChange: (String value) {
                  current = value;
                  setState(() {});
                },
                children: <FlanTabbarItem>[
                  FlanTabbarItem(
                    name: '/',
                    textBuilder: (BuildContext context, bool active) =>
                        const Text('Tab'),
                  ),
                  FlanTabbarItem(
                    name: '/search',
                    textBuilder: (BuildContext context, bool active) =>
                        const Text('Tab'),
                  ),
                  FlanTabbarItem(
                    name: '/star',
                    textBuilder: (BuildContext context, bool active) =>
                        const Text('Tab'),
                  ),
                  FlanTabbarItem(
                    name: '/stars',
                    textBuilder: (BuildContext context, bool active) =>
                        const Text('Tab'),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
    final Finder items = find.text('Tab');
    await tester.tap(items.at(0));
    await tester.pump();
    expect(getTextColor(tester, items.at(0)), activeColor);

    await tester.tap(items.at(1));
    await tester.pump();
    expect(getTextColor(tester, items.at(1)), activeColor);

    await tester.tap(items.at(2));
    await tester.pump();
    expect(getTextColor(tester, items.at(2)), activeColor);

    await tester.tap(items.at(3));
    await tester.pump();
    expect(getTextColor(tester, items.at(3)), activeColor);
  });

  testWidgets('should watch model-value and update active tab',
      (WidgetTester tester) async {
    String current = '1';
    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: StatefulBuilder(
            // ignore: always_specify_types
            builder: (BuildContext context, setState) {
              return FlanTabbar(
                value: current,
                onChange: (String value) {
                  setState(() => current = value);
                },
                children: <FlanTabbarItem>[
                  FlanTabbarItem(
                    textBuilder: (BuildContext context, bool active) =>
                        const Text('Tab'),
                  ),
                  FlanTabbarItem(
                    textBuilder: (BuildContext context, bool active) =>
                        const Text('Tab'),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
    final Finder items = find.text('Tab');
    await tester.tap(items.at(1));
    await tester.pump();
    expect(getTextColor(tester, items.at(1)), activeColor);
    expect(current, equals('1'));
  });

  testWidgets('should match active tab by name when using name prop',
      (WidgetTester tester) async {
    String current = 'a';
    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: StatefulBuilder(
            // ignore: always_specify_types
            builder: (BuildContext context, setState) {
              return FlanTabbar(
                value: current,
                onChange: (String value) {
                  setState(() => current = value);
                },
                children: <FlanTabbarItem>[
                  FlanTabbarItem(
                    name: 'a',
                    textBuilder: (BuildContext context, bool active) =>
                        const Text('Tab'),
                  ),
                  FlanTabbarItem(
                    name: 'b',
                    textBuilder: (BuildContext context, bool active) =>
                        const Text('Tab'),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
    final Finder items = find.text('Tab');
    await tester.tap(items.at(1));
    await tester.pump();
    expect(getTextColor(tester, items.at(1)), activeColor);
    expect(current, equals('b'));
  });

  testWidgets('should not render border when border prop is false',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Material(
          child: FlanTabbar(
            border: false,
            children: <FlanTabbarItem>[],
          ),
        ),
      ),
    );
    final Finder tabbar = find.byType(DecoratedBox);
    final BoxDecoration decoration =
        tester.widget<DecoratedBox>(tabbar).decoration as BoxDecoration;
    expect(decoration.border, isNull);
  });
}
