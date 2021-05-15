// 🎯 Dart imports:
import 'dart:io';

// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_test/flutter_test.dart';

// 🌎 Project imports:
import 'package:flant/flant.dart';

void main() {
  setUp(() {
    HttpOverrides.global = null;
  });
  testWidgets('should render icon with builtin icon name correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Material(
        child: FlanIcon.name(FlanIcons.success),
      ),
    ));
    expect(find.byIcon(FlanIcons.success), findsOneWidget);
  });

  testWidgets('should render icon with url name correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Material(
        child: FlanIcon.url('https://b.yzcdn.cn/vant/icon-demo-1126.png'),
      ),
    ));

    final Finder icon = find.byType(Image);
    expect(icon, findsOneWidget);
    final NetworkImage image =
        tester.firstWidget<Image>(icon).image as NetworkImage;
    expect(image.url, equals('https://b.yzcdn.cn/vant/icon-demo-1126.png'));
  });

  // testWidgets('should render icon with local image correctly',
  //     (WidgetTester tester) async {
  //   await tester.pumpWidget(const MaterialApp(
  //     home: Material(
  //       child: FlanIcon.url('/assets/icon.jpg'),
  //     ),
  //   ));

  //   final Finder icon = find.byType(ImageIcon);
  //   expect(icon, findsOneWidget);
  //   final AssetImage image = tester.widget<ImageIcon>(icon).image as AssetImage;
  //   expect(image.assetName, equals('/assets/icon.jpg'));
  // });

  testWidgets('should render dot correctly', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Material(
        child: FlanIcon.name(
          FlanIcons.success,
          dot: true,
        ),
      ),
    ));

    expect(find.byType(FlanBadge), findsOneWidget);
  });

  testWidgets('should render badge correctly', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Material(
        child: FlanIcon.name(
          FlanIcons.success,
          badge: '1',
        ),
      ),
    ));

    expect(find.byType(FlanBadge), findsOneWidget);
    expect(find.text('1'), findsOneWidget);
  });

  testWidgets('should change icon size when using size prop',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Material(
        child: FlanIcon.name(
          FlanIcons.success,
          size: 20,
        ),
      ),
    ));

    expect(tester.getSize(find.byType(Icon)), equals(const Size(20.0, 20.0)));
  });
}
