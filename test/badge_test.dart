import 'package:flant/flant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('should render nothing when content is empty string',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Material(
          child: FlanBadge(
            content: '',
          ),
        ),
      ),
    );
    expect(find.byType(Container), findsNothing);
  });

  testWidgets('should render nothing when content is undefined',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Material(
          child: FlanBadge(),
        ),
      ),
    );
    expect(find.byType(Container), findsNothing);
  });

  testWidgets('should render nothing when content is zero',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Material(
          child: FlanBadge(
            content: '0',
          ),
        ),
      ),
    );
    expect(find.text('0'), findsOneWidget);
  });

  testWidgets('should render content slot correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Material(
          child: FlanBadge(
            contentSlot: Text('Custom Content'),
          ),
        ),
      ),
    );
    expect(find.text('Custom Content'), findsOneWidget);
  });

  testWidgets('should change dot position when using offset prop',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Material(
          child: FlanBadge(
            dot: true,
            offset: <double>[2.0, 4.0],
            child: Text('Child'),
          ),
        ),
      ),
    );
    final Positioned dot = tester.firstWidget(find.byType(Positioned));
    expect(dot.top, 2.0);
    expect(dot.right, -4.0);
  });

  testWidgets(
      'should change dot position when using offset prop with custom unit',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Material(
          child: FlanBadge(
            dot: true,
            offset: <double>[2.0 * 2, 4.0 * 2],
            child: Text('Child'),
          ),
        ),
      ),
    );
    final Positioned dot = tester.firstWidget(find.byType(Positioned));
    expect(dot.top, equals(2.0 * 2));
    expect(dot.right, equals(-4.0 * 2));
  });

  testWidgets(
      'should change dot position when using offset prop without children',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Material(
          child: FlanBadge(
            dot: true,
            offset: <double>[2.0, 4.0],
          ),
        ),
      ),
    );
    final Transform dot =
        tester.widgetList<Transform>(find.byType(Transform)).toList().last;

    expect(dot.transform, equals(Matrix4.translationValues(2.0, 4.0, 0.0)));
  });

  testWidgets('should not render zero when show-zero is false',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Material(
          child: FlanBadge(
            content: '0',
          ),
        ),
      ),
    );

    expect(find.text('0'), findsOneWidget);

    await tester.pumpWidget(
      const MaterialApp(
        home: Material(
          child: FlanBadge(
            content: '0',
            showZero: false,
          ),
        ),
      ),
    );
    expect(find.text('0'), findsNothing);
  });
}
