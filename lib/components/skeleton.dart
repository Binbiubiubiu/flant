// 🐦 Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// 🌎 Project imports:
import '../styles/var.dart';

const double DEFAULT_ROW_WIDTH = 1.0;
const double DEFAULT_LAST_ROW_WIDTH = 0.6;

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

    final Padding skeleton = Padding(
      padding: const EdgeInsets.symmetric(horizontal: ThemeVars.paddingMd),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildAvatar(context),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: ThemeVars.paddingXs),
                _buildTitle(context),
                ..._buildRows(context),
              ],
            ),
          ),
        ],
      ),
    );

    if (animate) {
      return _AnimatedOpacityBlock(
        child: skeleton,
      );
    }

    return skeleton;
  }

  Widget _buildAvatar(BuildContext context) {
    if (avatar) {
      return Padding(
        padding: const EdgeInsets.only(right: ThemeVars.paddingMd),
        child: CircleAvatar(
          backgroundColor: ThemeVars.skeletonAvatarBackgroundColor,
          radius: (avatarSize ?? ThemeVars.skeletonAvatarSize) / 2,
        ),
      );
    }

    return const SizedBox.shrink();
  }

  Widget _buildTitle(BuildContext context) {
    if (title) {
      final double tWidth =
          titleWidth > 1 ? titleWidth : ThemeVars.skeletonTitleWidth;
      Widget title = Container(
        width: tWidth,
        height: ThemeVars.skeletonRowHeight,
        decoration: BoxDecoration(
          color: ThemeVars.skeletonRowBackgroundColor,
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
      return rowWidths![index];
    }

    return rowWidth;
  }

  List<Widget> _buildRows(BuildContext context) {
    final List<Widget> rows = <Widget>[];
    for (int i = 0; i < row; i++) {
      final double rWidth = getRowWidth(i);
      Widget row = Container(
        width: rWidth,
        height: ThemeVars.skeletonRowHeight,
        decoration: BoxDecoration(
          color: ThemeVars.skeletonRowBackgroundColor,
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
        ..add(const SizedBox(height: ThemeVars.skeletonRowMarginTop))
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
    required this.child,
  }) : super(key: key);

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
    controller = AnimationController(
      duration: ThemeVars.skeletonAnimationDuration,
      vsync: this,
    );
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
    ))
      ..addListener(_handleChange);
    controller.repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    animation.removeListener(_handleChange);
    controller.dispose();
    super.dispose();
  }

  void _handleChange() => setState(() {});

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: animation.value,
      child: widget.child,
    );
  }
}

/// 头像占位图形状
enum FlanSkeletonAvatarShape {
  square,
  round,
}
