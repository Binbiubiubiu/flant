import 'package:flant/components/icon.dart';
import 'package:flant/components/style.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../styles/var.dart';

class FlanNavBar extends StatelessWidget implements PreferredSizeWidget {
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
    final List<Widget> content = <Widget>[];
    final bool hasLeft = leftArrow || leftText.isNotEmpty || leftSlot != null;
    final bool hasRight = rightText.isNotEmpty || rightSlot != null;

    if (hasLeft) {
      content.add(
        Positioned(
          left: 0.0,
          child: _OpacityResponse(
            opacity: ThemeVars.activeOpacity,
            onPressed: () {
              if (onClickLeft != null) {
                onClickLeft!();
              }
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: ThemeVars.paddingMd,
              ),
              child: _buildLeft(context),
            ),
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
                style: const TextStyle(
                  color: ThemeVars.navBarTitleTextColor,
                  fontSize: ThemeVars.navBarTitleFontSize,
                  fontWeight: ThemeVars.fontWeightBold,
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
          child: _OpacityResponse(
            opacity: ThemeVars.activeOpacity,
            onPressed: () {
              if (onClickRight != null) {
                onClickRight!();
              }
            },
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: ThemeVars.paddingMd),
              child: _buildRight(context),
            ),
          ),
        ),
      );
    }

    return Material(
      color: ThemeVars.navBarBackgroundColor,
      child: SafeArea(
        top: safeAreaInsetTop,
        child: Container(
          height: ThemeVars.navBarHeight,
          decoration: const BoxDecoration(
            border: Border(bottom: FlanHairLine()),
          ),
          child: Stack(
            alignment: Alignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: content,
          ),
        ),
      ),
    );
  }

  TextStyle get _textStyle {
    return const TextStyle(color: ThemeVars.navBarTextColor);
  }

  Widget _buildLeft(BuildContext context) {
    if (leftSlot != null) {
      return IconTheme(
        data: const IconThemeData(
          color: ThemeVars.navBarIconColor,
        ),
        child: DefaultTextStyle(
          style: _textStyle,
          child: leftSlot!,
        ),
      );
    }
    final List<Widget> left = <Widget>[];
    if (leftArrow) {
      left.add(const Padding(
        padding: EdgeInsets.only(right: ThemeVars.paddingBase),
        child: FlanIcon(
          iconName: FlanIcons.arrow_left,
          size: ThemeVars.navBarArrowSize,
          color: ThemeVars.navBarIconColor,
        ),
      ));
    }

    if (leftText.isNotEmpty) {
      left.add(Text(
        leftText,
        style: _textStyle,
      ));
    }

    return Row(children: left);
  }

  Widget _buildRight(BuildContext context) {
    if (rightSlot != null) {
      return IconTheme(
        data: const IconThemeData(
          color: ThemeVars.navBarIconColor,
        ),
        child: DefaultTextStyle(
          style: _textStyle,
          child: rightSlot!,
        ),
      );
    }

    return Text(
      rightText,
      style: _textStyle,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(ThemeVars.navBarHeight);
}

class _OpacityResponse extends StatefulWidget {
  const _OpacityResponse({
    Key? key,
    required this.onPressed,
    required this.child,
    this.opacity = 0.4,
  }) : super(key: key);

  final double opacity;

  final VoidCallback onPressed;

  final Widget child;

  @override
  __OpacityResponseState createState() => __OpacityResponseState();
}

class __OpacityResponseState extends State<_OpacityResponse> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      onTapDown: (TapDownDetails details) {
        setState(() {
          isPressed = true;
        });
      },
      onTapUp: (TapUpDetails details) {
        setState(() {
          isPressed = false;
        });
      },
      onTapCancel: () {
        setState(() {
          isPressed = false;
        });
      },
      child: Opacity(
        opacity: isPressed ? widget.opacity : 1.0,
        child: widget.child,
      ),
    );
  }
}
