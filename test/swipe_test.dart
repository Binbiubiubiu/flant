import 'package:flant/flant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

FlanSwipeController? controller;

List<Widget> children =
    List<Widget>.generate(4, (int index) => Container(child: Text('$index')));

void main() {
  testWidgets(
      'should swipe to specific swipe after calling the animateToPage method',
      (WidgetTester tester) async {
    controller = FlanSwipeController(loop: true, itemCount: children.length);
    int a = 0;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: FlanSwipe(
            controller: controller,
            height: 100.0,
            itemBuilder: (BuildContext context, int index) {
              return children[index];
            },
            itemCount: children.length,
            onChange: (int value) {
              a++;
            },
          ),
        ),
      ),
    );
    controller?.animateToPage(
      controller!.page!.toInt() + 2,
      duration: const Duration(seconds: 2),
      curve: Curves.linear,
    );
    await tester.pumpAndSettle(const Duration(seconds: 4));
    expect(a, equals(1));
    controller?.dispose();
  });

  testWidgets('should swipe to next swipe after calling nextPage method',
      (WidgetTester tester) async {
    controller = FlanSwipeController(loop: true, itemCount: children.length);
    int a = 0;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: FlanSwipe(
            controller: controller,
            height: 100.0,
            itemBuilder: (BuildContext context, int index) {
              return children[index];
            },
            itemCount: children.length,
            onChange: (int value) {
              a++;
            },
          ),
        ),
      ),
    );
    controller?.nextPage(
      duration: const Duration(seconds: 2),
      curve: Curves.linear,
    );
    await tester.pumpAndSettle(const Duration(seconds: 4));
    expect(a, equals(1));
    controller?.dispose();
  });

  testWidgets('should swipe to next swipe after calling previousPage method',
      (WidgetTester tester) async {
    controller = FlanSwipeController(loop: true, itemCount: children.length);
    int a = 0;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: FlanSwipe(
            controller: controller,
            height: 100.0,
            itemBuilder: (BuildContext context, int index) {
              return children[index];
            },
            itemCount: children.length,
            onChange: (int value) {
              a++;
            },
          ),
        ),
      ),
    );
    controller?.previousPage(
      duration: const Duration(seconds: 2),
      curve: Curves.linear,
    );
    await tester.pumpAndSettle(const Duration(seconds: 4));
    expect(a, equals(1));
    controller?.dispose();
  });

  testWidgets('should render initial swipe correctly',
      (WidgetTester tester) async {
    controller = FlanSwipeController(
      loop: true,
      itemCount: children.length,
      initialPage: 2,
    );
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: FlanSwipe(
            controller: controller,
            height: 100.0,
            itemBuilder: (BuildContext context, int index) {
              return children[index];
            },
            itemCount: children.length,
          ),
        ),
      ),
    );

    expect(find.text('2'), findsOneWidget);
    controller?.dispose();
  });

  testWidgets('should render vertical swipe when using vertical prop',
      (WidgetTester tester) async {
    controller = FlanSwipeController(
      loop: true,
      itemCount: children.length,
    );
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: FlanSwipe(
            controller: controller,
            height: 100.0,
            vertical: true,
            itemBuilder: (BuildContext context, int index) {
              return children[index];
            },
            itemCount: children.length,
          ),
        ),
      ),
    );

    await tester.dragFrom(const Offset(150.0, 0.0), const Offset(0.0, -80.0));
    await tester.pumpAndSettle();
    expect(find.text('1'), findsOneWidget);
    controller?.dispose();
  });

  testWidgets('should not allow to drag swipe when touchable is false',
      (WidgetTester tester) async {
    controller = FlanSwipeController(
      loop: true,
      itemCount: children.length,
    );
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: FlanSwipe(
            controller: controller,
            height: 100.0,
            vertical: true,
            touchable: false,
            itemBuilder: (BuildContext context, int index) {
              return children[index];
            },
            itemCount: children.length,
          ),
        ),
      ),
    );

    await tester.dragFrom(const Offset(150.0, 0.0), const Offset(0.0, -80.0));
    await tester.pumpAndSettle();
    expect(find.text('0'), findsOneWidget);
    controller?.dispose();
  });

  testWidgets('should render swipe looply when using loop prop',
      (WidgetTester tester) async {
    controller = FlanSwipeController(
      loop: true,
      itemCount: children.length,
    );
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: FlanSwipe(
            controller: controller,
            height: 100.0,
            vertical: true,
            itemBuilder: (BuildContext context, int index) {
              return children[index];
            },
            itemCount: children.length,
          ),
        ),
      ),
    );

    Future<void> move() async {
      await tester.dragFrom(const Offset(150.0, 0.0), const Offset(0.0, -80.0));
      await tester.pumpAndSettle();
    }

    await move();
    expect(find.text('1'), findsOneWidget);
    await move();
    expect(find.text('2'), findsOneWidget);
    await move();
    expect(find.text('3'), findsOneWidget);
    await move();
    expect(find.text('0'), findsOneWidget);
    await move();
    expect(find.text('1'), findsOneWidget);
    controller?.dispose();
  });
}
