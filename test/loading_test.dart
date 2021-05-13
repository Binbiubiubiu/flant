// 🐦 Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// 📦 Package imports:
import 'package:flutter_test/flutter_test.dart';

// 🌎 Project imports:
import 'package:flant/flant.dart';

void main() {
  testWidgets('should change loading size when using size prop',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Material(
        child: FlanLoading(
          size: 20.0,
        ),
      ),
    ));
    final Finder loading = find.byType(SizedBox).at(0);

    expect(tester.getSize(loading), equals(const Size(20.0, 20.0)));
  });

  testWidgets('should change text font-size when using text-size prop',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Material(
        child: FlanLoading(
          textSize: 20.0,
          child: Text('Text'),
        ),
      ),
    ));
    final Finder text = find.text('Text');
    final TextStyle? textStyle =
        tester.firstRenderObject<RenderParagraph>(text).text.style;
    expect(textStyle?.fontSize, equals(20.0));
  });

  testWidgets('should change text color when using text-color prop',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Material(
        child: FlanLoading(
          textColor: Colors.red,
          child: Text('Loading Text'),
        ),
      ),
    ));
    final Finder text = find.text('Loading Text');
    final TextStyle? textStyle =
        tester.firstRenderObject<RenderParagraph>(text).text.style;
    expect(textStyle?.color, equals(Colors.red));
  });

  testWidgets('should change text color when using color prop',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Material(
        child: FlanLoading(
          textColor: Colors.green,
          child: Text('Loading Text'),
        ),
      ),
    ));
    final Finder text = find.text('Loading Text');
    final TextStyle? textStyle =
        tester.firstRenderObject<RenderParagraph>(text).text.style;
    expect(textStyle?.color, equals(Colors.green));
  });

  testWidgets('should change text color when using color prop',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Material(
        child: FlanLoading(
          color: Colors.green,
          textColor: Colors.red,
          child: Text('Loading Text'),
        ),
      ),
    ));
    final Finder text = find.text('Loading Text');
    final TextStyle? textStyle =
        tester.firstRenderObject<RenderParagraph>(text).text.style;
    expect(textStyle?.color, equals(Colors.red));
  });
}
