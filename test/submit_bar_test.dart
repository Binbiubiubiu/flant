// 🐦 Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// 📦 Package imports:
import 'package:flutter_test/flutter_test.dart';

// 🌎 Project imports:
import 'package:flant/flant.dart';

void main() {
  testWidgets('should emit submit event when submit button is clicked',
      (WidgetTester tester) async {
    int a = 0;
    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: FlanSubmitBar(
            onSubmit: () {
              a++;
            },
          ),
        ),
      ),
    );

    final Finder submitBtn = find.byType(FlanButton);
    expect(submitBtn, findsOneWidget);
    await tester.tap(submitBtn);
    expect(a, equals(1));
  });

  testWidgets('should render disabled submit button correctly',
      (WidgetTester tester) async {
    int a = 0;
    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: FlanSubmitBar(
            disabled: true,
            onSubmit: () {
              a++;
            },
          ),
        ),
      ),
    );
    final Finder submitBtn = find.byType(FlanButton);
    expect(submitBtn, findsOneWidget);
    expect(
      tester.firstWidget<FlanButton>(submitBtn).disabled,
      isTrue,
    );
  });

  testWidgets(
      'should not emit submit event when disabled submit button is clicked',
      (WidgetTester tester) async {
    int a = 0;
    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: FlanSubmitBar(
            disabled: true,
            onSubmit: () {
              a++;
            },
          ),
        ),
      ),
    );
    final Finder submitBtn = find.byType(FlanButton);
    expect(submitBtn, findsOneWidget);
    await tester.tap(submitBtn);
    expect(a, equals(0));
  });

  testWidgets('should not render label without price',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Material(
          child: FlanSubmitBar(
            label: 'Label',
          ),
        ),
      ),
    );
    expect(find.textContaining('Label'), findsNothing);
  });

  testWidgets('should render top slot correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Material(
          child: FlanSubmitBar(
            tipSlot: TextSpan(text: 'Custom Top'),
          ),
        ),
      ),
    );
    expect(find.textContaining('Custom Top'), findsOneWidget);
  });

  testWidgets(
      'should render decimal length correctly when using decimal-length prop',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        localizationsDelegates: <LocalizationsDelegate<dynamic>>[
          FlanS.delegate,
        ],
        home: Material(
          child: FlanSubmitBar(
            price: 111,
            decimalLength: 1,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.textContaining('1.1'), findsOneWidget);

    await tester.pumpWidget(
      const MaterialApp(
        localizationsDelegates: <LocalizationsDelegate<dynamic>>[
          FlanS.delegate,
        ],
        home: Material(
          child: FlanSubmitBar(
            price: 111,
            decimalLength: 0,
          ),
        ),
      ),
    );
    expect(find.textContaining('1.1'), findsNothing);
    expect(find.textContaining('1'), findsOneWidget);
  });

  testWidgets('should render suffix-label correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Material(
          child: FlanSubmitBar(
            price: 111,
            label: 'Label',
            suffixLabel: 'Suffix Label',
          ),
        ),
      ),
    );
    expect(find.textContaining('1.11'), findsOneWidget);
    expect(find.textContaining('Label'), findsOneWidget);
    expect(find.textContaining('Suffix Label'), findsOneWidget);
  });

  testWidgets('should adjust text align when using text-align prop',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        localizationsDelegates: <LocalizationsDelegate<dynamic>>[
          FlanS.delegate,
        ],
        home: Material(
          child: FlanSubmitBar(
            price: 111,
            textAlign: TextAlign.right,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(
      tester
          .firstRenderObject<RenderParagraph>(find.textContaining('1.11'))
          .textAlign,
      equals(TextAlign.right),
    );
  });

  testWidgets('should allow to disable safe-area-inset-bottom prop',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Material(
          child: FlanSubmitBar(
            safeAreaInsetBottom: false,
          ),
        ),
      ),
    );

    expect(
      tester.firstWidget<SafeArea>(find.byType(SafeArea)).bottom,
      isFalse,
    );
  });

  testWidgets(
      'should change the color of submit button when using button-color prop',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Material(
          child: FlanSubmitBar(
            buttonColor: Colors.red,
          ),
        ),
      ),
    );

    expect(
      tester.firstWidget<FlanButton>(find.byType(FlanButton)).color,
      equals(Colors.red),
    );
  });

  testWidgets('should render button slot correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Material(
          child: FlanSubmitBar(
            buttonSlot: Text('Custom button'),
          ),
        ),
      ),
    );

    expect(find.text('Custom button'), findsOneWidget);
  });
}
