import 'dart:io';

import 'package:flant/flant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUp(() {
    HttpOverrides.global = null;
  });
  testWidgets('should render image slot correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Material(
          child: FlanEmpty(
            imageSlot: Text('Custom Image'),
          ),
        ),
      ),
    );
    expect(find.byType(FlanEmpty), findsOneWidget);
    expect(find.text('Custom Image'), findsOneWidget);
  });

  testWidgets('should render description slot correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Material(
          child: FlanEmpty(
            descriptionSlot: Text('Custom description'),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle(const Duration(seconds: 1));
    expect(find.byType(FlanEmpty), findsOneWidget);
    expect(find.text('Custom description'), findsOneWidget);
  });

  testWidgets('should render bottom slot correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Material(
          child: FlanEmpty(
            child: Text('Custom bottom'),
          ),
        ),
      ),
    );
    expect(find.byType(FlanEmpty), findsOneWidget);
    expect(find.text('Custom bottom'), findsOneWidget);
  });

  testWidgets('should render svg when image is network',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Material(
          child: FlanEmpty(
            imageType: FlanEmptyImageType.network,
          ),
        ),
      ),
    );
    expect(find.byType(FlanEmpty), findsOneWidget);
    expect(find.byType(SvgPicture), findsOneWidget);
  });

  testWidgets('should change image size when using image-size prop',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Material(
          child: FlanEmpty(
            imageSize: 50.0,
          ),
        ),
      ),
    );
    expect(find.byType(FlanEmpty), findsOneWidget);
    expect(tester.getSize(find.byType(Image)), equals(const Size(50.0, 50.0)));
  });
}
