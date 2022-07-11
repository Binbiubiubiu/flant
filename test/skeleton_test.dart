import 'package:flant/flant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('should render with row width array correctly',
      (WidgetTester tester) async {
    final GlobalKey globalKey = GlobalKey();
    await tester.pumpWidget(
      MaterialApp(
        key: globalKey,
        home: const Scaffold(
          body: FlanSkeleton(
            row: 4,
            rowWidths: <double>[1.0, 30.0],
          ),
        ),
      ),
    );
    final Finder item = find.byType(Container);
    expect(tester.getSize(item.at(0)).width, equals(768.0));
    expect(tester.getSize(item.at(1)).width, equals(30.0));
  });

  testWidgets('should render default slot when loading is false',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: FlanSkeleton(
            child: Text('Content'),
            loading: false,
          ),
        ),
      ),
    );
    expect(find.text('Content'), findsOneWidget);
  });

  testWidgets('should change avatar size when using avatar-size prop',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: FlanSkeleton(
            avatar: true,
            avatarSize: 40.0,
          ),
        ),
      ),
    );
    expect(tester.getSize(find.byType(Container)), const Size(40.0, 40.0));
  });

  testWidgets('should change avatar shape when using avatar-shape prop',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: FlanSkeleton(
            avatar: true,
            avatarShape: FlanSkeletonAvatarShape.square,
          ),
        ),
      ),
    );
    final BoxDecoration decoration = tester
        .firstWidget<Container>(find.byType(Container))
        .decoration as BoxDecoration;
    expect(decoration.shape, equals(BoxShape.rectangle));
  });

  testWidgets('should be round when using round prop',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: FlanSkeleton(
            title: true,
            round: true,
            avatar: true,
          ),
        ),
      ),
    );
    final BoxDecoration decoration = tester
        .firstWidget<Container>(find.byType(Container))
        .decoration as BoxDecoration;
    expect(decoration.shape, equals(BoxShape.circle));
  });

  testWidgets('should allow to disable animation', (WidgetTester tester) async {
    await tester.pumpWidget(
      WidgetsApp(
        color: Colors.white,
        builder: (BuildContext context, Widget? child) {
          return const Material(
            child: FlanSkeleton(
              row: 1,
            ),
          );
        },
      ),
    );
    expect(find.byType(AnimatedBuilder), findsOneWidget);
    await tester.pumpWidget(
      WidgetsApp(
        color: Colors.white,
        builder: (BuildContext context, Widget? child) {
          return const Material(
            child: FlanSkeleton(
              row: 1,
              animate: false,
            ),
          );
        },
      ),
    );
    expect(find.byType(AnimatedBuilder), findsNothing);
  });
}
