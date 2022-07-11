import 'package:flant/flant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('should emit change event when active item changed',
      (WidgetTester tester) async {
    int a = 0;
    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: FlanSidebar(
            onChange: (int value) {
              a = value;
            },
            children: const <Widget>[
              FlanSidebarItem(title: 'Text'),
              FlanSidebarItem(title: 'Text'),
            ],
          ),
        ),
      ),
    );
    final Finder item = find.byType(FlanSidebarItem);
    await tester.tap(item.at(1));
    expect(a, equals(1));
  });

  testWidgets('should emit click event when SidebarItem is clicked',
      (WidgetTester tester) async {
    int a = -1;
    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: FlanSidebar(
            children: <Widget>[
              FlanSidebarItem(
                title: 'Text',
                onClick: (int value) {
                  a = value;
                },
              ),
            ],
          ),
        ),
      ),
    );
    final Finder item = find.byType(FlanSidebarItem);
    await tester.tap(item.at(0));
    expect(a, equals(0));
  });

  testWidgets('should update v-model when active item changed',
      (WidgetTester tester) async {
    int active = 0;
    int a = 0;
    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: FlanSidebar(
            value: active,
            onValueChange: (int i) {
              active = i;
            },
            onChange: (int i) {
              a++;
            },
            children: const <Widget>[
              FlanSidebarItem(title: 'Text'),
              FlanSidebarItem(title: 'Text'),
            ],
          ),
        ),
      ),
    );
    final Finder item = find.byType(FlanSidebarItem);
    await tester.tap(item.at(1));
    expect(active, equals(1));
    expect(a, equals(1));
  });

  testWidgets('should not update v-model when disabled SidebarItem is clicked',
      (WidgetTester tester) async {
    int active = 0;

    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: FlanSidebar(
            value: active,
            onValueChange: (int i) {
              active = i;
            },
            children: const <Widget>[
              FlanSidebarItem(title: 'Text'),
              FlanSidebarItem(title: 'Text', disabled: true),
            ],
          ),
        ),
      ),
    );
    final Finder item = find.byType(FlanSidebarItem);
    await tester.tap(item.at(1));
    expect(active, equals(0));
  });

  testWidgets('should not update v-model when disabled SidebarItem is clicked',
      (WidgetTester tester) async {
    int active = 0;

    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: FlanSidebar(
            value: active,
            onValueChange: (int i) {
              active = i;
            },
            children: const <Widget>[
              FlanSidebarItem(titleSlot: Text('Custom Title')),
            ],
          ),
        ),
      ),
    );
    final Finder item = find.byType(FlanSidebarItem);
    await tester.tap(item.at(0));
    expect(active, equals(0));
    expect(find.text('Custom Title'), findsOneWidget);
  });
}
