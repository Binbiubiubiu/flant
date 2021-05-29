// 🎯 Dart imports:
import 'dart:io';

// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_test/flutter_test.dart';

// 🌎 Project imports:
import 'package:flant/flant.dart';

void main() {
  setUp(() {
    HttpOverrides.global = null;
  });
  testWidgets(
    'should render cancel text when using cancel-text prop',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (BuildContext context) {
              Future<dynamic>.delayed(const Duration(milliseconds: 200)).then(
                (dynamic value) => showFlanShareSheet(
                  context,
                  cancelText: 'foo',
                ),
              );
              return const SizedBox.shrink();
            },
          ),
        ),
      );
      await tester.pumpAndSettle(const Duration(seconds: 1));
      expect(find.text('foo'), findsOneWidget);
    },
  );

  testWidgets(
    'should render description when using description prop',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
            FlanS.delegate
          ],
          home: Builder(
            builder: (BuildContext context) {
              Future<dynamic>.delayed(const Duration(milliseconds: 200)).then(
                (dynamic value) => showFlanShareSheet(
                  context,
                  description: 'foo',
                ),
              );
              return const SizedBox.shrink();
            },
          ),
        ),
      );
      await tester.pumpAndSettle(const Duration(seconds: 1));
      expect(find.text('foo'), findsOneWidget);
    },
  );

  testWidgets(
    'should emit select event when an option is clicked',
    (WidgetTester tester) async {
      FlanShareSheetOption? target;
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
            FlanS.delegate
          ],
          home: Builder(
            builder: (BuildContext context) {
              Future<dynamic>.delayed(const Duration(milliseconds: 200)).then(
                (dynamic value) => showFlanShareSheet(
                  context,
                  options: <FlanShareSheetOption>[
                    FlanShareSheetOption(
                      name: 'wechat',
                      icon: FlanShareSheetIcons.wechat,
                    ),
                  ],
                  onSelect: (FlanShareSheetOption option, int index) {
                    target = option;
                  },
                ),
              );
              return const SizedBox.shrink();
            },
          ),
        ),
      );
      await tester.pumpAndSettle(const Duration(seconds: 1));
      final Finder wechat = find.text('wechat');
      expect(wechat, findsOneWidget);
      await tester.tap(wechat);
      expect(target?.icon, FlanShareSheetIcons.wechat);
    },
  );

  testWidgets(
    'should emit cancel event when the cancel button is clicked',
    (WidgetTester tester) async {
      int a = 0;
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
            FlanS.delegate
          ],
          home: Builder(
            builder: (BuildContext context) {
              Future<dynamic>.delayed(const Duration(milliseconds: 200)).then(
                (dynamic value) => showFlanShareSheet(
                  context,
                  cancelText: 'Cancel',
                  onCancel: () {
                    a++;
                  },
                ),
              );
              return const SizedBox.shrink();
            },
          ),
        ),
      );
      await tester.pumpAndSettle(const Duration(seconds: 1));
      final Finder cancel = find.text('Cancel');
      expect(cancel, findsOneWidget);
      await tester.tap(cancel);
      expect(a, equals(1));
    },
  );

  testWidgets(
    'should render title and description slot correctly',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
            FlanS.delegate
          ],
          home: Builder(
            builder: (BuildContext context) {
              Future<dynamic>.delayed(const Duration(milliseconds: 200)).then(
                (dynamic value) => showFlanShareSheet(
                  context,
                  titleBuilder: (BuildContext context) =>
                      const Text('Custom Title'),
                  descriptionBuilder: (BuildContext context) =>
                      const Text('Custom Description'),
                ),
              );
              return const SizedBox.shrink();
            },
          ),
        ),
      );
      await tester.pumpAndSettle(const Duration(seconds: 1));

      expect(find.text('Custom Title'), findsOneWidget);
      expect(find.text('Custom Description'), findsOneWidget);
    },
  );

  testWidgets(
    'should render cancel slot correctly',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
            FlanS.delegate
          ],
          home: Builder(
            builder: (BuildContext context) {
              Future<dynamic>.delayed(const Duration(milliseconds: 200)).then(
                (dynamic value) => showFlanShareSheet(
                  context,
                  cancelBuilder: (BuildContext context) =>
                      const Text('Custom Cancel'),
                ),
              );
              return const SizedBox.shrink();
            },
          ),
        ),
      );
      await tester.pumpAndSettle(const Duration(seconds: 1));

      expect(find.text('Custom Cancel'), findsOneWidget);
    },
  );
}
