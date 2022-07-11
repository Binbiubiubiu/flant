import 'package:flant/flant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('should render default slot correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Material(
          child: FlanActionBar(
            children: <Widget>[
              FlanActionBarButton(
                child: Text('Content'),
              )
            ],
          ),
        ),
      ),
    );
    expect(find.text('Content'), findsOneWidget);
  });
}
