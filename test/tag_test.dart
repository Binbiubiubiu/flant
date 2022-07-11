import 'package:flant/flant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('should emit close event when clicking the close icon',
      (WidgetTester tester) async {
    int a = 1;
    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: FlanTag(
            closeable: true,
            onClose: () {
              a += 1;
            },
          ),
        ),
      ),
    );
    final Finder closeBtn = find.byIcon(FlanIcons.cross);
    expect(closeBtn, findsOneWidget);
    await tester.tap(closeBtn);
    expect(a, equals(2));
  });

  testWidgets('should hide tag when the show prop is false',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Material(
          child: FlanTag(
            show: false,
          ),
        ),
      ),
    );
    final AnimatedOpacity animatedOpacity =
        tester.widget<AnimatedOpacity>(find.byType(AnimatedOpacity));
    expect(animatedOpacity.opacity, 0.0);
  });

  testWidgets('should not trigger click event when not clicking the close icon',
      (WidgetTester tester) async {
    int a = 1;
    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: FlanTag(
            closeable: true,
            child: const Text('Custom text'),
            onClose: () {
              a += 1;
            },
          ),
        ),
      ),
    );
    await tester.tap(find.byType(FlanTag));
    expect(a, equals(1));

    await tester.tap(find.byIcon(FlanIcons.cross));
    expect(a, equals(2));
  });

  testWidgets('should render border-color correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Material(
          child: FlanTag(
            plain: true,
            color: Colors.red,
            textColor: Colors.blue,
            child: Text('Custom text'),
          ),
        ),
      ),
    );
    final TextStyle? textStyle = tester
        .renderObject<RenderParagraph>(find.text('Custom text'))
        .text
        .style;
    expect(textStyle?.color, equals(Colors.blue));
    final BoxDecoration decoration = tester
        .firstWidget<Container>(find.byType(Container))
        .decoration as BoxDecoration;
    expect(decoration.color, equals(Colors.white));
  });
}
