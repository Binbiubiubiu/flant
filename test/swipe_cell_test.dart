import 'package:flant/flant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('should allow to drag to show left part',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Material(
          child: FlanSwipeCell(
            leftSlot: Text('Left'),
            child: FlanCell(title: 'Custom Cell'),
            rightSlot: Text('Right'),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    await tester.dragFrom(const Offset(50.0, 10.0), const Offset(200.0, 0.0));
    await tester.pumpAndSettle(const Duration(seconds: 1));

    expect(tester.getTopLeft(find.text('Left')), equals(Offset.zero));
  });

  testWidgets('should call beforeClose before closing',
      (WidgetTester tester) async {
    final GlobalKey<FlanSwipeCellState> vm = GlobalKey<FlanSwipeCellState>();
    FlanSwipeCellPosition? position;
    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: FlanSwipeCell(
            key: vm,
            leftSlot: const Text('Left'),
            child: const FlanCell(title: 'Custom Cell'),
            rightSlot: const Text('Right'),
            beforeClose: (FlanSwipeCellDetail detail) async {
              // print(detail.position);
              position = detail.position;
              return false;
            },
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Custom Cell'));
    expect(position, isNull);

    vm.currentState!.open(FlanSwipeCellPosition.left);
    await tester.pumpAndSettle(const Duration(seconds: 1));

    await tester.tap(find.text('Custom Cell'));
    expect(position, equals(FlanSwipeCellPosition.cell));
    await tester.tap(find.text('Left'));
    expect(position, equals(FlanSwipeCellPosition.left));

    vm.currentState!.open(FlanSwipeCellPosition.right);
    await tester.pumpAndSettle(const Duration(seconds: 1));
    await tester.tap(find.text('Right'));
    expect(position, equals(FlanSwipeCellPosition.right));
  });

  testWidgets('should close swipe cell after clicked',
      (WidgetTester tester) async {
    final GlobalKey<FlanSwipeCellState> vm = GlobalKey<FlanSwipeCellState>();

    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: FlanSwipeCell(
            key: vm,
            leftSlot: const Text('Left'),
            child: const FlanCell(title: 'Custom Cell'),
            rightSlot: const Text('Right'),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    vm.currentState!.open(FlanSwipeCellPosition.left);
    await tester.pumpAndSettle(const Duration(seconds: 1));

    await tester.tap(find.text('Custom Cell'));
    await tester.pumpAndSettle(const Duration(seconds: 1));

    expect(tester.getTopLeft(find.text('Left')), isNot(equals(Offset.zero)));
  });

  testWidgets('should emit open event with name when using name prop',
      (WidgetTester tester) async {
    final GlobalKey<FlanSwipeCellState> vm = GlobalKey<FlanSwipeCellState>();
    String name = '';
    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: FlanSwipeCell(
            key: vm,
            leftSlot: const Text('Left'),
            child: const FlanCell(title: 'Custom Cell'),
            rightSlot: const Text('Right'),
            name: 'test',
            onOpen: (FlanSwipeCellDetail detail) {
              name = detail.name;
            },
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    vm.currentState!.open(FlanSwipeCellPosition.left);
    await tester.pumpAndSettle(const Duration(seconds: 1));

    expect(name, equals('test'));
  });

  testWidgets('should emit close event with name when using name prop',
      (WidgetTester tester) async {
    final GlobalKey<FlanSwipeCellState> vm = GlobalKey<FlanSwipeCellState>();
    String name = '';
    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: FlanSwipeCell(
            key: vm,
            leftSlot: const Text('Left'),
            child: const FlanCell(title: 'Custom Cell'),
            rightSlot: const Text('Right'),
            name: 'test',
            onClose: (FlanSwipeCellDetail detail) {
              name = detail.name;
            },
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    vm.currentState!.open(FlanSwipeCellPosition.left);
    await tester.pumpAndSettle(const Duration(seconds: 1));

    vm.currentState!.close(FlanSwipeCellPosition.left);
    await tester.pumpAndSettle(const Duration(seconds: 1));

    expect(name, equals('test'));
  });

  testWidgets('should reset transform after short draging',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Material(
          child: FlanSwipeCell(
            leftSlot: Text('Left'),
            child: FlanCell(title: 'Custom Cell'),
            rightSlot: Text('Right'),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    await tester.dragFrom(const Offset(50.0, 10.0), const Offset(5.0, 0.0));
    await tester.pumpAndSettle(const Duration(seconds: 1));

    expect(tester.getTopLeft(find.text('Left')), isNot(equals(Offset.zero)));
  });

  testWidgets('should not allow to drag when using disabled prop',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Material(
          child: FlanSwipeCell(
            leftSlot: Text('Left'),
            child: FlanCell(title: 'Custom Cell'),
            rightSlot: Text('Right'),
            disabled: true,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    await tester.dragFrom(const Offset(50.0, 10.0), const Offset(200.0, 0.0));
    await tester.pumpAndSettle(const Duration(seconds: 1));

    expect(tester.getTopLeft(find.text('Left')), isNot(equals(Offset.zero)));
  });

  testWidgets('should emit open event when opening left side',
      (WidgetTester tester) async {
    FlanSwipeCellPosition? position;
    String? name;
    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: FlanSwipeCell(
            leftSlot: const Text('Left'),
            child: const FlanCell(title: 'Custom Cell'),
            rightSlot: const Text('Right'),
            onOpen: (FlanSwipeCellDetail detail) {
              position = detail.position;
              name = detail.name;
            },
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    await tester.dragFrom(const Offset(50.0, 10.0), const Offset(200.0, 0.0));
    await tester.pumpAndSettle(const Duration(seconds: 1));

    expect(name, equals(''));
    expect(position, equals(FlanSwipeCellPosition.left));
  });

  testWidgets('should emit open event when opening right side',
      (WidgetTester tester) async {
    FlanSwipeCellPosition? position;
    String? name;
    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: FlanSwipeCell(
            leftSlot: const Text('Left'),
            child: const FlanCell(title: 'Custom Cell'),
            rightSlot: const Text('Right'),
            onOpen: (FlanSwipeCellDetail detail) {
              position = detail.position;
              name = detail.name;
            },
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    await tester.dragFrom(const Offset(50.0, 10.0), const Offset(-200.0, 0.0));
    await tester.pumpAndSettle(const Duration(seconds: 1));

    expect(name, equals(''));
    expect(position, equals(FlanSwipeCellPosition.right));
  });

  testWidgets('should emit close event after closed',
      (WidgetTester tester) async {
    final GlobalKey<FlanSwipeCellState> vm = GlobalKey<FlanSwipeCellState>();
    FlanSwipeCellPosition? position;
    String? name;
    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: FlanSwipeCell(
            key: vm,
            leftSlot: const Text('Left'),
            child: const FlanCell(title: 'Custom Cell'),
            rightSlot: const Text('Right'),
            onClose: (FlanSwipeCellDetail detail) {
              position = detail.position;
              name = detail.name;
            },
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    vm.currentState!.open(FlanSwipeCellPosition.left);
    await tester.pumpAndSettle(const Duration(seconds: 1));

    vm.currentState!.close(FlanSwipeCellPosition.left);
    await tester.pumpAndSettle(const Duration(seconds: 1));

    expect(name, equals(''));
    expect(position, equals(FlanSwipeCellPosition.left));
  });

  testWidgets('should not trigger close event again if already closed',
      (WidgetTester tester) async {
    final GlobalKey<FlanSwipeCellState> vm = GlobalKey<FlanSwipeCellState>();
    int a = 0;
    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: FlanSwipeCell(
            key: vm,
            leftSlot: const Text('Left'),
            child: const FlanCell(title: 'Custom Cell'),
            rightSlot: const Text('Right'),
            onClose: (FlanSwipeCellDetail detail) {
              a++;
            },
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    vm.currentState!.open(FlanSwipeCellPosition.left);
    await tester.pumpAndSettle(const Duration(seconds: 1));

    vm.currentState!.close(FlanSwipeCellPosition.left);
    await tester.pumpAndSettle(const Duration(seconds: 1));

    vm.currentState!.close(FlanSwipeCellPosition.left);
    await tester.pumpAndSettle(const Duration(seconds: 1));

    expect(a, equals(1));
  });
}
