// 🐦 Flutter imports:
import 'package:flutter/material.dart';

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
          child: FlanActionBarIcon(
            child: Text('Content'),
          ),
        ),
      ),
    );
    expect(find.text('Content'), findsOneWidget);
  });

  testWidgets('should render icon slot correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Material(
          child: FlanActionBarIcon(
            child: Text('Content'),
            iconSlot: Text('Custom Icon'),
          ),
        ),
      ),
    );
    expect(find.text('Custom Icon'), findsOneWidget);
  });

  testWidgets('should render icon slot with badge correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Material(
          child: FlanActionBarIcon(
            badge: '1',
            child: Text('Content'),
            iconSlot: Text('Custom Icon'),
          ),
        ),
      ),
    );
    expect(find.text('1'), findsOneWidget);
  });

  testWidgets('should render icon slot with badge correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Material(
          child: FlanActionBarIcon(
            dot: true,
            child: Text('Content'),
            iconSlot: Text('Custom Icon'),
          ),
        ),
      ),
    );
    expect(tester.firstWidget<FlanBadge>(find.byType(FlanBadge)).dot, isTrue);
  });
}
