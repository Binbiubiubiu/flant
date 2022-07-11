import 'package:flant/flant.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

final List<String> images = <String>[
  'https://img.yzcdn.cn/1.png',
  'https://img.yzcdn.cn/2.png',
  'https://img.yzcdn.cn/3.png',
];

void main() {
  testWidgets(
    'should render cover slot correctly',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (BuildContext context) {
              Future<dynamic>.delayed(const Duration(milliseconds: 200)).then(
                (dynamic value) => showFlanImagePreview(
                  context,
                  images: images,
                  coverBuilder: (BuildContext context) {
                    return const Text('Custom Cover');
                  },
                ),
              );
              return const SizedBox.shrink();
            },
          ),
        ),
      );
      await tester.pumpAndSettle(const Duration(seconds: 1));

      expect(find.text('Custom Cover'), findsOneWidget);
    },
  );

  testWidgets(
    'should render index slot correctly',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (BuildContext context) {
              Future<dynamic>.delayed(const Duration(milliseconds: 200)).then(
                (dynamic value) => showFlanImagePreview(
                  context,
                  images: images,
                  indexBuilder: (BuildContext context, int index) {
                    return Text('Custom Index: $index');
                  },
                ),
              );
              return const SizedBox.shrink();
            },
          ),
        ),
      );
      await tester.pumpAndSettle(const Duration(seconds: 1));

      expect(find.text('Custom Index: 1'), findsOneWidget);
    },
  );

  testWidgets(
    'should render close icon when using closeable prop',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (BuildContext context) {
              Future<dynamic>.delayed(const Duration(milliseconds: 200)).then(
                (dynamic value) => showFlanImagePreview(
                  context,
                  images: images,
                  closeable: true,
                ),
              );
              return const SizedBox.shrink();
            },
          ),
        ),
      );
      await tester.pumpAndSettle(const Duration(seconds: 1));

      expect(find.byIcon(FlanIcons.clear), findsOneWidget);
    },
  );

  testWidgets(
    'should change close icon when using close-icon prop',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (BuildContext context) {
              Future<dynamic>.delayed(const Duration(milliseconds: 200)).then(
                (dynamic value) => showFlanImagePreview(
                  context,
                  images: images,
                  closeable: true,
                  closeIconName: FlanIcons.success,
                ),
              );
              return const SizedBox.shrink();
            },
          ),
        ),
      );
      await tester.pumpAndSettle(const Duration(seconds: 1));

      expect(find.byIcon(FlanIcons.success), findsOneWidget);
    },
  );

  testWidgets(
    'should change close icon position when using close-icon-position prop',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (BuildContext context) {
              Future<dynamic>.delayed(const Duration(milliseconds: 200)).then(
                (dynamic value) => showFlanImagePreview(
                  context,
                  images: images,
                  closeable: true,
                  closeIconPosition: FlanImagePreviewCloseIconPosition.topLeft,
                ),
              );
              return const SizedBox.shrink();
            },
          ),
        ),
      );
      await tester.pumpAndSettle(const Duration(seconds: 1));
      expect(tester.getTopLeft(find.byIcon(FlanIcons.clear)),
          const Offset(16.0, 16.0));
    },
  );

  testWidgets(
    'should hide index when show-index prop is false',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (BuildContext context) {
              Future<dynamic>.delayed(const Duration(milliseconds: 200)).then(
                (dynamic value) => showFlanImagePreview(
                  context,
                  images: images,
                  showIndex: false,
                ),
              );
              return const SizedBox.shrink();
            },
          ),
        ),
      );
      await tester.pumpAndSettle(const Duration(seconds: 1));
      expect(find.text('1 / 3'), findsNothing);
    },
  );

  testWidgets(
    'before close prop',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (BuildContext context) {
              Future<dynamic>.delayed(const Duration(milliseconds: 200)).then(
                (dynamic value) => showFlanImagePreview(
                  context,
                  images: images,
                  beforeClose: (int active) async =>
                      Future<void>.delayed(const Duration(seconds: 2))
                          .then((_) => true),
                ),
              );
              return const SizedBox.shrink();
            },
          ),
        ),
      );
      await tester.pumpAndSettle(const Duration(seconds: 1));
      await tester.tapAt(const Offset(200, 200));
      await tester.pumpAndSettle(const Duration(seconds: 1));
      expect(find.byType(Image), findsWidgets);
      await tester.pumpAndSettle(const Duration(seconds: 2));
      expect(find.byType(Image), findsNothing);
    },
  );

  testWidgets(
    'function call',
    (WidgetTester tester) async {
      int a = 0;
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (BuildContext context) {
              Future<dynamic>.delayed(const Duration(milliseconds: 200)).then(
                (dynamic value) => showFlanImagePreview(
                  context,
                  images: images,
                  onChange: (int value) {
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
      await tester.dragFrom(
          const Offset(50.0, 100.0), const Offset(-800.0, 0.0));
      await tester.pumpAndSettle(const Duration(seconds: 1));
      expect(a, equals(1));
    },
  );

  testWidgets(
    'double click',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (BuildContext context) {
              Future<dynamic>.delayed(const Duration(milliseconds: 200)).then(
                (dynamic value) => showFlanImagePreview(
                  context,
                  images: images,
                ),
              );
              return const SizedBox.shrink();
            },
          ),
        ),
      );

      await tester.pumpAndSettle(const Duration(seconds: 1));
      final Finder image = find.byType(Image);
      print(image);
      await tester.tap(image);
      await tester.pump(kDoubleTapMinTime); // <- Add this
      await tester.tap(image);
      await tester.pumpAndSettle(const Duration(seconds: 2));
      final InteractiveViewer view =
          tester.firstWidget<InteractiveViewer>(find.byType(InteractiveViewer));

      expect(
        view.transformationController?.value,
        equals(Matrix4.identity()
          ..scale(2.0, 2.0, 1.0)
          ..translate(-800.0 / 4.0, -600 / 4.0)),
      );
    },
  );

  testWidgets(
    'onClose ',
    (WidgetTester tester) async {
      Map<String, dynamic>? returnBody;
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (BuildContext context) {
              Future<dynamic>.delayed(const Duration(milliseconds: 200)).then(
                (dynamic value) async {
                  returnBody = await showFlanImagePreview(
                    context,
                    images: images,
                  );
                },
              );
              return const SizedBox.shrink();
            },
          ),
        ),
      );
      final Finder image = find.byType(Image);
      await tester.pumpAndSettle(const Duration(seconds: 1));
      await tester.tap(image);
      await tester.pumpAndSettle(const Duration(seconds: 1));

      expect(
        returnBody,
        equals(<String, dynamic>{
          'index': 0,
          'url': images[0],
        }),
      );
    },
  );

  testWidgets(
    'onScale option ',
    (WidgetTester tester) async {
      double a = 0.0;
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (BuildContext context) {
              Future<dynamic>.delayed(const Duration(milliseconds: 200)).then(
                (dynamic value) async {
                  return showFlanImagePreview(
                    context,
                    images: images,
                    onScale: (int current, double scale) {
                      a++;
                    },
                  );
                },
              );
              return const SizedBox.shrink();
            },
          ),
        ),
      );
      final Finder image = find.byType(Image);
      await tester.pumpAndSettle(const Duration(seconds: 1));
      final TestGesture pointer1 =
          await tester.startGesture(tester.getCenter(image));

      final TestGesture pointer2 =
          await tester.startGesture(tester.getCenter(image));

      await pointer1.moveTo(tester.getCenter(image) - const Offset(10, 120));
      await pointer2.moveTo(tester.getCenter(image) + const Offset(10, 120));
      await tester.pumpAndSettle(const Duration(seconds: 1));
      expect(a, isNot(equals(0.0)));
    },
  );
}
