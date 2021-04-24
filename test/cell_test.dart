// 🐦 Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// 📦 Package imports:
import 'package:flutter_test/flutter_test.dart';

// 🌎 Project imports:
import 'package:flant/flant.dart';

void main() {
  testWidgets('should render default slot correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Material(
          child: FlanCell(
            child: Text('Custom Default'),
          ),
        ),
      ),
    );
    expect(find.byType(FlanCell), findsOneWidget);
    expect(find.text('Custom Default'), findsOneWidget);
  });

  testWidgets('should render title slot correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Material(
          child: FlanCell(
            titleSlot: Text('Custom Title'),
          ),
        ),
      ),
    );
    expect(find.byType(FlanCell), findsOneWidget);
    expect(find.text('Custom Title'), findsOneWidget);
  });

  testWidgets('should render label slot correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Material(
          child: FlanCell(
            titleSlot: Text('Custom Title'),
            labelSlot: Text('Custom label'),
          ),
        ),
      ),
    );
    expect(find.byType(FlanCell), findsOneWidget);
    expect(find.text('Custom label'), findsOneWidget);
  });

  testWidgets('should render icon slot correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Material(
          child: FlanCell(
            iconSlot: Text('Custom Icon'),
          ),
        ),
      ),
    );
    expect(find.byType(FlanCell), findsOneWidget);
    expect(find.text('Custom Icon'), findsOneWidget);
  });

  testWidgets('should render extra slot correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Material(
          child: FlanCell(
            extraSlots: Text('Custom Extra'),
          ),
        ),
      ),
    );
    expect(find.byType(FlanCell), findsOneWidget);
    expect(find.text('Custom Extra'), findsOneWidget);
  });

  testWidgets('should change arrow direction when using arrow-direction prop',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Material(
          child: FlanCell(
            isLink: true,
            arrowDirection: FlanCellArrowDirection.down,
          ),
        ),
      ),
    );
    expect(find.byType(FlanCell), findsOneWidget);
    expect(find.byIcon(FlanIcons.arrow_down), findsOneWidget);
  });

  testWidgets('should change title style when using title-style prop',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Material(
          child: FlanCell(
            title: 'title',
            titleStyle: TextStyle(
              color: Colors.red,
            ),
          ),
        ),
      ),
    );
    final Finder text = find.text('title');
    expect(text, findsOneWidget);
    expect(tester.renderObject<RenderParagraph>(text).text.style?.color,
        Colors.red);
  });

  testWidgets('should change icon class prefix when using icon-prefix prop',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Material(
          child: FlanCell(
            iconName: FlanIcons.success,
          ),
        ),
      ),
    );

    expect(find.byIcon(FlanIcons.success), findsOneWidget);
  });

  testWidgets('should allow to disable clicakble when using is-link prop',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Material(
          child: FlanCell(
            isLink: true,
            clickable: false,
          ),
        ),
      ),
    );
    expect(find.byIcon(FlanIcons.arrow), findsOneWidget);
    expect(find.byType(GestureDetector), findsOneWidget);
  });
}
