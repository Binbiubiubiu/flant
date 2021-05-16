// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_test/flutter_test.dart';

// 🌎 Project imports:
import 'package:flant/flant.dart';

void main() {
  test('should not throw error if calling clear method before render notify',
      () {
    FlanNotify.clear();
  });

  testWidgets('should render Notify correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (BuildContext context) {
              Future<dynamic>.delayed(const Duration(milliseconds: 200)).then(
                (dynamic value) => FlanNotify(
                  context,
                  message: 'test',
                ),
              );
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );

    await tester.pumpAndSettle(const Duration(seconds: 1));
    expect(find.text('test'), findsOneWidget);
    await tester.pumpAndSettle(const Duration(seconds: 2));
  });

  testWidgets('should add "van-notify--success" class when type is success',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (BuildContext context) {
              Future<dynamic>.delayed(const Duration(milliseconds: 200)).then(
                (dynamic value) => FlanNotify(
                  context,
                  message: 'test',
                  type: FlanNotifyType.success,
                ),
              );
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );

    await tester.pumpAndSettle(const Duration(seconds: 1));
    expect(find.text('test'), findsOneWidget);
    final Finder bg = find.byType(Container);
    final BoxDecoration style =
        tester.firstWidget<Container>(bg).decoration as BoxDecoration;
    expect(style.color, equals(const Color(0xff07c160)));
    await tester.pumpAndSettle(const Duration(seconds: 2));
  });

  test('should change default duration after calling setDefaultOptions method',
      () {
    FlanNotify.setDefaultOptions(
      const FlanNotifyOption(duration: Duration(seconds: 1)),
    );
    expect(
        FlanNotify.currentOptions.duration, equals(const Duration(seconds: 1)));
    FlanNotify.resetDefaultOptions();
    expect(
        FlanNotify.currentOptions.duration, equals(const Duration(seconds: 3)));
  });

  test(
      'should reset to default duration after calling resetDefaultOptions method',
      () {
    FlanNotify.setDefaultOptions(
      const FlanNotifyOption(duration: Duration(seconds: 1)),
    );
    FlanNotify.resetDefaultOptions();
    expect(
        FlanNotify.currentOptions.duration, equals(const Duration(seconds: 3)));
  });

  testWidgets('should call onClose option when closing',
      (WidgetTester tester) async {
    int a = 0;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (BuildContext context) {
              Future<dynamic>.delayed(const Duration(milliseconds: 200)).then(
                (dynamic value) => FlanNotify(
                  context,
                  message: 'test',
                  duration: const Duration(milliseconds: 1),
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

    await tester.pumpAndSettle(const Duration(seconds: 1));
    expect(a, equals(1));
    await tester.pumpAndSettle(const Duration(seconds: 2));
  });

  testWidgets('should call onClose option when closing',
      (WidgetTester tester) async {
    int a = 0;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (BuildContext context) {
              Future<dynamic>.delayed(const Duration(milliseconds: 200)).then(
                (dynamic value) => FlanNotify(
                  context,
                  message: 'test',
                  onClick: () {
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

    await tester.pumpAndSettle(const Duration(seconds: 1));
    final Finder notify = find.text('test');
    await tester.tap(notify);
    expect(a, equals(1));
    await tester.pumpAndSettle(const Duration(seconds: 2));
  });
}
