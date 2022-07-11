import 'package:flant/flant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late TextEditingController controller;

  setUpAll(() {
    controller = TextEditingController();
  });
  tearDownAll(() {
    controller.dispose();
  });

  testWidgets('should emit "update:modelValue" event when after inputing',
      (WidgetTester tester) async {
    int a = 0;
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: FlanField(
          onInput: (String value) {
            a++;
          },
        ),
      ),
    ));
    await tester.enterText(find.byType(TextField), '1');
    expect(a, equals(1));
  });

  testWidgets('should emit click-input event when input is clicked',
      (WidgetTester tester) async {
    int a = 0;
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: FlanField(
          onClickInput: () {
            a++;
          },
        ),
      ),
    ));
    await tester.tap(find.byType(TextField));
    expect(a, equals(1));
  });

  testWidgets('should emit click-input event when input is clicked',
      (WidgetTester tester) async {
    int a = 0;
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: FlanField(
          inputSlot: const Text('Custom Input'),
          onClickInput: () {
            a++;
          },
        ),
      ),
    ));
    final Finder text = find.text('Custom Input');
    expect(text, findsOneWidget);
    await tester.tap(text);
    expect(a, equals(1));
  });

  testWidgets('should emit click-left-icon event when left icon is clicked',
      (WidgetTester tester) async {
    int a = 0;
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: FlanField(
          leftIconName: FlanIcons.contact,
          onClickLeftIcon: () {
            a++;
          },
        ),
      ),
    ));
    final Finder leftIcon = find.byIcon(FlanIcons.contact);
    expect(leftIcon, findsOneWidget);
    await tester.tap(leftIcon);
    expect(a, equals(1));
  });

  testWidgets('should emit click-right-icon event when right icon is clicked',
      (WidgetTester tester) async {
    int a = 0;
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: FlanField(
          rightIconName: FlanIcons.search,
          onClickRightIcon: () {
            a++;
          },
        ),
      ),
    ));
    final Finder rightIcon = find.byIcon(FlanIcons.search);
    expect(rightIcon, findsOneWidget);
    await tester.tap(rightIcon);
    expect(a, equals(1));
  });

  testWidgets('should format input value when type is number',
      (WidgetTester tester) async {
    String a = '';
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: FlanField(
          type: FlanFieldType.number,
          onInput: (String value) {
            a = value;
          },
        ),
      ),
    ));
    final Finder input = find.byType(TextField);
    await tester.enterText(input, '1');
    expect(a, equals('1'));
    await tester.enterText(input, '1.2.');
    expect(a, equals('1.2'));
    await tester.enterText(input, '123abc');
    expect(a, equals('123'));
  });

  testWidgets('should format input value when type is digit',
      (WidgetTester tester) async {
    String a = '';
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: FlanField(
          type: FlanFieldType.digit,
          onInput: (String value) {
            a = value;
          },
        ),
      ),
    ));
    final Finder input = find.byType(TextField);
    await tester.enterText(input, '1');
    expect(a, equals('1'));
    await tester.enterText(input, '1.');
    expect(a, equals('1'));
    await tester.enterText(input, '123abc');
    expect(a, equals('123'));
  });

  testWidgets('should call input.focus when vm.focus is called',
      (WidgetTester tester) async {
    int a = 0;
    final GlobalKey<FlanFieldState> field = GlobalKey<FlanFieldState>();
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: FlanField(
          key: field,
          onFocus: () {
            a++;
          },
        ),
      ),
    ));
    field.currentState?.focus();
    await tester.pumpAndSettle();
    expect(a, equals(1));
  });

  testWidgets('should call input.blur when vm.blur is called',
      (WidgetTester tester) async {
    int a = 0;
    final GlobalKey<FlanFieldState> field = GlobalKey<FlanFieldState>();
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: FlanField(
          key: field,
          onBlur: () {
            a++;
          },
        ),
      ),
    ));
    field.currentState?.focus();
    await tester.pump();
    field.currentState?.blur();
    await tester.pump();
    expect(a, equals(1));
  });

  testWidgets('should limit maxlength of input value when using maxlength prop',
      (WidgetTester tester) async {
    controller.text = '123';
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: FlanField(
          type: FlanFieldType.number,
          maxLength: 3,
          controller: controller,
        ),
      ),
    ));
    await tester.pumpAndSettle();
    final Finder input = find.byType(TextField);
    final TextField textField = tester.firstWidget<TextField>(input);
    expect(textField.controller?.text, equals('123'));
    controller.clear();
    await tester.enterText(input, '1234');
    expect(textField.controller?.text, equals('123'));
  });

  testWidgets('should render clear icon when using clearable prop',
      (WidgetTester tester) async {
    controller.text = 'test';
    int a = 0;
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: FlanField(
          clearable: true,
          controller: controller,
          onClear: () {
            a++;
          },
        ),
      ),
    ));
    await tester.pumpAndSettle();
    final Finder clearIcon = find.byIcon(FlanIcons.clear);
    final Finder input = find.byType(TextField);
    expect(clearIcon, findsNothing);
    await tester.tap(input);
    await tester.pumpAndSettle();
    expect(clearIcon, findsOneWidget);
    await tester.tap(clearIcon);
    await tester.pumpAndSettle();
    expect(controller.text, isEmpty);
    expect(a, equals(1));
  });

  testWidgets(
      'should always render clear icon when clear-trigger prop is always',
      (WidgetTester tester) async {
    controller.text = 'test';

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: FlanField(
          clearable: true,
          clearTrigger: FlanFieldClearTrigger.always,
          controller: controller,
        ),
      ),
    ));
    await tester.pumpAndSettle();
    final Finder clearIcon = find.byIcon(FlanIcons.clear);
    expect(clearIcon, findsOneWidget);
  });

  testWidgets('should render input slot correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: FlanField(
          inputSlot: const Text('Custom Input'),
        ),
      ),
    ));
    final Finder input = find.text('Custom Input');
    expect(input, findsOneWidget);
  });

  testWidgets('should render label slot correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: FlanField(
          labelSlot: const TextSpan(text: 'Custom Input'),
        ),
      ),
    ));
    final Finder input = find.text('Custom Input');
    expect(input, findsOneWidget);
  });

  testWidgets('should render extra slot correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: FlanField(
          extraSlot: const Text('Extra'),
        ),
      ),
    ));
    final Finder input = find.text('Extra');
    expect(input, findsOneWidget);
  });

  testWidgets('should change cell size when using size prop',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: FlanField(
          size: FlanCellSize.large,
        ),
      ),
    ));
    final Finder cell = find.byType(FlanCell);
    expect(tester.firstWidget<FlanCell>(cell).size, equals(FlanCellSize.large));
  });

  testWidgets('should allow to set label width', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: FlanField(
          label: 'Label',
          labelWidth: 100.0,
        ),
      ),
    ));
    final Finder cell = find.byType(FlanCell);
    expect(tester.firstWidget<FlanCell>(cell).titleWidth, equals(100.0));
  });

  testWidgets('should change arrow direction when using arrow-direction prop',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: FlanField(
          isLink: true,
          arrowDirection: FlanCellArrowDirection.up,
        ),
      ),
    ));
    final Finder cell = find.byType(FlanCell);
    final FlanCell cellWidget = tester.firstWidget<FlanCell>(cell);
    expect(cellWidget.isLink, isTrue);
    expect(cellWidget.arrowDirection, equals(FlanCellArrowDirection.up));
  });

  testWidgets('should allow to format value with formatter prop',
      (WidgetTester tester) async {
    controller.text = 'abc123';
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: FlanField(
          controller: controller,
          formatter: (String value) => value.replaceAll(RegExp(r'\d'), ''),
        ),
      ),
    ));
    await tester.pumpAndSettle();
    expect(controller.text, 'abc');
    final Finder input = find.byType(TextField);
    controller.clear();
    await tester.enterText(input, '123efg');
    expect(controller.text, 'efg');
  });

  testWidgets(
      'should trigger format after bluring when format-trigger prop is blur',
      (WidgetTester tester) async {
    controller.text = 'abc123';
    final GlobalKey<FlanFieldState> key = GlobalKey<FlanFieldState>();
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: FlanField(
          key: key,
          controller: controller,
          formatTrigger: FlanFieldFormatTrigger.onBlur,
          formatter: (String value) => value.replaceAll(RegExp(r'\d'), ''),
        ),
      ),
    ));
    await tester.pumpAndSettle();
    expect(controller.text, 'abc');
    final Finder input = find.byType(TextField);
    controller.clear();
    await tester.enterText(input, '123efg');
    expect(controller.text, '123efg');
    key.currentState?.blur();
    await tester.pumpAndSettle();
    expect(controller.text, 'efg');
  });

  testWidgets('should render word limit correctly',
      (WidgetTester tester) async {
    controller.text = 'foo';
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: FlanField(
          controller: controller,
          showWordLimit: true,
          maxLength: 3,
        ),
      ),
    ));
    expect(find.text('3/3'), findsOneWidget);
  });

  testWidgets('should render colon when using colon prop',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: FlanField(
          label: 'foo',
          colon: true,
        ),
      ),
    ));
    expect(find.text('foo:'), findsOneWidget);
  });

  testWidgets('should format value after mounted if initial modelValue is null',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: FlanField(),
      ),
    ));
    final Finder input = find.byType(TextField);
    final String value = tester.firstWidget<TextField>(input).controller!.text;
    expect(value, isEmpty);
  });

  testWidgets('should change clear icon when using clear-icon prop',
      (WidgetTester tester) async {
    controller.text = 'text';
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: FlanField(
          clearable: true,
          clearIconName: FlanIcons.cross,
          clearTrigger: FlanFieldClearTrigger.always,
          controller: controller,
        ),
      ),
    ));
    expect(find.byIcon(FlanIcons.cross), findsOneWidget);
  });

  testWidgets(
      'should render autofocus attribute to input when using autofocus prop',
      (WidgetTester tester) async {
    controller.text = 'text';
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: FlanField(
          autofocus: true,
        ),
      ),
    ));
    final TextField input =
        tester.firstWidget<TextField>(find.byType(TextField));
    expect(input.autofocus, isTrue);
  });
}
