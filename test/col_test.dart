// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_test/flutter_test.dart';

// 🌎 Project imports:
import 'package:flant/flant.dart';

void main() {
  testWidgets('should render Col correcly', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Material(
          child: FlanCol(
            span: 8,
          ),
        ),
      ),
    );
    expect(find.byType(FlanCol), findsOneWidget);
  });

  testWidgets('should render Col correcly', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Material(
          child: FlanRow(
            gutter: 24.0,
            children: <Widget>[
              FlanCol(
                span: 24,
                child: Text('24'),
              ),
              FlanCol(
                span: 12,
                child: Text('12'),
              ),
              FlanCol(
                span: 12,
                child: Text('12'),
              ),
              FlanCol(
                span: 8,
                child: Text('8'),
              ),
              FlanCol(
                span: 8,
                child: Text('8'),
              ),
              FlanCol(
                span: 8,
                child: Text('8'),
              ),
              FlanCol(
                span: 6,
                child: Text('6'),
              ),
              FlanCol(
                span: 6,
                child: Text('6'),
              ),
              FlanCol(
                span: 6,
                child: Text('6'),
              ),
              FlanCol(
                span: 6,
                child: Text('6'),
              ),
              FlanCol(
                span: 7,
                child: Text('7'),
              ),
              FlanCol(
                span: 6,
                child: Text('6'),
              ),
              FlanCol(
                span: 5,
                child: Text('5'),
              ),
              FlanCol(
                span: 4,
                child: Text('4'),
              ),
              FlanCol(
                span: 3,
                child: Text('3'),
              ),
              FlanCol(
                span: 6,
                child: Text('2'),
              ),
              FlanCol(
                span: 6,
                child: Text('1'),
              ),
            ],
          ),
        ),
      ),
    );
    expect(find.text('24'), findsWidgets);
    expect(find.text('12'), findsWidgets);
    expect(find.text('8'), findsWidgets);
    expect(find.text('7'), findsWidgets);
    expect(find.text('6'), findsWidgets);
    expect(find.text('5'), findsWidgets);
    expect(find.text('4'), findsWidgets);
    expect(find.text('3'), findsWidgets);
    expect(find.text('2'), findsWidgets);
    expect(find.text('1'), findsWidgets);
  });
}
