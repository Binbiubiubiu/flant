import 'package:flant/flant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('should emit finish event when finished',
      (WidgetTester tester) async {
    int a = 0;
    final Widget app = MaterialApp(
      localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
        FlanS.delegate,
      ],
      home: Material(
        child: FlanContactCard(
          onClick: () {
            a++;
          },
        ),
      ),
    );
    await tester.pumpWidget(app);
    await tester.pumpAndSettle();
    await tester.tap(find.byType(FlanContactCard));
    expect(a, equals(1));
  });

  testWidgets('should not emit click event when editable is false and clicked',
      (WidgetTester tester) async {
    int a = 0;
    final Widget app = MaterialApp(
      localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
        FlanS.delegate
      ],
      home: Material(
        child: FlanContactCard(
          editable: false,
          onClick: () {
            a++;
          },
        ),
      ),
    );
    await tester.pumpWidget(app);
    await tester.pumpAndSettle();
    await tester.tap(find.byType(FlanContactCard));
    expect(a, equals(0));
  });
}
