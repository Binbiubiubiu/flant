import 'package:flant/flant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
    'should render AnimatedOverlay  by default',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (BuildContext context) {
              Future<dynamic>.delayed(const Duration(milliseconds: 200)).then(
                (dynamic value) => showFlanPopup(
                  context,
                  builder: (BuildContext context) {
                    return const SizedBox.shrink();
                  },
                ),
              );
              return const SizedBox.shrink();
            },
          ),
        ),
      );
      await tester.pumpAndSettle(const Duration(seconds: 1));
      expect(find.byType(AnimatedModalBarrier), findsOneWidget);
    },
  );

  testWidgets(
    'should not render AnimatedOverlay when overlayColor prop is transparent',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (BuildContext context) {
              Future<dynamic>.delayed(const Duration(milliseconds: 200)).then(
                (dynamic value) => showFlanPopup(
                  context,
                  builder: (BuildContext context) {
                    return const SizedBox.shrink();
                  },
                  overlayColor: Colors.transparent,
                ),
              );
              return const SizedBox.shrink();
            },
          ),
        ),
      );
      await tester.pumpAndSettle(const Duration(seconds: 1));
      expect(find.byType(AnimatedModalBarrier), findsNothing);
    },
  );

  testWidgets(
    'should emit open and opened event when popup show',
    (WidgetTester tester) async {
      int a = 0;
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (BuildContext context) {
              Future<dynamic>.delayed(const Duration(milliseconds: 200)).then(
                (dynamic value) => showFlanPopup(
                  context,
                  builder: (BuildContext context) {
                    return const SizedBox.shrink();
                  },
                  onOpen: () {
                    a++;
                  },
                  onOpened: () {
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
      expect(a, equals(2));
    },
  );

  testWidgets(
    'should emit close and closed event when popup show',
    (WidgetTester tester) async {
      int a = 0;
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (BuildContext context) {
              Future<dynamic>.delayed(const Duration(milliseconds: 200)).then(
                (dynamic value) => showFlanPopup(
                  context,
                  builder: (BuildContext context) {
                    return const SizedBox.shrink();
                  },
                  onOpened: () {
                    Navigator.of(context).maybePop();
                  },
                  onClose: () {
                    a++;
                  },
                  onClosed: () {
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
      expect(a, equals(2));
    },
  );

  testWidgets(
    'should change duration when using duration prop',
    (WidgetTester tester) async {
      int a = 0;
      final Widget widget = MaterialApp(
        home: Builder(
          builder: (BuildContext context) {
            Future<dynamic>.delayed(const Duration(milliseconds: 200)).then(
              (dynamic value) => showFlanPopup(
                context,
                builder: (BuildContext context) {
                  return const Text('test text');
                },
                duration: const Duration(seconds: 1),
                onOpened: () {
                  a++;
                },
              ),
            );
            return const SizedBox.shrink();
          },
        ),
      );
      await tester.pumpFrames(
        widget,
        const Duration(seconds: 1),
      );
      expect(a, equals(0));
      await tester.pumpFrames(
        widget,
        const Duration(seconds: 1),
      );
      expect(a, equals(1));
    },
  );

  testWidgets(
    'should have radius when setting the round prop',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (BuildContext context) {
              Future<dynamic>.delayed(const Duration(milliseconds: 200)).then(
                (dynamic value) => showFlanPopup(
                  context,
                  builder: (BuildContext context) {
                    return const SizedBox.shrink();
                  },
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
    'should render close icon when using closeable prop',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (BuildContext context) {
              Future<dynamic>.delayed(const Duration(milliseconds: 200)).then(
                (dynamic value) => showFlanPopup(
                  context,
                  builder: (BuildContext context) {
                    return const SizedBox.shrink();
                  },
                  closeable: true,
                ),
              );
              return const SizedBox.shrink();
            },
          ),
        ),
      );
      await tester.pumpAndSettle(const Duration(seconds: 1));
      expect(find.byIcon(FlanIcons.cross), findsOneWidget);
    },
  );

  testWidgets(
    'should emit click-close-icon event when close icon is clicked',
    (WidgetTester tester) async {
      int a = 0;
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (BuildContext context) {
              Future<dynamic>.delayed(const Duration(milliseconds: 200)).then(
                (dynamic value) => showFlanPopup(
                  context,
                  builder: (BuildContext context) {
                    return Container(
                      height: 400.0,
                      color: Colors.white,
                    );
                  },
                  closeable: true,
                  onClickCloseIcon: () {
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
      final Finder icon = find.byIcon(FlanIcons.cross);
      await tester.tap(icon);
      expect(a, equals(1));
    },
  );

  testWidgets(
    'should render correct close icon when using close-icon prop',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (BuildContext context) {
              Future<dynamic>.delayed(const Duration(milliseconds: 200)).then(
                (dynamic value) => showFlanPopup(
                  context,
                  builder: (BuildContext context) {
                    return Container(
                      height: 400.0,
                      color: Colors.white,
                    );
                  },
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
}
