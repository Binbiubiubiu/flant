import 'package:flant/flant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
    'should emit select event after clicking option',
    (WidgetTester tester) async {
      FlanActionSheetAction? target;
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (BuildContext context) {
              Future<dynamic>.delayed(const Duration(milliseconds: 200)).then(
                (dynamic value) => showFlanActionSheet(
                  context,
                  actions: <FlanActionSheetAction>[
                    const FlanActionSheetAction(name: 'Option'),
                  ],
                  onSelect: (FlanActionSheetAction action, int index) {
                    target = action;
                  },
                ),
              );
              return const SizedBox.shrink();
            },
          ),
        ),
      );
      await tester.pumpAndSettle(const Duration(seconds: 1));
      await tester.tap(find.text('Option'));
      expect(target?.name, equals('Option'));
    },
  );

  testWidgets(
    'should call callback function after clicking option',
    (WidgetTester tester) async {
      FlanActionSheetAction? target;
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (BuildContext context) {
              Future<dynamic>.delayed(const Duration(milliseconds: 200)).then(
                (dynamic value) => showFlanActionSheet(
                  context,
                  actions: <FlanActionSheetAction>[
                    FlanActionSheetAction(
                      name: 'Option',
                      callback: (FlanActionSheetAction action) {
                        target = action;
                      },
                    ),
                  ],
                ),
              );
              return const SizedBox.shrink();
            },
          ),
        ),
      );
      await tester.pumpAndSettle(const Duration(seconds: 1));
      await tester.tap(find.text('Option'));
      expect(target?.name, equals('Option'));
    },
  );

  testWidgets(
    'should not emit select event after clicking loading option',
    (WidgetTester tester) async {
      FlanActionSheetAction? target;
      await tester.pumpFrames(
        MaterialApp(
          home: Builder(
            builder: (BuildContext context) {
              Future<dynamic>.delayed(const Duration(milliseconds: 100)).then(
                (dynamic value) => showFlanActionSheet(
                  context,
                  actions: <FlanActionSheetAction>[
                    const FlanActionSheetAction(
                      name: 'Option',
                      loading: true,
                    ),
                  ],
                  onSelect: (FlanActionSheetAction action, int index) {
                    target = action;
                  },
                ),
              );
              return const SizedBox.shrink();
            },
          ),
        ),
        const Duration(seconds: 1),
      );
      // await tester.pumpAndSettle(const Duration(seconds: 1));
      final Finder loading = find.byType(FlanLoading);
      expect(loading, findsOneWidget);
      await tester.tap(loading);
      expect(target, isNull);
    },
  );

  testWidgets(
    'should not emit select event after clicking disabled option',
    (WidgetTester tester) async {
      FlanActionSheetAction? target;
      await tester.pumpFrames(
        MaterialApp(
          home: Builder(
            builder: (BuildContext context) {
              Future<dynamic>.delayed(const Duration(milliseconds: 100)).then(
                (dynamic value) => showFlanActionSheet(
                  context,
                  actions: <FlanActionSheetAction>[
                    const FlanActionSheetAction(
                      name: 'Option',
                      disabled: true,
                    ),
                  ],
                  onSelect: (FlanActionSheetAction action, int index) {
                    target = action;
                  },
                ),
              );
              return const SizedBox.shrink();
            },
          ),
        ),
        const Duration(seconds: 1),
      );
      // await tester.pumpAndSettle(const Duration(seconds: 1));
      final Finder loading = find.text('Option');
      expect(loading, findsOneWidget);
      await tester.tap(loading);
      expect(target, isNull);
    },
  );

  testWidgets(
    'should emit cancel event after clicking cancel button',
    (WidgetTester tester) async {
      int a = 0;
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (BuildContext context) {
              Future<dynamic>.delayed(const Duration(milliseconds: 100)).then(
                (dynamic value) => showFlanActionSheet(
                  context,
                  actions: <FlanActionSheetAction>[
                    const FlanActionSheetAction(
                      name: 'Option',
                    ),
                  ],
                  onCancel: () {
                    a++;
                  },
                  cancelText: 'Cancel',
                ),
              );
              return const SizedBox.shrink();
            },
          ),
        ),
      );
      await tester.pumpAndSettle(const Duration(seconds: 1));
      final Finder cancelBtn = find.text('Cancel');
      expect(cancelBtn, findsOneWidget);
      await tester.tap(cancelBtn);
      expect(a, equals(1));
    },
  );

  testWidgets(
    'should render subname correctly',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (BuildContext context) {
              Future<dynamic>.delayed(const Duration(milliseconds: 100)).then(
                (dynamic value) => showFlanActionSheet(
                  context,
                  actions: <FlanActionSheetAction>[
                    const FlanActionSheetAction(
                      name: 'Option',
                      subname: 'Subname',
                    ),
                  ],
                  cancelText: 'Cancel',
                ),
              );
              return const SizedBox.shrink();
            },
          ),
        ),
      );
      await tester.pumpAndSettle(const Duration(seconds: 1));
      final Finder subname = find.text('Subname');
      expect(subname, findsOneWidget);
    },
  );

  testWidgets(
    'should render builder slot correctly',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (BuildContext context) {
              Future<dynamic>.delayed(const Duration(milliseconds: 100)).then(
                (dynamic value) => showFlanActionSheet(
                  context,
                  title: 'Title',
                  builder: (BuildContext context) {
                    return const Text('Default');
                  },
                ),
              );
              return const SizedBox.shrink();
            },
          ),
        ),
      );
      await tester.pumpAndSettle(const Duration(seconds: 1));
      final Finder subname = find.text('Default');
      expect(subname, findsOneWidget);
    },
  );

  testWidgets(
    'should have radius when setting the round prop',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (BuildContext context) {
              Future<dynamic>.delayed(const Duration(milliseconds: 100)).then(
                (dynamic value) => showFlanActionSheet(
                  context,
                  round: true,
                ),
              );
              return const SizedBox.shrink();
            },
          ),
        ),
      );
      await tester.pumpAndSettle(const Duration(seconds: 1));
      expect(
        tester.firstWidget<Material>(find.byType(Material)).borderRadius,
        isNot(equals(BorderRadius.zero)),
      );
    },
  );

  testWidgets(
    'should change option color when using the color prop',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (BuildContext context) {
              Future<dynamic>.delayed(const Duration(milliseconds: 100)).then(
                (dynamic value) => showFlanActionSheet(
                  context,
                  actions: <FlanActionSheetAction>[
                    const FlanActionSheetAction(
                      name: 'Option',
                      color: Colors.red,
                    ),
                  ],
                ),
              );
              return const SizedBox.shrink();
            },
          ),
        ),
      );
      await tester.pumpAndSettle(const Duration(seconds: 1));
      final Finder text = find.text('Option');
      expect(tester.firstWidget<Text>(text).style?.color, equals(Colors.red));
    },
  );

  testWidgets(
    'should hide close icon when the closeable prop is false',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (BuildContext context) {
              Future<dynamic>.delayed(const Duration(milliseconds: 100)).then(
                (dynamic value) => showFlanActionSheet(
                  context,
                  title: 'Title',
                  closeable: false,
                ),
              );
              return const SizedBox.shrink();
            },
          ),
        ),
      );
      await tester.pumpAndSettle(const Duration(seconds: 1));
      final Finder closeIcon = find.byIcon(FlanIcons.cross);
      expect(closeIcon, findsNothing);
    },
  );

  testWidgets(
    'should allow to custom close icon with closeIcon prop',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (BuildContext context) {
              Future<dynamic>.delayed(const Duration(milliseconds: 100)).then(
                (dynamic value) => showFlanActionSheet(
                  context,
                  title: 'Title',
                  closeIconName: FlanIcons.success,
                ),
              );
              return const SizedBox.shrink();
            },
          ),
        ),
      );
      await tester.pumpAndSettle(const Duration(seconds: 1));
      final Finder closeIcon = find.byIcon(FlanIcons.success);
      expect(closeIcon, findsOneWidget);
    },
  );

  testWidgets(
    'should render description correctly',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (BuildContext context) {
              Future<dynamic>.delayed(const Duration(milliseconds: 100)).then(
                (dynamic value) => showFlanActionSheet(
                  context,
                  title: 'Title',
                  description: 'This is a description',
                ),
              );
              return const SizedBox.shrink();
            },
          ),
        ),
      );
      await tester.pumpAndSettle(const Duration(seconds: 1));
      final Finder description = find.text('This is a description');
      expect(description, findsOneWidget);
    },
  );

  testWidgets(
    'should render cancel slot correctly',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (BuildContext context) {
              Future<dynamic>.delayed(const Duration(milliseconds: 100)).then(
                (dynamic value) => showFlanActionSheet(
                  context,
                  title: 'Title',
                  cancelBuilder: (BuildContext context) {
                    return const Text('Custom Cancel');
                  },
                ),
              );
              return const SizedBox.shrink();
            },
          ),
        ),
      );
      await tester.pumpAndSettle(const Duration(seconds: 1));
      final Finder description = find.text('Custom Cancel');
      expect(description, findsOneWidget);
    },
  );

  testWidgets(
    'should render description slot when match snapshot',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (BuildContext context) {
              Future<dynamic>.delayed(const Duration(milliseconds: 100)).then(
                (dynamic value) => showFlanActionSheet(
                  context,
                  title: 'Title',
                  descriptionBuilder: (BuildContext context) {
                    return const Text('Custom Description');
                  },
                ),
              );
              return const SizedBox.shrink();
            },
          ),
        ),
      );
      await tester.pumpAndSettle(const Duration(seconds: 1));
      final Finder description = find.text('Custom Description');
      expect(description, findsOneWidget);
    },
  );

  testWidgets(
    'should close after clicking option if close-on-click-action prop is true',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (BuildContext context) {
              Future<dynamic>.delayed(const Duration(milliseconds: 100)).then(
                (dynamic value) => showFlanActionSheet(
                  context,
                  actions: <FlanActionSheetAction>[
                    const FlanActionSheetAction(
                      name: 'Option',
                    ),
                  ],
                  closeOnClickAction: true,
                ),
              );
              return const SizedBox.shrink();
            },
          ),
        ),
      );
      await tester.pumpAndSettle(const Duration(seconds: 1));
      final Finder option = find.text('Option');
      expect(option, findsOneWidget);
      await tester.tap(option);
      await tester.pumpAndSettle(const Duration(seconds: 1));
      expect(option, findsNothing);
    },
  );
}
