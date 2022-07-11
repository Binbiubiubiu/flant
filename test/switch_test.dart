import 'package:flant/flant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
      'should emit update:modelValue event when click the switch button',
      (WidgetTester tester) async {
    int a = 0;
    void _onUpdateModelValue() {
      a++;
    }

    final ValueNotifier<bool> modelValue = ValueNotifier<bool>(false)
      ..addListener(_onUpdateModelValue);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: FlanSwitch<dynamic>(
            modalValue: modelValue,
          ),
        ),
      ),
    );
    final Finder switchFinder = find.byType(FlanSwitch);
    await tester.tap(switchFinder);
    expect(a, equals(1));
    expect(modelValue.value, isTrue);

    await tester.tap(switchFinder);
    expect(a, equals(2));
    expect(modelValue.value, isFalse);
    modelValue.removeListener(_onUpdateModelValue);
  });

  testWidgets('should emit change event when click the switch button',
      (WidgetTester tester) async {
    int a = 0;
    final ValueNotifier<bool> modelValue = ValueNotifier<bool>(false);
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: FlanSwitch<dynamic>(
            modalValue: modelValue,
            onChange: (dynamic value) {
              a++;
            },
          ),
        ),
      ),
    );
    final Finder switchFinder = find.byType(FlanSwitch);
    await tester.tap(switchFinder);
    expect(a, equals(1));
    expect(modelValue.value, isTrue);

    await tester.tap(switchFinder);
    expect(a, equals(2));
    expect(modelValue.value, isFalse);
  });

  testWidgets(
      'should not emit change event or update:modelValue event if disabled',
      (WidgetTester tester) async {
    int a = 0;
    void _onUpdateModelValue() {
      a++;
    }

    final ValueNotifier<bool> modelValue = ValueNotifier<bool>(false)
      ..addListener(_onUpdateModelValue);
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: FlanSwitch<dynamic>(
            modalValue: modelValue,
            disabled: true,
            onChange: (dynamic value) {
              _onUpdateModelValue();
            },
          ),
        ),
      ),
    );
    final Finder switchFinder = find.byType(FlanSwitch);
    await tester.tap(switchFinder);
    expect(a, equals(0));

    modelValue.removeListener(_onUpdateModelValue);
  });

  testWidgets('should change active color when using active-color prop',
      (WidgetTester tester) async {
    final ValueNotifier<bool> modelValue = ValueNotifier<bool>(true);
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: FlanSwitch<dynamic>(
            modalValue: modelValue,
            activeColor: Colors.black,
          ),
        ),
      ),
    );
    final Finder wrapper = find.byType(AnimatedContainer);
    final BoxDecoration style = tester
        .firstWidget<AnimatedContainer>(wrapper)
        .decoration as BoxDecoration;
    expect(style.color, equals(Colors.black));
  });

  testWidgets('should change inactive color when using inactive-color prop',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: FlanSwitch<dynamic>(
            inActiveColor: Colors.black,
          ),
        ),
      ),
    );
    final Finder wrapper = find.byType(AnimatedContainer);
    final BoxDecoration style = tester
        .firstWidget<AnimatedContainer>(wrapper)
        .decoration as BoxDecoration;
    expect(style.color, equals(Colors.black));
  });

  testWidgets('should apply active color to loading icon',
      (WidgetTester tester) async {
    final ValueNotifier<bool> modelValue = ValueNotifier<bool>(true);
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: FlanSwitch<dynamic>(
            modalValue: modelValue,
            loading: true,
            activeColor: Colors.red,
          ),
        ),
      ),
    );
    final Finder wrapper = find.byType(FlanLoading);
    expect(wrapper, findsOneWidget);
    expect(tester.firstWidget<FlanLoading>(wrapper).color, equals(Colors.red));
  });

  testWidgets('should apply inactive color to loading icon',
      (WidgetTester tester) async {
    final ValueNotifier<bool> modelValue = ValueNotifier<bool>(false);
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: FlanSwitch<dynamic>(
            modalValue: modelValue,
            loading: true,
            inActiveColor: Colors.black,
          ),
        ),
      ),
    );
    final Finder wrapper = find.byType(FlanLoading);
    expect(wrapper, findsOneWidget);
    expect(
        tester.firstWidget<FlanLoading>(wrapper).color, equals(Colors.black));
  });

  testWidgets('should change size when using size prop',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: FlanSwitch<dynamic>(
            size: 20,
          ),
        ),
      ),
    );
    final Finder button = find.byType(Container).at(1);
    print(button);

    expect(tester.getSize(button), equals(const Size(20.0, 20.0)));
  });

  testWidgets('should allow to custom active-value and inactive-value',
      (WidgetTester tester) async {
    final ValueNotifier<String> modelValue = ValueNotifier<String>('on');
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: FlanSwitch<dynamic>(
            modalValue: modelValue,
            activeValue: 'on',
            inActiveValue: 'off',
          ),
        ),
      ),
    );
    final Finder switchFinder = find.byType(FlanSwitch);
    await tester.tap(switchFinder);
    expect(modelValue.value, equals('off'));
    await tester.tap(switchFinder);
    expect(modelValue.value, equals('on'));
  });
}
