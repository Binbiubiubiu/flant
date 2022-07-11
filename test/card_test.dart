import 'package:flant/flant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('should emit click event after clicked',
      (WidgetTester tester) async {
    int a = 0;
    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: GestureDetector(
            onTap: () {
              a++;
            },
            child: const FlanCard(),
          ),
        ),
      ),
    );
    final Finder card = find.byType(FlanCard);
    await tester.tap(card);
    expect(a, equals(1));
  });

  testWidgets('should emit click-thumb event after clicking thumb',
      (WidgetTester tester) async {
    int a = 0;
    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: FlanCard(
            thumb: 'https://img.yzcdn.cn/vant/ipad.jpeg',
            onClickThumb: () {
              a++;
            },
          ),
        ),
      ),
    );
    final Finder thumb = find.byType(FlanImage);
    await tester.tap(thumb);
    expect(a, equals(1));
  });

  testWidgets('should render price and num slot correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Material(
          child: FlanCard(
            numSlot: Text('Custom Num'),
            priceSlot: Text('Custom Price'),
          ),
        ),
      ),
    );

    expect(find.text('Custom Num'), findsOneWidget);
    expect(find.text('Custom Price'), findsOneWidget);
  });

  testWidgets('should render origin-price slot correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Material(
          child: FlanCard(
            originPriceSlot: Text('Custom Origin Price'),
          ),
        ),
      ),
    );

    expect(find.text('Custom Origin Price'), findsOneWidget);
  });

  testWidgets('should render bottom slot correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Material(
          child: FlanCard(
            bottomSlot: Text('Custom Bottom'),
          ),
        ),
      ),
    );

    expect(find.text('Custom Bottom'), findsOneWidget);
  });

  testWidgets('should render bottom slot correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Material(
          child: FlanCard(
            tagSlot: Text('Custom Tag'),
            thumbSlot: Text('Custom Thumb'),
          ),
        ),
      ),
    );

    expect(find.text('Custom Tag'), findsOneWidget);
    expect(find.text('Custom Thumb'), findsOneWidget);
  });

  testWidgets('should render title and desc slot correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Material(
          child: FlanCard(
            titleSlot: Text('Custom Title'),
            descSlot: Text('Custom desc'),
          ),
        ),
      ),
    );

    expect(find.text('Custom Title'), findsOneWidget);
    expect(find.text('Custom desc'), findsOneWidget);
  });

  testWidgets('should render price and price-top slot correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Material(
          child: FlanCard(
            priceSlot: Text('Custom Price'),
            priceTopSlot: Text('Custom Price-top'),
          ),
        ),
      ),
    );

    expect(find.text('Custom Price'), findsOneWidget);
    expect(find.text('Custom Price-top'), findsOneWidget);
  });
}
