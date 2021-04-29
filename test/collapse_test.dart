// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_test/flutter_test.dart';

// 🌎 Project imports:
import 'package:flant/flant.dart';

class Example extends StatefulWidget {
  const Example({
    Key? key,
    this.accordion = false,
    this.border = true,
  }) : super(key: key);

  final bool accordion;
  final bool border;

  @override
  ExampleState createState() => ExampleState();
}

class ExampleState extends State<Example> {
  late dynamic active;

  @override
  void initState() {
    active = widget.accordion ? '' : <String>[];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Material(
        child: FlanCollapse(
          value: active,
          accordion: widget.accordion,
          onChange: (dynamic val) {
            setState(() {
              active = val;
            });
          },
          children: <FlanCollapseItem>[
            FlanCollapseItem(
              title: 'a',
              name: 'first',
              child: const Text('content'),
            ),
            FlanCollapseItem(
              title: 'b',
              child: const Text('content'),
            ),
            FlanCollapseItem(
              title: 'c',
              child: const Text('content'),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  testWidgets('should update active value when title is clicked',
      (WidgetTester tester) async {
    final Finder example = find.byType(Example);
    await tester.pumpWidget(const Example());
    await tester.tap(find.byType(FlanCell).at(0));
    expect(
      tester.firstState<ExampleState>(example).active,
      <String>['first'],
    );

    await tester.pumpAndSettle();
    await tester.tap(find.byType(FlanCell).at(1));
    expect(
      tester.firstState<ExampleState>(example).active,
      <String>['first', '1'],
    );

    await tester.pumpAndSettle();
    await tester.tap(find.byType(FlanCell).at(0));
    expect(
      tester.firstState<ExampleState>(example).active,
      <String>['1'],
    );
  });

  testWidgets(
      'should update active value when title is clicked in accordion mode',
      (WidgetTester tester) async {
    await tester.pumpWidget(const Example(
      accordion: true,
    ));
    await tester.tap(find.byType(FlanCell).at(0));
    expect(
        tester.firstState<ExampleState>(find.byType(Example)).active, 'first');

    await tester.pumpAndSettle();
    await tester.tap(find.byType(FlanCell).at(1));
    expect(tester.firstState<ExampleState>(find.byType(Example)).active, '1');

    await tester.pumpAndSettle();
    await tester.tap(find.byType(FlanCell).at(0));
    expect(
        tester.firstState<ExampleState>(find.byType(Example)).active, 'first');
  });

  testWidgets('should render slots of CollapseItem correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: FlanCollapse(
            value: const <String>[],
            onChange: (dynamic val) {},
            children: <FlanCollapseItem>[
              FlanCollapseItem(
                titleSlot: const Text('this is title'),
                valueSlot: const Text('this is value'),
                iconSlot: const Text('this is icon'),
                rightIconSlot: const Text('this is right icon'),
              ),
            ],
          ),
        ),
      ),
    );
    expect(find.text('this is title'), findsOneWidget);
    expect(find.text('this is value'), findsOneWidget);
    expect(find.text('this is icon'), findsOneWidget);
    expect(find.text('this is right icon'), findsOneWidget);
  });

  testWidgets('should not render border when border prop is false',
      (WidgetTester tester) async {
    await tester.pumpWidget(const Example(
      border: false,
    ));
    expect(tester.firstWidget<FlanCell>(find.byType(FlanCell)).border, isFalse);
    expect(
      tester
          .firstWidget<Visibility>(find.byWidgetPredicate((Widget widget) =>
              widget is Visibility && widget.child is Divider))
          .visible,
      isFalse,
    );
  });

  testWidgets('should lazy render collapse content',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: Builder(
            builder: (BuildContext context) {
              List<String> active = <String>[];
              return StatefulBuilder(
                // ignore: always_specify_types
                builder: (BuildContext context, setState) {
                  return FlanCollapse(
                    value: active,
                    onChange: (dynamic val) {
                      setState(() {
                        active = val as List<String>;
                      });
                    },
                    children: <FlanCollapseItem>[
                      FlanCollapseItem(
                        title: 'a',
                        child: const Text('content'),
                      ),
                      FlanCollapseItem(
                        title: 'b',
                        child: const Text('foo'),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ),
      ),
    );
    final Finder content = find.widgetWithText(SingleChildScrollView, 'foo');
    expect(tester.getSize(content).height, equals(0.0));
    await tester.tap(find.byType(FlanCell).at(1));
    await tester.pumpAndSettle();
    expect(tester.getSize(content).height, isNot(equals(0.0)));
  });

  testWidgets('should toggle collapse after calling the toggle method',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: Builder(
            builder: (BuildContext context) {
              List<String> active = <String>[];
              return StatefulBuilder(
                // ignore: always_specify_types
                builder: (BuildContext context, setState) {
                  return FlanCollapse(
                    value: active,
                    onChange: (dynamic val) {
                      setState(() {
                        active = val as List<String>;
                      });
                    },
                    children: <FlanCollapseItem>[
                      FlanCollapseItem(
                        key: const ValueKey<int>(0),
                        name: 'a',
                        child: const Text('content'),
                      ),
                      FlanCollapseItem(
                        key: const ValueKey<int>(1),
                        name: 'b',
                        child: const Text('foo'),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ),
      ),
    );
    final Finder itemA = find.byKey(const ValueKey<int>(0));
    final Finder itemB = find.byKey(const ValueKey<int>(1));
    final Finder collapse = find.byType(FlanCollapse);
    tester.firstState<FlanCollapseItemState>(itemA).toggle();
    await tester.pumpAndSettle();
    expect(
      tester.firstWidget<FlanCollapse>(collapse).value,
      equals(<String>['a']),
    );

    tester.firstState<FlanCollapseItemState>(itemB).toggle();
    await tester.pumpAndSettle();
    expect(
      tester.firstWidget<FlanCollapse>(collapse).value,
      equals(<String>['a', 'b']),
    );

    tester.firstState<FlanCollapseItemState>(itemB).toggle(false);
    await tester.pumpAndSettle();
    expect(
      tester.firstWidget<FlanCollapse>(collapse).value,
      equals(<String>['a']),
    );

    tester.firstState<FlanCollapseItemState>(itemA).toggle();
    await tester.pumpAndSettle();
    expect(
      tester.firstWidget<FlanCollapse>(collapse).value,
      equals(<String>[]),
    );
  });

  testWidgets(
      'should toggle collapse after calling the toggle method in accordion mode',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: Builder(
            builder: (BuildContext context) {
              String active = '';
              return StatefulBuilder(
                // ignore: always_specify_types
                builder: (BuildContext context, setState) {
                  return FlanCollapse(
                    value: active,
                    onChange: (dynamic val) {
                      setState(() {
                        active = val as String;
                      });
                    },
                    accordion: true,
                    children: <FlanCollapseItem>[
                      FlanCollapseItem(
                        key: const ValueKey<int>(0),
                        name: 'a',
                        child: const Text('content'),
                      ),
                      FlanCollapseItem(
                        key: const ValueKey<int>(1),
                        name: 'b',
                        child: const Text('foo'),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ),
      ),
    );
    final Finder itemA = find.byKey(const ValueKey<int>(0));
    final Finder itemB = find.byKey(const ValueKey<int>(1));
    final Finder collapse = find.byType(FlanCollapse);
    tester.firstState<FlanCollapseItemState>(itemA).toggle();
    await tester.pumpAndSettle();
    expect(
      tester.firstWidget<FlanCollapse>(collapse).value,
      equals('a'),
    );

    tester.firstState<FlanCollapseItemState>(itemB).toggle();
    await tester.pumpAndSettle();
    expect(
      tester.firstWidget<FlanCollapse>(collapse).value,
      equals('b'),
    );

    tester.firstState<FlanCollapseItemState>(itemB).toggle(false);
    await tester.pumpAndSettle();
    expect(
      tester.firstWidget<FlanCollapse>(collapse).value,
      equals(''),
    );

    tester.firstState<FlanCollapseItemState>(itemA).toggle();
    await tester.pumpAndSettle();
    expect(
      tester.firstWidget<FlanCollapse>(collapse).value,
      equals('a'),
    );
  });

  testWidgets('should be readonly when using readonly prop',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: Builder(
            builder: (BuildContext context) {
              List<String> active = <String>[];
              return StatefulBuilder(
                // ignore: always_specify_types
                builder: (BuildContext context, setState) {
                  return FlanCollapse(
                    value: active,
                    onChange: (dynamic val) {
                      setState(() {
                        active = val as List<String>;
                      });
                    },
                    children: <FlanCollapseItem>[
                      FlanCollapseItem(
                        key: const ValueKey<int>(0),
                        name: 'a',
                        readonly: true,
                        child: const Text('content'),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ),
      ),
    );
    final Finder itemA = find.byKey(const ValueKey<int>(0));
    final Finder collapse = find.byType(FlanCollapse);

    await tester.tap(itemA);
    await tester.pumpAndSettle();
    expect(
      tester.firstWidget<FlanCollapse>(collapse).value,
      equals(<String>[]),
    );
    expect(
      tester.firstWidget<FlanCell>(find.byType(FlanCell)).clickable,
      isFalse,
    );
  });
}
