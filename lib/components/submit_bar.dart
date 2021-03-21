import 'package:flant/components/button.dart';
import 'package:flant/flant.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../styles/var.dart';

class FlanSubmitBar extends StatelessWidget {
  const FlanSubmitBar({
    Key? key,
    this.price,
    this.decimalLength = 2,
    this.label = '合计：',
    this.suffixLabel,
    this.textAlign = TextAlign.right,
    this.buttonText,
    this.buttonType = FlanButtonType.danger,
    this.buttonColor,
    this.tip,
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
  final String? buttonText;

  /// 按钮类型
  final FlanButtonType buttonType;

  /// 自定义按钮颜色
  final Color? buttonColor;

  /// 在订单栏上方的提示文案
  final String? tip;

  /// 提示文案左侧的图标名称
  final int? tipIconName;

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
  final Widget? tipSlot;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ThemeVars.submitBarBackgroundColor,
      child: SafeArea(
        bottom: safeAreaInsetBottom,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            topSlot ?? const SizedBox.shrink(),
            _buildTip(),
            Container(
              height: ThemeVars.submitBarHeight,
              padding: ThemeVars.submitBarPadding,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  child ?? const SizedBox.shrink(),
                  _buildText(context),
                  _buildButton(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTip() {
    if (tipSlot != null || (tip != null && tip!.isNotEmpty)) {
      return Container(
        width: double.infinity,
        color: ThemeVars.submitBarTipBackgroundColor,
        padding: ThemeVars.submitBarTipPadding,
        child: DefaultTextStyle(
          style: const TextStyle(
            color: ThemeVars.submitBarTipColor,
            fontSize: ThemeVars.submitBarTipFontSize,
            // height: ThemeVars.submitBarTipLineHeight,
          ),
          child: Text.rich(
            TextSpan(
              children: <InlineSpan>[
                WidgetSpan(
                  alignment: PlaceholderAlignment.top,
                  child: tipIconName != null || tipIconUrl != null
                      ? ConstrainedBox(
                          constraints: const BoxConstraints(
                            minWidth: ThemeVars.submitBarTipIconSize * 1.5,
                          ),
                          child: FlanIcon(
                            iconName: tipIconName,
                            iconUrl: tipIconUrl,
                            size: ThemeVars.submitBarTipIconSize,
                            color: ThemeVars.submitBarTipColor,
                          ),
                        )
                      : const SizedBox.shrink(),
                ),
                TextSpan(text: tip),
                WidgetSpan(
                  child: tipSlot ?? const SizedBox.shrink(),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return const SizedBox.shrink();
  }

  Widget _buildButton() {
    if (buttonSlot != null) {
      return buttonSlot!;
    }

    return SizedBox(
      width: ThemeVars.submitBarButtonWidth,
      height: ThemeVars.submitBarButtonHeight,
      child: FlanButton(
        round: true,
        type: buttonType,
        child: Text(
          buttonText ?? '',
          style: const TextStyle(fontWeight: ThemeVars.fontWeightBold),
        ),
        color: buttonColor,
        loading: loading,
        disabled: disabled,
        gradient:
            buttonType == FlanButtonType.danger ? ThemeVars.gradientRed : null,
        onClick: () {
          if (onSubmit != null) {
            onSubmit!();
          }
        },
      ),
    );
  }

  Widget _buildText(BuildContext context) {
    if (price != null) {
      final List<String> pricePair =
          (price! / 100).toStringAsFixed(decimalLength).split('.');
      final String deciaml = decimalLength > 0 ? '.${pricePair[1]}' : '';

      return Expanded(
        child: Padding(
          padding: const EdgeInsets.only(right: ThemeVars.paddingSm),
          // alignment: <TextAlign, Alignment>{
          //   TextAlign.left: Alignment.centerLeft,
          //   TextAlign.center: Alignment.center,
          //   TextAlign.right: Alignment.centerRight,
          // }[textAlign],
          child: Text.rich(
            TextSpan(
              text:
                  label.isNotEmpty ? label : FlanS.of(context).SubmitBar_label,
              style: const TextStyle(color: ThemeVars.submitBarTextColor),
              children: <InlineSpan>[
                TextSpan(
                  style: const TextStyle(
                    color: ThemeVars.submitBarPriceColor,
                    fontWeight: ThemeVars.fontWeightBold,
                    fontSize: ThemeVars.fontSizeSm,
                  ),
                  children: <InlineSpan>[
                    TextSpan(text: currency),
                    TextSpan(
                      text: pricePair[0],
                      style: const TextStyle(
                        fontSize: ThemeVars.submitBarPriceIntegerFontSize,
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

    return const SizedBox.shrink();
  }
}
