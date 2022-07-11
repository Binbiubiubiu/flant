import 'package:flant/flant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('should re-calc width if showing pivot dynamically',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Material(
          child: FlanProgress(
            showPivot: false,
            percentage: 100,
          ),
        ),
      ),
    );
    expect(find.textContaining('100'), findsNothing);

    await tester.pumpWidget(
      const MaterialApp(
        home: Material(
          child: FlanProgress(
            showPivot: true,
            pivotText: 'test',
          ),
        ),
      ),
    );
    expect(find.textContaining('test'), findsOneWidget);
  });

  testWidgets('should change track color when using track-color prop',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Material(
          child: FlanProgress(
            percentage: 0,
            trackColor: Colors.green,
          ),
        ),
      ),
    );
    final BoxDecoration decoration = tester
        .firstWidget<Container>(find.byType(Container))
        .decoration as BoxDecoration;
    expect(decoration.color, equals(Colors.green));
  });
}
