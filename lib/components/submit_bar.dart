// 🐦 Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// 🌎 Project imports:
import '../locale/l10n.dart';
import '../styles/components/submit_bar_theme.dart';
import '../styles/theme.dart';
import '../styles/var.dart';
import '../utils/widget.dart';
import 'button.dart';
import 'icon.dart';

/// ### SubmitBar 提交订单栏
class FlanSubmitBar extends StatelessWidget {
  const FlanSubmitBar({
    Key? key,
    this.price,
    this.decimalLength = 2,
    this.label = '',
    this.suffixLabel,
    this.textAlign = TextAlign.right,
    this.buttonText = '',
    this.buttonType = FlanButtonType.danger,
    this.buttonColor,
    this.tip = '',
    this.tipIconName,
    this.tipIconUrl,
    this.currency = '¥',
    this.disabled = false,
    this.loading = false,
    this.safeAreaInsetBottom = false,
    this.child,
    this.onSubmit,
    this.buttonSlot,
    this.topSlot,
    this.tipSlot,
  })  : assert(decimalLength >= 0),
        super(key: key);

  // ****************** Props ******************

  /// 价格（单位分）
  final int? price;

  /// 价格小数点位数
  final int decimalLength;

  /// 价格左侧文案
  final String label;

  /// 价格右侧文案
  final String? suffixLabel;

  /// 价格文案对齐方向，可选值为 `left` `right`
  final TextAlign textAlign;

  /// 按钮文字
  final String buttonText;

  /// 按钮类型
  final FlanButtonType buttonType;

  /// 自定义按钮颜色
  final Color? buttonColor;

  /// 在订单栏上方的提示文案
  final String tip;

  /// 提示文案左侧的图标名称
  final IconData? tipIconName;

  /// 提示文案左侧的图标链接
  final String? tipIconUrl;

  /// 货币符号
  final String currency;

  /// 是否禁用按钮
  final bool disabled;

  /// 是否显示将按钮显示为加载中状态
  final bool loading;

  /// 是否开启底部安全区适配
  final bool safeAreaInsetBottom;

  // ****************** Events ******************
  /// 按钮点击事件回调
  final VoidCallback? onSubmit;

  // ****************** Slots ******************
  /// 自定义订单栏左侧内容
  final Widget? child;

  /// 自定义按钮
  final Widget? buttonSlot;

  /// 自定义订单栏上方内容
  final Widget? topSlot;

  /// 提示文案中的额外内容
  final InlineSpan? tipSlot;

  @override
  Widget build(BuildContext context) {
    final FlanSubmitBarThemeData themeData =
        FlanTheme.of(context).submitBarTheme;

    return Container(
      color: themeData.backgroundColor,
      child: SafeArea(
        bottom: safeAreaInsetBottom,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget?>[
            topSlot,
            _buildTip(themeData),
            DefaultTextStyle(
              style: TextStyle(
                fontSize: themeData.textFontSize,
              ),
              child: Container(
                height: themeData.height,
                padding: themeData.padding,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget?>[
                    child,
                    _buildText(context, themeData),
                    _buildButton(themeData),
                  ].noNull,
                ),
              ),
            ),
          ].noNull,
        ),
      ),
    );
  }

  Widget? _buildTip(FlanSubmitBarThemeData themeData) {
    if (tipSlot != null || tip.isNotEmpty) {
      return Container(
        width: double.infinity,
        color: themeData.tipBackgroundColor,
        padding: themeData.tipPadding,
        child: DefaultTextStyle(
          style: TextStyle(
            color: themeData.tipColor,
            fontSize: themeData.tipFontSize,
            height: themeData.tipLineHeight,
          ),
          child: Text.rich(
            TextSpan(
              children: <InlineSpan?>[
                if (tipIconName != null || tipIconUrl != null)
                  WidgetSpan(
                    alignment: PlaceholderAlignment.middle,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minWidth: themeData.tipIconSize * 1.5,
                      ),
                      child: FlanIcon(
                        iconName: tipIconName,
                        iconUrl: tipIconUrl,
                        size: themeData.tipIconSize,
                        color: themeData.tipColor,
                      ),
                    ),
                  ),
                TextSpan(text: tip),
                tipSlot,
              ].noNull,
            ),
          ),
        ),
      );
    }
  }

  Widget _buildButton(FlanSubmitBarThemeData themeData) {
    if (buttonSlot != null) {
      return buttonSlot!;
    }

    return SizedBox(
      width: themeData.buttonWidth,
      height: themeData.buttonHeight,
      child: FlanButton(
        round: true,
        type: buttonType,
        child: Text(
          buttonText,
          style: const TextStyle(fontWeight: FlanThemeVars.fontWeightBold),
        ),
        color: buttonColor,
        loading: loading,
        disabled: disabled,
        gradient: buttonType == FlanButtonType.danger
            ? FlanThemeVars.gradientRed
            : null,
        onClick: () {
          if (onSubmit != null) {
            onSubmit!();
          }
        },
      ),
    );
  }

  Widget? _buildText(BuildContext context, FlanSubmitBarThemeData themeData) {
    if (price != null) {
      final List<String> pricePair =
          (price! / 100).toStringAsFixed(decimalLength).split('.');
      final String deciaml = decimalLength > 0 ? '.${pricePair[1]}' : '';

      return Expanded(
        child: Padding(
          padding: EdgeInsets.only(right: FlanThemeVars.paddingSm.rpx),
          child: Text.rich(
            TextSpan(
              text:
                  label.isNotEmpty ? label : FlanS.of(context).SubmitBar_label,
              style: TextStyle(color: themeData.textColor),
              children: <InlineSpan>[
                TextSpan(
                  style: TextStyle(
                    color: themeData.priceColor,
                    fontWeight: FlanThemeVars.fontWeightBold,
                    fontSize: themeData.priceFontSize,
                  ),
                  children: <InlineSpan>[
                    TextSpan(text: currency),
                    TextSpan(
                      text: pricePair[0],
                      style: TextStyle(
                        fontSize: themeData.priceIntegerFontSize,
                        fontFamily: themeData.priceFontFamily,
                      ),
                    ),
                    TextSpan(text: deciaml),
                  ],
                ),
                TextSpan(text: suffixLabel),
              ],
            ),
            textAlign: textAlign,
          ),
        ),
      );
    }
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties.add(DiagnosticsProperty<int>('price', price));
    properties.add(DiagnosticsProperty<int>('decimalLength', decimalLength,
        defaultValue: 2));
    properties.add(DiagnosticsProperty<String>('label', label));
    properties.add(DiagnosticsProperty<String>('suffixLabel', suffixLabel));
    properties.add(DiagnosticsProperty<TextAlign>('textAlign', textAlign,
        defaultValue: TextAlign.right));
    properties.add(DiagnosticsProperty<String>('buttonText', buttonText));
    properties.add(DiagnosticsProperty<FlanButtonType>('buttonType', buttonType,
        defaultValue: FlanButtonType.danger));
    properties.add(DiagnosticsProperty<Color>('buttonColor', buttonColor));
    properties.add(DiagnosticsProperty<String>('tip', tip));
    properties.add(DiagnosticsProperty<IconData>('tipIconName', tipIconName));
    properties.add(DiagnosticsProperty<String>('tipIconUrl', tipIconUrl));
    properties.add(
        DiagnosticsProperty<String>('currency', currency, defaultValue: '¥'));
    properties.add(
        DiagnosticsProperty<bool>('disabled', disabled, defaultValue: false));
    properties.add(
        DiagnosticsProperty<bool>('loading', loading, defaultValue: false));
    properties.add(DiagnosticsProperty<bool>(
        'safeAreaInsetBottom', safeAreaInsetBottom,
        defaultValue: false));

    super.debugFillProperties(properties);
  }
}
