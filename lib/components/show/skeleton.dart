import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../styles/var.dart';

const DEFAULT_ROW_WIDTH = 1.0;
const DEFAULT_LAST_ROW_WIDTH = 0.6;

/// ### Skeleton 骨架屏
class FlanSkeleton extends StatelessWidget {
  const FlanSkeleton({
    Key key,
    this.row = 0,
    this.rowWidth = DEFAULT_ROW_WIDTH,
    this.title = false,
    this.avatar = false,
    this.loading = true,
    this.animate = true,
    this.round = false,
    this.titleWidth = 0.4,
    this.avatarSize = 32.0,
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
  final List<double> rowWidths;

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
  final double avatarSize;

  /// 头像占位图形状，可选值为`square`
  final FlanSkeletonAvatarShape avatarShape;

  // ****************** Events ******************

  // ****************** Slots ******************

  /// 默认插槽
  final Widget child;

  /// 块状圆角
  BorderRadius get borderRadius {
    return this.round
        ? BorderRadius.circular(ThemeVars.borderRadiusMax)
        : BorderRadius.zero;
  }

  @override
  Widget build(BuildContext context) {
    if (!this.loading) {
      return this.child;
    }

    return _AnimatedOpacityBlock(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: ThemeVars.paddingMd),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            this._buildAvatar(context),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: ThemeVars.paddingXs),
                  this._buildTitle(context),
                  ...this._buildRows(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildAvatar(BuildContext context) {
    if (this.avatar) {
      return Padding(
        padding: const EdgeInsets.only(right: ThemeVars.paddingMd),
        child: CircleAvatar(
          backgroundColor: ThemeVars.skeletonAvatarBackgroundColor,
          radius: (this.avatarSize ?? ThemeVars.skeletonAvatarSize) / 2,
        ),
      );
    }

    return SizedBox.shrink();
  }

  Widget _buildTitle(BuildContext context) {
    if (this.title) {
      final tWidth =
          this.titleWidth > 1 ? this.titleWidth : ThemeVars.skeletonTitleWidth;
      Widget title = Container(
        width: tWidth,
        height: ThemeVars.skeletonRowHeight,
        decoration: BoxDecoration(
          color: ThemeVars.skeletonRowBackgroundColor,
          borderRadius: this.borderRadius,
        ),
      );

      if (this.titleWidth <= 1) {
        title = FractionallySizedBox(
          widthFactor: this.titleWidth,
          child: title,
        );
      }
      return title;
    }
    return SizedBox.shrink();
  }

  double getRowWidth(int index) {
    if (this.rowWidth == DEFAULT_ROW_WIDTH && index == this.row - 1) {
      return DEFAULT_LAST_ROW_WIDTH;
    }

    if (this.rowWidths != null) {
      return this.rowWidths[index];
    }

    return this.rowWidth;
  }

  List<Widget> _buildRows(BuildContext context) {
    final rows = List<Widget>();
    for (var i = 0; i < this.row; i++) {
      final rWidth = this.getRowWidth(i);
      Widget row = Container(
        width: rWidth,
        height: ThemeVars.skeletonRowHeight,
        decoration: BoxDecoration(
          color: ThemeVars.skeletonRowBackgroundColor,
          borderRadius: this.borderRadius,
        ),
      );
      if (rWidth <= 1) {
        row = FractionallySizedBox(
          widthFactor: rWidth,
          child: row,
        );
      }
      rows..add(SizedBox(height: ThemeVars.skeletonRowMarginTop))..add(row);
    }

    return rows;
  }
}

class _AnimatedOpacityBlock extends StatefulWidget {
  const _AnimatedOpacityBlock({
    Key key,
    this.child,
  }) : super(key: key);

  final Widget child;

  @override
  __AnimatedOpacityBlockState createState() => __AnimatedOpacityBlockState();
}

class __AnimatedOpacityBlockState extends State<_AnimatedOpacityBlock> {
  bool show = true;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(microseconds: 1)).then((value) {
      setState(() {
        show = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      onEnd: () {
        setState(() => show = !show);
      },
      duration: ThemeVars.skeletonAnimationDuration,
      curve: Curves.easeInOut,
      opacity: show ? 1.0 : 0.6,
      child: this.widget.child,
    );
  }
}

/// 头像占位图形状
enum FlanSkeletonAvatarShape {
  square,
  round,
}
