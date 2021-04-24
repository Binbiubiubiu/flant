// 🐦 Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// 📦 Package imports:
import 'package:flutter_test/flutter_test.dart';

// 🌎 Project imports:
import 'package:flant/flant.dart';

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
    expect(a, 2);
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
    expect(tester.widget<AnimatedOpacity>(find.byType(AnimatedOpacity)).opacity,
        0.0);
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
    expect(a, 1);

    await tester.tap(find.byIcon(FlanIcons.cross));
    expect(a, 2);
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
    expect(
        tester
            .renderObject<RenderParagraph>(find.text('Custom text'))
            .text
            .style
            ?.color,
        Colors.blue);
    expect(
        (tester.firstWidget<Container>(find.byType(Container)).decoration
                as BoxDecoration)
            .color,
        Colors.white);
  });
}
