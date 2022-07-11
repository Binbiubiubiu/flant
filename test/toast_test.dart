import 'package:flant/flant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('should change overlay style after using overlay-style prop',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (BuildContext context) {
              Future<dynamic>.delayed(const Duration(milliseconds: 200)).then(
                (dynamic value) => FlanToast(
                  context,
                  overlay: true,
                  overlayStyle: const BoxDecoration(color: Colors.red),
                ),
              );
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );

    await tester.pumpAndSettle(const Duration(seconds: 1));
    final Finder overlay = find.byType(DecoratedBox).at(0);

    final BoxDecoration style =
        tester.firstWidget<DecoratedBox>(overlay).decoration as BoxDecoration;
    expect(style.color, equals(Colors.red));
    await tester.pumpAndSettle(const Duration(seconds: 2));
  });

  testWidgets('should close Toast when using closeOnClick prop and clicked',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (BuildContext context) {
              Future<dynamic>.delayed(const Duration(milliseconds: 200)).then(
                (dynamic value) => FlanToast(
                  context,
                  closeOnClick: true,
                ),
              );
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );

    await tester.pumpAndSettle(const Duration(seconds: 1));

    final Finder overlay = find.byType(DecoratedBox);
    await tester.tap(overlay);
    await tester.pumpAndSettle();
    expect(overlay, findsNothing);
  });

  testWidgets(
      'should close Toast when using closeOnClickOverlay prop and overlay is clicked',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (BuildContext context) {
              Future<dynamic>.delayed(const Duration(milliseconds: 200)).then(
                (dynamic value) => FlanToast(
                  context,
                  overlay: true,
                  closeOnClickOverlay: true,
                ),
              );
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );

    await tester.pumpAndSettle(const Duration(seconds: 1));
    final Finder overlay = find.byType(DecoratedBox);
    await tester.tapAt(const Offset(20.0, 20.0));
    await tester.pumpAndSettle(const Duration(milliseconds: 300));
    expect(overlay, findsNothing);
  });

  testWidgets('create a forbidClick toast', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (BuildContext context) {
              Future<dynamic>.delayed(const Duration(milliseconds: 200)).then(
                (dynamic value) => FlanToast(
                  context,
                  overlay: true,
                  forbidClick: true,
                  closeOnClickOverlay: true,
                ),
              );
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );

    await tester.pumpAndSettle(const Duration(seconds: 1));
    final Finder overlay = find.byType(DecoratedBox);
    await tester.tapAt(const Offset(20.0, 20.0));
    await tester.pumpAndSettle();
    expect(overlay, findsWidgets);
    await tester.pumpAndSettle(const Duration(seconds: 2));
  });

  testWidgets('should change icon size when using icon-size prop',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (BuildContext context) {
              Future<dynamic>.delayed(const Duration(milliseconds: 200)).then(
                (dynamic value) => FlanToast(
                  context,
                  iconName: FlanIcons.success,
                  iconSize: 10.0,
                ),
              );
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );

    await tester.pumpAndSettle(const Duration(seconds: 1));
    final Finder icon = find.byIcon(FlanIcons.success);
    expect(tester.getSize(icon), const Size(10.0, 10.0));
    await tester.pumpAndSettle(const Duration(seconds: 2));
  });

  testWidgets('should change loading icon size when using icon-size prop',
      (WidgetTester tester) async {
    await tester.pumpFrames(
      MaterialApp(
        home: Material(
          child: Builder(
            builder: (BuildContext context) {
              Future<dynamic>.delayed(const Duration(milliseconds: 100)).then(
                (dynamic value) => FlanToast(
                  context,
                  type: FlanToastType.loading,
                  iconSize: 10.0,
                ),
              );
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
      const Duration(seconds: 1),
    );

    final Finder loading = find.byType(FlanLoading);
    expect(tester.getSize(loading), const Size(10.0, 10.0));
    await tester.pumpAndSettle(const Duration(seconds: 1));
  });

  testWidgets('toast disappeared after duration', (WidgetTester tester) async {
    int a = 0;
    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: Builder(
            builder: (BuildContext context) {
              Future<dynamic>.delayed(const Duration(milliseconds: 100)).then(
                (dynamic value) => FlanToast(
                  context,
                  duration: const Duration(milliseconds: 10),
                  onClose: () {
                    a++;
                  },
                ),
              );
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );

    expect(a, equals(0));
    await tester.pumpAndSettle();
    expect(a, equals(1));
  });

  testWidgets('show loading toast', (WidgetTester tester) async {
    await tester.pumpFrames(
      MaterialApp(
        home: Material(
          child: Builder(
            builder: (BuildContext context) {
              Future<dynamic>.delayed(const Duration(milliseconds: 100)).then(
                (dynamic value) => FlanToast(
                  context,
                  type: FlanToastType.loading,
                ),
              );
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
      const Duration(seconds: 1),
    );
    expect(find.byType(FlanLoading), findsOneWidget);
    await tester.pumpAndSettle(const Duration(seconds: 1));
  });

  testWidgets('icon prop', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: Builder(
            builder: (BuildContext context) {
              Future<dynamic>.delayed(const Duration(milliseconds: 100)).then(
                (dynamic value) => FlanToast(
                  context,
                  iconName: FlanIcons.add,
                ),
              );
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
    await tester.pumpAndSettle(const Duration(seconds: 1));
    expect(find.byIcon(FlanIcons.add), findsOneWidget);
    await tester.pumpAndSettle(const Duration(seconds: 1));
  });

  testWidgets('clear toast', (WidgetTester tester) async {
    int a = 0;
    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: Builder(
            builder: (BuildContext context) {
              Future<dynamic>.delayed(const Duration(milliseconds: 100)).then(
                (dynamic value) => FlanToast(context, onClose: () {
                  a++;
                }),
              );
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
    await tester.pumpAndSettle(const Duration(seconds: 1));
    expect(a, equals(0));
    FlanToast.clearAll(false);
    await tester.pumpAndSettle();
    expect(a, equals(1));

    FlanToast.allowMultiple();

    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: Builder(
            builder: (BuildContext context) {
              Future<dynamic>.delayed(const Duration(milliseconds: 100)).then(
                (dynamic value) {
                  FlanToast(context, onClose: () {
                    a++;
                  });
                },
              );
              Future<dynamic>.delayed(const Duration(milliseconds: 200)).then(
                (dynamic value) {
                  FlanToast(context, onClose: () {
                    a++;
                  });
                },
              );
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    FlanToast.clearAll(true);
    await tester.pumpAndSettle();
    expect(a, equals(3));
    FlanToast.allowMultiple(false);
    await tester.pumpAndSettle(const Duration(seconds: 2));
  });

  testWidgets('clear toast', (WidgetTester tester) async {
    int a = 0;

    FlanToast.allowMultiple(true);

    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: Builder(
            builder: (BuildContext context) {
              Future<dynamic>.delayed(const Duration(milliseconds: 100)).then(
                (dynamic value) {
                  FlanToast(context, onClose: () {
                    a++;
                  });
                  FlanToast(context, onClose: () {
                    a++;
                  });
                },
              );

              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    FlanToast.clearAll(false);
    await tester.pumpAndSettle();
    expect(a, equals(1));
    FlanToast.clearAll(false);
    await tester.pumpAndSettle();
    expect(a, equals(2));
    FlanToast.allowMultiple(false);
    await tester.pumpAndSettle(const Duration(seconds: 2));
  });

  testWidgets('remove toast DOM when cleared in multiple mode',
      (WidgetTester tester) async {
    int a = 0;

    FlanToast.allowMultiple();
    FlanToast.clearAll(false);
    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: Builder(
            builder: (BuildContext context) {
              Future<dynamic>.delayed(const Duration(milliseconds: 100)).then(
                (dynamic value) {
                  FlanToast(context, onClose: () {
                    a++;
                  });
                },
              );

              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    FlanToast.clearAll(false);
    await tester.pumpAndSettle();
    expect(a, equals(1));
    FlanToast.allowMultiple(false);
    await tester.pumpAndSettle(const Duration(seconds: 2));
  });

  testWidgets('set default options', (WidgetTester tester) async {
    FlanToast.setDefaultOptions(const FlanToastOption(message: '123'));

    await tester.pumpFrames(
      MaterialApp(
        home: Material(
          child: Builder(
            builder: (BuildContext context) {
              Future<dynamic>.delayed(const Duration(milliseconds: 100)).then(
                (dynamic value) {
                  FlanToast(context);
                },
              );

              return const SizedBox.shrink();
            },
          ),
        ),
      ),
      const Duration(seconds: 1),
    );
    expect(find.text('123'), findsOneWidget);
    FlanToast.resetDefaultOptions();
    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: Builder(
            builder: (BuildContext context) {
              Future<dynamic>.delayed(const Duration(milliseconds: 100)).then(
                (dynamic value) {
                  FlanToast(context);
                },
              );

              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('123'), findsNothing);
    await tester.pumpAndSettle(const Duration(seconds: 2));
  });

  testWidgets('set default options by type', (WidgetTester tester) async {
    FlanToast.allowMultiple();
    FlanToast.setDefaultOptions(
      const FlanToastOption(message: '123'),
      type: FlanToastType.loading,
    );

    await tester.pumpFrames(MaterialApp(
      home: Material(
        child: Builder(
          builder: (BuildContext context) {
            Future<dynamic>.delayed(const Duration(milliseconds: 100)).then(
              (dynamic value) {
                FlanToast(
                  context,
                  type: FlanToastType.fail,
                );
                FlanToast(
                  context,
                  type: FlanToastType.success,
                );
                FlanToast(
                  context,
                  type: FlanToastType.loading,
                );
              },
            );

            return const SizedBox.shrink();
          },
        ),
      ),
    ), const Duration(seconds: 1));

    expect(find.text('123'), findsOneWidget);
    FlanToast.allowMultiple(false);
    await tester.pumpAndSettle(const Duration(seconds: 2));
    FlanToast.resetDefaultOptions();
  });

  testWidgets('set default options by type', (WidgetTester tester) async {
    int a = 0;
    await tester.pumpWidget(MaterialApp(
      home: Material(
        child: Builder(
          builder: (BuildContext context) {
            Future<dynamic>.delayed(const Duration(milliseconds: 100)).then(
              (dynamic value) {
                FlanToast(
                  context,
                  duration: Duration.zero,
                  onClose: () {
                    a++;
                  },
                );
              },
            );

            return const SizedBox.shrink();
          },
        ),
      ),
    ));
    await tester.pumpAndSettle(const Duration(seconds: 3));
    expect(a, equals(0));
  });

  testWidgets('should trigger onClose callback after closed',
      (WidgetTester tester) async {
    FlanToast.clearAll(true);
    FlanToast.allowMultiple(true);
    int a = 0;
    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: Builder(
            builder: (BuildContext context) {
              Future<dynamic>.delayed(const Duration(milliseconds: 100)).then(
                (dynamic value) {
                  FlanToast(
                    context,
                    onClose: () {
                      print(a);
                      a++;
                    },
                  );
                },
              );

              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
    await tester.pumpAndSettle(const Duration(seconds: 1));
    FlanToast.clearAll(false);
    await tester.pumpAndSettle(const Duration(milliseconds: 100));
    expect(a, equals(1));
    await tester.pumpAndSettle(const Duration(seconds: 1));
    FlanToast.clearAll(false);
    await tester.pumpAndSettle(const Duration(milliseconds: 100));
    expect(a, equals(1));
    FlanToast.allowMultiple(false);
  });
}
