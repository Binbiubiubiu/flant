import 'package:flant/flant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
    'should allow to intercept closing action with before-close prop',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
            FlanS.delegate
          ],
          home: Builder(
            builder: (BuildContext context) {
              Future<dynamic>.delayed(const Duration(milliseconds: 200)).then(
                (dynamic value) => FlanDialog.alert(
                  context,
                  showCancelButton: true,
                  title: 'Title',
                  beforeClose: (FlanDialogAction action) async =>
                      action == FlanDialogAction.cancel,
                ),
              );
              return const SizedBox.shrink();
            },
          ),
        ),
      );
      await tester.pumpAndSettle(const Duration(seconds: 1));
      final Finder cancel = find.byType(FlanButton).at(0);
      final Finder confirm = find.byType(FlanButton).at(1);
      final Finder title = find.text('Title');
      await tester.tap(confirm);
      await tester.pumpAndSettle(const Duration(seconds: 1));
      expect(title, findsOneWidget);

      await tester.tap(cancel);
      await tester.pumpAndSettle(const Duration(seconds: 1));
      expect(title, findsNothing);
    },
  );

  testWidgets(
    'should change confirm button color when using confirm-button-color prop',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
            FlanS.delegate
          ],
          home: Builder(
            builder: (BuildContext context) {
              Future<dynamic>.delayed(const Duration(milliseconds: 200)).then(
                (dynamic value) => FlanDialog.alert(
                  context,
                  confirmButtonText: 'Confirm',
                  confirmButtonColor: Colors.red,
                ),
              );
              return const SizedBox.shrink();
            },
          ),
        ),
      );
      await tester.pumpAndSettle(const Duration(seconds: 1));
      final Finder confirm = find.text('Confirm');

      expect(
          tester.firstRenderObject<RenderParagraph>(confirm).text.style?.color,
          equals(Colors.red));
    },
  );

  testWidgets(
    'should change cancel button color when using cancel-button-color prop',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
            FlanS.delegate
          ],
          home: Builder(
            builder: (BuildContext context) {
              Future<dynamic>.delayed(const Duration(milliseconds: 200)).then(
                (dynamic value) => FlanDialog.alert(
                  context,
                  cancelButtonText: 'Cancel',
                  showCancelButton: true,
                  cancelButtonColor: Colors.red,
                ),
              );
              return const SizedBox.shrink();
            },
          ),
        ),
      );
      await tester.pumpAndSettle(const Duration(seconds: 1));
      final Finder cancel = find.text('Cancel');

      expect(
          tester.firstRenderObject<RenderParagraph>(cancel).text.style?.color,
          equals(Colors.red));
    },
  );

  testWidgets(
    'should change cancel button color when using cancel-button-color prop',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
            FlanS.delegate
          ],
          home: Builder(
            builder: (BuildContext context) {
              Future<dynamic>.delayed(const Duration(milliseconds: 200)).then(
                (dynamic value) => FlanDialog.alert(
                  context,
                  showCancelButton: true,
                  cancelButtonText: 'Cancel',
                  confirmButtonText: 'Confirm',
                ),
              );
              return const SizedBox.shrink();
            },
          ),
        ),
      );
      await tester.pumpAndSettle(const Duration(seconds: 1));

      expect(find.text('Confirm'), findsOneWidget);
      expect(find.text('Cancel'), findsOneWidget);
    },
  );

  testWidgets(
    'should render default slot correctly',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
            FlanS.delegate
          ],
          home: Builder(
            builder: (BuildContext context) {
              Future<dynamic>.delayed(const Duration(milliseconds: 200)).then(
                (dynamic value) => FlanDialog.alert(
                  context,
                  builder: (BuildContext context) {
                    return const Text('Custom Message');
                  },
                ),
              );
              return const SizedBox.shrink();
            },
          ),
        ),
      );
      await tester.pumpAndSettle(const Duration(seconds: 1));

      expect(find.text('Custom Message'), findsOneWidget);
    },
  );

  testWidgets(
    'should render title slot correctly',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
            FlanS.delegate
          ],
          home: Builder(
            builder: (BuildContext context) {
              Future<dynamic>.delayed(const Duration(milliseconds: 200)).then(
                (dynamic value) => FlanDialog.alert(
                  context,
                  titleBuilder: (BuildContext context) {
                    return const Text('Custom Title');
                  },
                ),
              );
              return const SizedBox.shrink();
            },
          ),
        ),
      );
      await tester.pumpAndSettle(const Duration(seconds: 1));

      expect(find.text('Custom Title'), findsOneWidget);
    },
  );

  testWidgets(
    'should render footer slot correctly',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
            FlanS.delegate
          ],
          home: Builder(
            builder: (BuildContext context) {
              Future<dynamic>.delayed(const Duration(milliseconds: 200)).then(
                (dynamic value) => FlanDialog.alert(
                  context,
                  footerBuilder: (BuildContext context) {
                    return const Text('Custom Footer');
                  },
                ),
              );
              return const SizedBox.shrink();
            },
          ),
        ),
      );
      await tester.pumpAndSettle(const Duration(seconds: 1));

      expect(find.text('Custom Footer'), findsOneWidget);
    },
  );

  testWidgets(
    'should emit open event when show ',
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
                (dynamic value) => FlanDialog.alert(
                  context,
                  onOpen: () {
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

      expect(a, equals(1));
    },
  );

  testWidgets(
    'should emit close event when show ',
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
                (dynamic value) => FlanDialog.alert(
                  context,
                  onClose: () {
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
      await tester.tap(find.byType(FlanButton));
      await tester.pumpAndSettle(const Duration(seconds: 1));
      expect(a, equals(1));
    },
  );

  testWidgets(
    'should update width when using width prop ',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
            FlanS.delegate
          ],
          home: Builder(
            builder: (BuildContext context) {
              Future<dynamic>.delayed(const Duration(milliseconds: 200)).then(
                (dynamic value) => FlanDialog.alert(
                  context,
                  width: 200,
                ),
              );
              return const SizedBox.shrink();
            },
          ),
        ),
      );
      await tester.pumpAndSettle(const Duration(seconds: 1));
      final Finder dialog = find.byType(FlanDialogWidget);
      expect(tester.getSize(dialog).width, equals(200.0));
    },
  );
}
