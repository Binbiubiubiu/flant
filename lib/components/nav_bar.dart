// 🐦 Flutter imports:

// 🐦 Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// 🌎 Project imports:
import '../styles/components/nav_bar_theme.dart';
import '../styles/var.dart';
import '../utils/widget.dart';
import 'common/active_response.dart';
import 'icon.dart';
import 'style.dart';

class FlanNavBar extends StatelessWidget {
  const FlanNavBar({
    Key? key,
    this.title = '',
    this.leftText = '',
    this.rightText = '',
    this.leftArrow = false,
    this.border = true,
    this.safeAreaInsetTop = false,
    this.onClickLeft,
    this.onClickRight,
    this.titleSlot,
    this.leftSlot,
    this.rightSlot,
  }) : super(key: key);

  // ****************** Props ******************

  /// 标题
  final String title;

  /// 左侧文案
  final String leftText;

  /// 右侧文案
  final String rightText;

  /// 是否显示左侧箭头
  final bool leftArrow;

  /// 是否显示下边框
  final bool border;

  /// 是否开启顶部安全区适配
  final bool safeAreaInsetTop;

  // ****************** Events ******************

  /// 点击左侧按钮时触发
  final VoidCallback? onClickLeft;

  /// 点击右侧按钮时触发
  final VoidCallback? onClickRight;

  // ****************** Slots ******************

  /// 自定义标题
  final Widget? titleSlot;

  /// 自定义左侧区域内容
  final Widget? leftSlot;

  /// 自定义右侧区域内容
  final Widget? rightSlot;

  @override
  Widget build(BuildContext context) {
    final FlanNavBarThemeData themeData = FlanNavBarTheme.of(context);

    final List<Widget> content = <Widget>[];
    final bool hasLeft = leftArrow || leftText.isNotEmpty || leftSlot != null;
    final bool hasRight = rightText.isNotEmpty || rightSlot != null;

    if (hasLeft) {
      content.add(
        Positioned(
          left: 0.0,
          child: FlanActiveResponse(
            builder: (BuildContext contenxt, bool active, Widget? child) {
              return Opacity(
                opacity: active ? FlanThemeVars.activeOpacity : 1.0,
                child: child,
              );
            },
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: FlanThemeVars.paddingMd.rpx,
              ),
              child: _buildLeft(themeData),
            ),
            onClick: onClickLeft,
          ),
        ),
      );
    }

    content.add(
      Center(
        child: FractionallySizedBox(
          widthFactor: 0.6,
          child: titleSlot ??
              Text(
                title,
                style: TextStyle(
                  color: themeData.titleTextColor,
                  fontSize: themeData.titleFontSize,
                  fontWeight: FlanThemeVars.fontWeightBold,
                ),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
        ),
      ),
    );

    if (hasRight) {
      content.add(
        Positioned(
          right: 0.0,
          child: FlanActiveResponse(
            builder: (BuildContext contenxt, bool active, Widget? child) {
              return Opacity(
                opacity: active ? FlanThemeVars.activeOpacity : 1.0,
                child: child,
              );
            },
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: FlanThemeVars.paddingMd.rpx,
              ),
              child: _buildRight(themeData),
            ),
            onClick: onClickRight,
          ),
        ),
      );
    }

    return DecoratedBox(
      decoration: BoxDecoration(
        color: themeData.backgroundColor,
      ),
      child: SafeArea(
        top: safeAreaInsetTop,
        child: Container(
          height: themeData.height,
          decoration: const BoxDecoration(
            border: Border(bottom: FlanHairLine()),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: content,
          ),
        ),
      ),
    );
  }

  Widget _buildLeft(FlanNavBarThemeData themeData) {
    if (leftSlot != null) {
      return _NavBarSlot(child: leftSlot!);
    }
    final List<Widget> left = <Widget>[];
    if (leftArrow) {
      left.addAll(<Widget>[
        FlanIcon(
          iconName: FlanIcons.arrow_left,
          size: themeData.arrowSize,
          color: themeData.iconColor,
        ),
        SizedBox(width: FlanThemeVars.paddingBase.rpx)
      ]);
    }

    if (leftText.isNotEmpty) {
      left.add(
        Text(
          leftText,
          style: TextStyle(
            color: themeData.textColor,
          ),
        ),
      );
    }

    return Row(children: left);
  }

  Widget _buildRight(FlanNavBarThemeData themeData) {
    if (rightSlot != null) {
      return _NavBarSlot(child: rightSlot!);
    }

    return Text(
      rightText,
      style: TextStyle(
        color: themeData.textColor,
      ),
    );
  }
}

class _NavBarSlot extends StatelessWidget {
  const _NavBarSlot({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final FlanNavBarThemeData themeData = FlanNavBarTheme.of(context);
    return IconTheme(
      data: IconThemeData(
        color: themeData.iconColor,
      ),
      child: DefaultTextStyle(
        style: TextStyle(
          color: themeData.textColor,
        ),
        child: child,
      ),
    );
  }
}
