import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/semantics.dart';
import '../styles/var.dart';
import 'icon.dart';

/// ### Rate 评分
/// 用于对事物进行评级操作。
class FlanRate extends StatefulWidget {
  const FlanRate({
    Key? key,
    required this.value,
    this.count = 5,
    this.size,
    this.gutter,
    this.color,
    this.voidColor,
    this.disabledColor,
    this.iconName = FlanIcons.star,
    this.iconUrl,
    this.voidIconName = FlanIcons.star_o,
    this.voidIconUrl,
    this.iconPrefix = kFlanIconsFamily,
    this.allowHalf = false,
    this.readonly = false,
    this.disabled = false,
    this.touchable = true,
    required this.onChange,
  })   : assert(value > 0.0),
        super(key: key);

  // ****************** Props ******************
  /// 当前分值
  final double value;

  /// 图标总数
  final int count;

  /// 图标大小
  final double? size;

  /// 图标间距
  final double? gutter;

  /// 选中时的颜色
  final Color? color;

  /// 未选中时的颜色
  final Color? voidColor;

  /// 禁用时的颜色
  final Color? disabledColor;

  /// 选中图标名称
  final int iconName;

  /// 选中图标链接
  final String? iconUrl;

  /// 未选中的图标名称
  final int voidIconName;

  /// 未选中的图标链接
  final String? voidIconUrl;

  /// 图标类名前缀
  final String iconPrefix;

  /// 是否允许半选
  final bool allowHalf;

  /// 是否为只读状态，只读状态下无法修改评分
  final bool readonly;

  /// 是否禁用评分
  final bool disabled;

  /// 是否可以通过滑动手势选择评分
  final bool touchable;

  // ****************** Events ******************
  /// 当前分值变化时触发的事件
  final ValueChanged<double> onChange;

  @override
  _FlanRateState createState() => _FlanRateState();
}

class _FlanRateState extends State<FlanRate> {
  List<StarState> ranges = <StarState>[];

  GlobalKey wrapKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final List<Widget> children = <Widget>[];
    for (int i = 0; i < list.length; i++) {
      children.add(_buildStar(list[i], i));
    }

    return Semantics(
      sortKey: const OrdinalSortKey(0.0),
      child: MouseRegion(
        cursor: widget.disabled
            ? SystemMouseCursors.forbidden
            : widget.readonly
                ? SystemMouseCursors.basic
                : SystemMouseCursors.click,
        child: GestureDetector(
          onHorizontalDragStart: _onTouchStart,
          onHorizontalDragUpdate: _onTouchMove,
          child: Wrap(
            key: wrapKey,
            spacing: widget.gutter ?? ThemeVars.rateIconGutter,
            children: children,
          ),
        ),
      ),
    );
  }

  Widget _buildStar(FlanRateStatus status, int index) {
    final double score = index + 1;
    final bool isFull = status == FlanRateStatus.full;
    final bool isVoid = status == FlanRateStatus.none;

    final double size = widget.size ?? ThemeVars.rateIconSize;

    return Semantics(
      key: ValueKey<int>(index),
      checked: status == FlanRateStatus.none,
      child: Stack(
        children: <Widget>[
          FlanIcon(
            size: size,
            iconName: isFull ? widget.iconName : widget.voidIconName,
            iconUrl: isFull ? widget.iconUrl : widget.voidIconUrl,
            color: widget.disabled
                ? (widget.disabledColor ?? ThemeVars.rateIconDisabledColor)
                : isFull
                    ? (widget.color ?? ThemeVars.rateIconFullColor)
                    : (widget.voidColor ?? ThemeVars.rateIconVoidColor),
            classPrefix: widget.iconPrefix,
            onClick: () {
              _select(score);
            },
          ),
          if (widget.allowHalf)
            Positioned(
              left: 0.0,
              top: 0.0,
              child: ClipRect(
                clipper: _HalfStartClipper(),
                child: FlanIcon(
                  size: size,
                  iconName: isVoid ? widget.voidIconName : widget.iconName,
                  iconUrl: isVoid ? widget.voidIconUrl : widget.iconUrl,
                  color: widget.disabled
                      ? (widget.disabledColor ??
                          ThemeVars.rateIconDisabledColor)
                      : isVoid
                          ? (widget.voidColor ?? ThemeVars.rateIconVoidColor)
                          : (widget.color ?? ThemeVars.rateIconFullColor),
                  classPrefix: widget.iconPrefix,
                  onClick: () {
                    _select(score - 0.5);
                  },
                ),
              ),
            )
          else
            const SizedBox.shrink(),
        ],
      ),
    );
  }

  void _onTouchStart(DragStartDetails details) {
    if (untouchable) {
      return;
    }
    final List<Rect> rects = <Rect>[];
    wrapKey.currentContext
        ?.findRenderObject()
        ?.visitChildren((RenderObject child) {
      print(child.paintBounds.right);
      rects.add(child.paintBounds);
    });
    ranges.clear();

    for (int i = 0; i < rects.length; i++) {
      final Rect rect = rects[i];
      final double gutter =
          rect.width + (widget.gutter ?? ThemeVars.rateIconGutter);
      if (widget.allowHalf) {
        ranges.addAll(<StarState>[
          StarState(left: gutter * i, score: i + 0.5),
          StarState(left: gutter * i + rect.width / 2, score: i + 1),
        ]);
      } else {
        ranges.add(StarState(left: gutter * i, score: i + 1));
      }
    }
  }

  void _onTouchMove(DragUpdateDetails details) {
    if (untouchable) {
      return;
    }

    final double clientX = details.localPosition.dx;

    _select(_getScoreByPosition(clientX));
  }

  double _getScoreByPosition(double x) {
    print(x);
    for (int i = ranges.length - 1; i > 0; i--) {
      if (x > ranges[i].left) {
        return ranges[i].score;
      }
    }
    return widget.allowHalf ? 0.5 : 1;
  }

  void _select(double index) {
    if (!widget.disabled && !widget.readonly && index != widget.value) {
      widget.onChange(index);
    }
  }

  bool get untouchable =>
      widget.readonly || widget.disabled || !widget.touchable;

  List<FlanRateStatus> get list => List<FlanRateStatus>.generate(widget.count,
      (int i) => getRateStatus(widget.value, i + 1, widget.allowHalf));
}

enum FlanRateStatus {
  full,
  half,
  none,
}

FlanRateStatus getRateStatus(double value, int index, bool allowHalf) {
  if (value >= index) {
    return FlanRateStatus.full;
  }
  if (value + 0.5 >= index && allowHalf) {
    return FlanRateStatus.half;
  }
  return FlanRateStatus.none;
}

class StarState {
  StarState({
    required this.left,
    required this.score,
  });

  double left;
  double score;
}

class _HalfStartClipper extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) {
    return Rect.fromLTRB(0.0, 0.0, size.width / 2, size.height);
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return false;
  }
}
