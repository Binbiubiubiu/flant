// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_test/flutter_test.dart';

// 🌎 Project imports:
import 'package:flant/flant.dart';

void main() {
  testWidgets('should render prev-text、next-text slot correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: FlanPagination(
            value: 1,
            onChange: (int value) {},
            totalItems: 50,
            showPageSize: 5,
            prevTextSlot: const Text('Custom PrevText'),
            nextTextSlot: const Text('Custom NextText'),
          ),
        ),
      ),
    );
    expect(find.text('Custom PrevText'), findsOneWidget);
    expect(find.text('Custom NextText'), findsOneWidget);
  });

  testWidgets('should render page slot correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: FlanPagination(
            value: 1,
            onChange: (int value) {},
            totalItems: 50,
            showPageSize: 5,
            pageBuilder: (PageItem pageItem) => Text('foo ${pageItem.text}'),
          ),
        ),
      ),
    );
    expect(find.textContaining('foo'), findsWidgets);
  });
}
