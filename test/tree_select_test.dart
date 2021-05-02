// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_test/flutter_test.dart';

// 🌎 Project imports:
import 'package:flant/flant.dart';

FlanTreeSelectChild mockItem = FlanTreeSelectChild.fromJson(<String, dynamic>{
  'text': 'city1',
  'id': '1',
});

FlanTreeSelectChild mockItem2 = FlanTreeSelectChild.fromJson(<String, dynamic>{
  'text': 'city2',
  'id': '2',
});

List<FlanTreeSelectItem> mockItems = <FlanTreeSelectItem>[
  FlanTreeSelectItem(
    text: 'group1',
    children: <FlanTreeSelectChild>[mockItem],
  ),
  FlanTreeSelectItem(
    text: 'group2',
    children: <FlanTreeSelectChild>[mockItem],
  ),
];

void main() {
  testWidgets('should render empty TreeSelect correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Material(
          child: FlanTreeSelect(),
        ),
      ),
    );

    expect(find.byType(FlanTreeSelect), findsOneWidget);
  });

  testWidgets('should emit click-nav event when nav item is clicked',
      (WidgetTester tester) async {
    int mainActiveIndex = 0;
    int index = 0;
    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: FlanTreeSelect(
            items: mockItems,
            onMainActiveIndexChange: (int _mainActiveIndex) {
              mainActiveIndex = _mainActiveIndex;
            },
            onClickNav: (int _index) {
              index = _index;
            },
          ),
        ),
      ),
    );
    await tester.tap(find.byType(FlanSidebarItem).at(1));
    expect(mainActiveIndex, equals(1));
    expect(index, equals(1));
  });

  testWidgets('should emit click-item event when item is clicked',
      (WidgetTester tester) async {
    int mainActiveIndex = 0;
    int index = 0;
    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: FlanTreeSelect(
            items: mockItems,
            onMainActiveIndexChange: (int _mainActiveIndex) {
              mainActiveIndex = _mainActiveIndex;
            },
            onClickNav: (int _index) {
              index = _index;
            },
          ),
        ),
      ),
    );
    await tester.tap(find.text('city1'));
    expect(mainActiveIndex, equals(0));
    expect(index, equals(0));
  });

  testWidgets(
      'should not emit click-nav event when disabled nav item is clicked',
      (WidgetTester tester) async {
    int mainActiveIndex = 1;
    int index = 1;
    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: FlanTreeSelect(
            items: <FlanTreeSelectItem>[
              FlanTreeSelectItem(
                text: 'group1',
                children: <FlanTreeSelectChild>[mockItem],
                disabled: true,
              ),
            ],
            onMainActiveIndexChange: (int _mainActiveIndex) {
              mainActiveIndex = _mainActiveIndex;
            },
            onClickNav: (int _index) {
              index = _index;
            },
          ),
        ),
      ),
    );
    await tester.tap(find.text('group1'));
    expect(mainActiveIndex, equals(1));
    expect(index, equals(1));
  });

  testWidgets('should not emit click-item event when disabled item is clicked',
      (WidgetTester tester) async {
    int mainActiveIndex = 1;
    int index = 1;
    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: FlanTreeSelect(
            items: <FlanTreeSelectItem>[
              FlanTreeSelectItem(
                text: 'group1',
                children: <FlanTreeSelectChild>[
                  FlanTreeSelectChild(
                    id: '1',
                    text: 'city1',
                    disabled: true,
                  ),
                ],
                disabled: true,
              ),
            ],
            onMainActiveIndexChange: (int _mainActiveIndex) {
              mainActiveIndex = _mainActiveIndex;
            },
            onClickNav: (int _index) {
              index = _index;
            },
          ),
        ),
      ),
    );
    await tester.tap(find.text('city1'));
    expect(mainActiveIndex, equals(1));
    expect(index, equals(1));
  });

  testWidgets('should render content slot correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: FlanTreeSelect(
            items: <FlanTreeSelectItem>[
              FlanTreeSelectItem(
                text: 'group1',
              ),
            ],
            child: const Text('Custom Content'),
          ),
        ),
      ),
    );
    expect(find.text('group1'), findsOneWidget);
    expect(find.text('Custom Content'), findsOneWidget);
  });

  testWidgets('should render content slot correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: FlanTreeSelect(
            height: 100.0,
          ),
        ),
      ),
    );

    expect(tester.getSize(find.byType(FlanTreeSelect)).height, equals(100.0));
  });

  testWidgets('should render content slot correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: FlanTreeSelect(
            items: <FlanTreeSelectItem>[
              FlanTreeSelectItem(
                text: 'group1',
                badge: '3',
              ),
            ],
          ),
        ),
      ),
    );

    expect(find.text('group1'), findsOneWidget);
    expect(find.text('3'), findsOneWidget);
  });

  testWidgets('should allow to select multiple items when activeId is array',
      (WidgetTester tester) async {
    List<String> activeIds = <String>[];
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: StatefulBuilder(
            // ignore: always_specify_types
            builder: (BuildContext context, setState) {
              return FlanTreeSelect(
                activeId: activeIds,
                isMulit: true,
                onActiveIdChange: (List<String> _activeId) {
                  activeIds = _activeId;
                  setState(() {});
                },
                items: <FlanTreeSelectItem>[
                  FlanTreeSelectItem(
                    text: 'group1',
                    children: <FlanTreeSelectChild>[mockItem, mockItem2],
                  ),
                ],
                mainActiveIndex: 0,
              );
            },
          ),
        ),
      ),
    );
    final Finder item1 = find.text('city1');
    final Finder item2 = find.text('city2');
    await tester.tap(item1);
    await tester.pumpAndSettle();
    await tester.tap(item2);
    await tester.pumpAndSettle();
    expect(activeIds, equals(<String>[mockItem.id, mockItem2.id]));
    await tester.tap(item1);
    await tester.pumpAndSettle();
    await tester.tap(item2);
    expect(activeIds, equals(<String>[]));
  });

  testWidgets('should limit the selected item number when using max prop',
      (WidgetTester tester) async {
    List<String> activeIds = <String>[];
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: StatefulBuilder(
            // ignore: always_specify_types
            builder: (BuildContext context, setState) {
              return FlanTreeSelect(
                activeId: activeIds,
                isMulit: true,
                onActiveIdChange: (List<String> _activeId) {
                  activeIds = _activeId;
                  setState(() {});
                },
                items: <FlanTreeSelectItem>[
                  FlanTreeSelectItem(
                    text: 'group1',
                    children: <FlanTreeSelectChild>[mockItem, mockItem2],
                  ),
                ],
                mainActiveIndex: 0,
                max: 1,
              );
            },
          ),
        ),
      ),
    );
    final Finder item1 = find.text('city1');
    final Finder item2 = find.text('city2');
    await tester.tap(item1);
    await tester.pumpAndSettle();
    await tester.tap(item2);
    await tester.pumpAndSettle();
    expect(activeIds, equals(<String>[mockItem.id]));
  });

  testWidgets('should change selected icon when using selected-icon prop',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: StatefulBuilder(
            // ignore: always_specify_types
            builder: (BuildContext context, setState) {
              return FlanTreeSelect(
                activeId: const <String>['1'],
                items: <FlanTreeSelectItem>[
                  FlanTreeSelectItem(
                    text: 'group1',
                    children: <FlanTreeSelectChild>[mockItem, mockItem2],
                  ),
                ],
                mainActiveIndex: 0,
                selectedIconName: FlanIcons.add,
              );
            },
          ),
        ),
      ),
    );

    expect(find.byIcon(FlanIcons.add), findsOneWidget);
  });
}
