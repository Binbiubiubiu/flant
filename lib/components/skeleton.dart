import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../styles/components/skeleton_theme.dart';
import '../styles/var.dart';
import '../utils/widget.dart';

const double DEFAULT_ROW_WIDTH = 1.0; // percent
const double DEFAULT_LAST_ROW_WIDTH = 0.6; // percent

/// ### Skeleton 骨架屏
class FlanSkeleton extends StatelessWidget {
  const FlanSkeleton({
    Key? key,
    this.row = 0,
    this.rowWidth = DEFAULT_ROW_WIDTH,
    this.title = false,
    this.avatar = false,
    this.loading = true,
    this.animate = true,
    this.round = false,
    this.titleWidth = 0.4,
    this.avatarSize,
    this.avatarShape = FlanSkeletonAvatarShape.round,
    this.rowWidths,
    this.child,
  }) : super(key: key);
  // ****************** Props ******************
  /// 段落占位图行数
  final int row;

  /// 段落占位图宽度，可传数组来设置每一行的宽度
  /// - `0.1` == `10%`
  /// - `20.0` == `20.0`
  final double rowWidth;

  /// 段落占位图宽度，可传数组来设置每一行的宽度
  /// - `0.1` == `10%`
  /// - `20.0` == `20.0`
  final List<double>? rowWidths;

  /// 是否显示标题占位图
  final bool title;

  /// 是否显示头像占位图
  final bool avatar;

  /// 是否显示骨架屏，传 `false` 时会展示子组件内容
  final bool loading;

  /// 是否开启动画
  final bool animate;

  /// 是否将标题和段落显示为圆角风格
  final bool round;

  /// 标题占位图宽度
  final double titleWidth;

  /// 头像占位图大小
  final double? avatarSize;

  /// 头像占位图形状，可选值为`square`
  final FlanSkeletonAvatarShape avatarShape;

  // ****************** Events ******************

  // ****************** Slots ******************

  /// 默认插槽
  final Widget? child;

  /// 块状圆角
  BorderRadius get borderRadius {
    return round
        ? BorderRadius.circular(ThemeVars.borderRadiusMax)
        : BorderRadius.zero;
  }

  @override
  Widget build(BuildContext context) {
    if (!loading) {
      return child ?? const SizedBox.shrink();
    }
    final FlanSkeletonThemeData themeData = FlanSkeletonTheme.of(context);
    final Padding skeleton = Padding(
      padding: EdgeInsets.symmetric(horizontal: FlanThemeVars.paddingMd.rpx),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildAvatar(themeData),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: ThemeVars.paddingXs.rpx),
                _buildTitle(themeData),
                ..._buildRows(themeData),
              ],
            ),
          ),
        ],
      ),
    );

    if (animate) {
      return _AnimatedOpacityBlock(
        duration: themeData.animationDuration,
        child: skeleton,
      );
    }

    return skeleton;
  }

  Widget _buildAvatar(FlanSkeletonThemeData themeData) {
    if (avatar) {
      final double size = avatarSize ?? themeData.avatarSize;
      return Padding(
        padding: EdgeInsets.only(right: ThemeVars.paddingMd.rpx),
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: themeData.avatarBackgroundColor,
            shape: _avatarShape,
          ),
        ),
      );
    }
    return const SizedBox.shrink();
  }

  BoxShape get _avatarShape {
    switch (avatarShape) {
      case FlanSkeletonAvatarShape.square:
        return BoxShape.rectangle;
      case FlanSkeletonAvatarShape.round:
        return BoxShape.circle;
    }
  }

  Widget _buildTitle(FlanSkeletonThemeData themeData) {
    if (title) {
      final double tWidth = titleWidth > 1 ? titleWidth : themeData.titleWidth;
      Widget title = Container(
        width: tWidth,
        height: themeData.rowHeight,
        decoration: BoxDecoration(
          color: themeData.rowBackgroundColor,
          borderRadius: borderRadius,
        ),
      );

      if (titleWidth <= 1) {
        title = FractionallySizedBox(
          widthFactor: titleWidth,
          child: title,
        );
      }
      return title;
    }
    return const SizedBox.shrink();
  }

  double getRowWidth(int index) {
    if (rowWidth == DEFAULT_ROW_WIDTH && index == row - 1) {
      return DEFAULT_LAST_ROW_WIDTH;
    }

    if (rowWidths != null) {
      return index < rowWidths!.length ? rowWidths![index] : rowWidth;
    }

    return rowWidth;
  }

  List<Widget> _buildRows(FlanSkeletonThemeData themeData) {
    final List<Widget> rows = <Widget>[];
    for (int i = 0; i < row; i++) {
      final double rWidth = getRowWidth(i);
      Widget row = Container(
        width: rWidth,
        height: themeData.rowHeight,
        decoration: BoxDecoration(
          color: themeData.rowBackgroundColor,
          borderRadius: borderRadius,
        ),
      );
      if (rWidth <= 1) {
        row = FractionallySizedBox(
          widthFactor: rWidth,
          child: row,
        );
      }
      rows
        ..add(SizedBox(height: themeData.rowMarginTop))
        ..add(row);
    }

    return rows;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties.add(DiagnosticsProperty<int>('row', row, defaultValue: 0));
    properties.add(
        DiagnosticsProperty<double>('rowWidth', rowWidth, defaultValue: 1.0));
    properties
        .add(DiagnosticsProperty<bool>('title', title, defaultValue: false));
    properties
        .add(DiagnosticsProperty<bool>('avatar', avatar, defaultValue: false));
    properties
        .add(DiagnosticsProperty<bool>('loading', loading, defaultValue: true));
    properties
        .add(DiagnosticsProperty<bool>('animate', animate, defaultValue: true));
    properties
        .add(DiagnosticsProperty<bool>('round', round, defaultValue: true));
    properties.add(DiagnosticsProperty<double>('titleWidth', titleWidth,
        defaultValue: 0.4));
    properties.add(DiagnosticsProperty<double>('avatarSize', avatarSize,
        defaultValue: 32.0));
    properties.add(DiagnosticsProperty<FlanSkeletonAvatarShape>(
        'avatarShape', avatarShape,
        defaultValue: FlanSkeletonAvatarShape.round));
    super.debugFillProperties(properties);
  }
}

class _AnimatedOpacityBlock extends StatefulWidget {
  const _AnimatedOpacityBlock({
    Key? key,
    required this.duration,
    required this.child,
  }) : super(key: key);

  final Duration duration;

  final Widget child;

  @override
  __AnimatedOpacityBlockState createState() => __AnimatedOpacityBlockState();
}

class __AnimatedOpacityBlockState extends State<_AnimatedOpacityBlock>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    controller = AnimationController(duration: widget.duration, vsync: this);
    animation = TweenSequence<double>(<TweenSequenceItem<double>>[
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: 1.0, end: 0.6),
        weight: 0.5,
      ),
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: 0.6, end: 1.0),
        weight: 0.5,
      ),
    ]).animate(CurvedAnimation(
      parent: controller,
      curve: Curves.easeInOut,
    ));
    controller.repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (BuildContext context, Widget? child) {
        return Opacity(
          opacity: animation.value,
          child: child,
        );
      },
      child: widget.child,
    );
  }
}

/// 头像占位图形状
enum FlanSkeletonAvatarShape {
  square,
  round,
}
