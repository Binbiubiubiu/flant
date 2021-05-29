// 🎯 Dart imports:
import 'dart:async';

// 🐦 Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// 🌎 Project imports:
import '../styles/components/image_preview_theme.dart';
import '../styles/theme.dart';
import '../styles/var.dart';
import '../utils/widget.dart';
import 'common/active_response.dart';
import 'icon.dart';
import 'image.dart';
import 'popup.dart';
import 'style.dart';
import 'swipe.dart';

typedef FlanImagePreviewBeforeClose = Future<bool> Function(int active);
typedef FlanImagePreviewScale = void Function(int current, double scale);

/// ### ImagePreview 图片预览
/// 图片放大预览，支持函数调用和组件调用两种方式。
Future<T?> showFlanImagePreview<T extends Object?>(
  BuildContext context, {

  /// 需要预览的图片 URL 数组
  List<String> images = const <String>[],

  /// 图片预览起始位置索引
  int startPosition = 0,

  /// 动画时长
  Duration swipeDuration = const Duration(milliseconds: 300),

  /// 是否显示页码
  bool showIndex = true,

  /// 是否显示轮播指示器
  bool showIndicators = false,

  /// 是否开启循环播放
  bool loop = true,

  /// 是否显示关闭图标
  bool closeable = false,

  /// 关闭图标名称
  IconData closeIconName = FlanIcons.clear,

  /// 关闭图片链接
  String? closeIconUrl,

  /// 关闭图标位置，可选值为 `top-left` `top-right` `bottom-left` `bottom-right`
  FlanImagePreviewCloseIconPosition closeIconPosition =
      FlanImagePreviewCloseIconPosition.topRight,

  /// 动画时长
  Duration? duration,

  /// 关闭前的回调函数，返回 `false` 可阻止关闭，支持返回 `Future`
  FlanImagePreviewBeforeClose? beforeClose,

  /// 缩放图片时的回调函数，回调参数为当前索引和当前缩放值组成的对象
  FlanImagePreviewScale? onScale,

  /// 关闭且且动画结束后触发
  VoidCallback? onClosed,

  /// 切换图片时的回调函数，回调参数为当前索引
  ValueChanged<int>? onChange,

  /// 手势缩放时，最大缩放比例
  double maxZoom = 3.0,

  /// 手势缩放时，最小缩放比例
  double minZoom = 0.33,

  /// 动画
  FlanTransitionBuilder? transitionBuilder,

  /// 自定义遮罩层样式
  Color? overlayColor,

  /// 自定义页码内容
  Widget Function(BuildContext context, int index)? indexBuilder,

  /// 自定义覆盖在图片预览上方的内容
  WidgetBuilder? coverBuilder,
}) {
  final FlanImagePreviewThemeData themeData =
      FlanTheme.of(context).imagePreviewTheme;
  return showFlanPopup(
    context,
    builder: (BuildContext context) {
      return UnconstrainedBox(
        child: _FlanImagePreview(
          images: images,
          startPosition: startPosition,
          swipeDuration: swipeDuration,
          showIndex: showIndex,
          showIndicators: showIndicators,
          loop: loop,
          closeable: closeable,
          closeIconName: closeIconName,
          closeIconUrl: closeIconUrl,
          closeIconPosition: closeIconPosition,
          beforeClose: beforeClose,
          maxZoom: maxZoom,
          minZoom: minZoom,
          onScale: onScale,
          onChange: onChange,
          indexBuilder: indexBuilder,
          coverSlot: coverBuilder?.call(context),
        ),
      );
    },
    position: FlanPopupPosition.center,
    duration: duration,
    backgroundColor: Colors.transparent,
    overlayColor: overlayColor ?? themeData.overlayBackgroundColor,
    transitionBuilder: transitionBuilder,
    onClosed: onClosed,
  );
}

class _FlanImagePreview extends StatefulWidget {
  const _FlanImagePreview({
    Key? key,
    required this.images,
    required this.startPosition,
    required this.swipeDuration,
    required this.showIndex,
    required this.showIndicators,
    required this.loop,
    required this.closeable,
    required this.closeIconName,
    this.closeIconUrl,
    required this.closeIconPosition,
    this.beforeClose,
    required this.maxZoom,
    required this.minZoom,
    this.onScale,
    this.onChange,
    this.indexBuilder,
    this.coverSlot,
  }) : super(key: key);

  // ****************** Props ******************
  /// 需要预览的图片 URL 数组
  final List<String> images;

  /// 图片预览起始位置索引
  final int startPosition;

  /// 动画时长
  final Duration swipeDuration;

  /// 是否显示页码
  final bool showIndex;

  /// 是否显示轮播指示器
  final bool showIndicators;

  /// 是否开启循环播放
  final bool loop;

  /// 是否显示关闭图标
  final bool closeable;

  /// 关闭图标名称
  final IconData closeIconName;

  /// 关闭图片链接
  final String? closeIconUrl;

  /// 关闭图标位置，可选值为 `top-left` `top-right` `bottom-left` `bottom-right`
  final FlanImagePreviewCloseIconPosition closeIconPosition;

  /// 关闭前的回调函数，返回 `false` 可阻止关闭，支持返回 `Future`
  final FlanImagePreviewBeforeClose? beforeClose;

  /// 手势缩放时，最大缩放比例
  final double maxZoom;

  /// 手势缩放时，最小缩放比例
  final double minZoom;

  // ****************** Events ******************

  /// 缩放图片时的回调函数，回调参数为当前索引和当前缩放值组成的对象
  final FlanImagePreviewScale? onScale;

  /// 切换图片时的回调函数，回调参数为当前索引
  final ValueChanged<int>? onChange;

  // ****************** Slots ******************

  /// 	自定义页码内容
  final Widget? Function(BuildContext context, int index)? indexBuilder;

  /// 自定义覆盖在图片预览上方的内容
  final Widget? coverSlot;

  @override
  __FlanImagePreviewState createState() => __FlanImagePreviewState();
}

class __FlanImagePreviewState extends State<_FlanImagePreview>
    with SingleTickerProviderStateMixin {
  late FlanSwipeController swipeController;
  late TransformationController transformationController;

  late AnimationController _scaleAnimationController;
  Animation<Matrix4>? _scaleAnimation;

  late ValueNotifier<int> _current;
  final ValueNotifier<bool> _swipeEnable = ValueNotifier<bool>(true);

  int get current => _current.value;
  bool get swipeEnable => _swipeEnable.value;

  @override
  void initState() {
    swipeController = FlanSwipeController(
      itemCount: widget.images.length,
      loop: widget.loop,
      initialPage: widget.startPosition,
    );
    transformationController = TransformationController()
      ..addListener(_handleTransformationChange);
    _current = ValueNotifier<int>(widget.startPosition);
    _scaleAnimationController = AnimationController(
      vsync: this,
      duration: FlanThemeVars.animationDurationBase,
    )..addListener(_handleScaleController);

    super.initState();
  }

  void _handleTransformationChange() {
    _swipeEnable.value =
        transformationController.value.getNormalMatrix().isIdentity();
  }

  void _handleScaleController() {
    transformationController.value = _scaleAnimation!.value;
  }

  @override
  void dispose() {
    swipeController
      ..removeListener(_handleScaleController)
      ..dispose();
    _current.dispose();
    _swipeEnable.dispose();
    transformationController
      ..removeListener(_handleTransformationChange)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final FlanImagePreviewThemeData themeData =
        FlanTheme.of(context).imagePreviewTheme;
    return SafeArea(
      child: Stack(
        children: <Widget>[
          _buildImages(context),
          _buildClose(themeData),
          _buildIndex(themeData),
          _buildCover(),
        ],
      ),
    );
  }

  Widget _buildCover() {
    if (widget.coverSlot != null) {
      return Positioned(
        top: 0.0,
        left: 0.0,
        child: widget.coverSlot!,
      );
    }

    return const SizedBox.shrink();
  }

  Widget _buildIndex(FlanImagePreviewThemeData themeData) {
    if (widget.showIndex) {
      return Positioned(
        top: FlanThemeVars.paddingMd.rpx,
        left: 0.0,
        right: 0.0,
        child: IgnorePointer(
          child: DefaultTextStyle(
            style: TextStyle(
              fontSize: themeData.indexFontSize,
              color: themeData.indexTextColor,
              height: themeData.indexLineHeight,
              shadows: themeData.indexTextShadow,
            ),
            textHeightBehavior: FlanThemeVars.textHeightBehavior,
            textAlign: TextAlign.center,
            child: ValueListenableBuilder<int>(
              valueListenable: _current,
              builder: (BuildContext context, int value, Widget? child) {
                final int index = value + 1;
                return widget.indexBuilder?.call(context, index) ??
                    Text('$index / ${widget.images.length}');
              },
            ),
          ),
        ),
      );
    }
    return const SizedBox.shrink();
  }

  Widget _buildClose(FlanImagePreviewThemeData themeData) {
    final bool isTop = <FlanImagePreviewCloseIconPosition>[
      FlanImagePreviewCloseIconPosition.topLeft,
      FlanImagePreviewCloseIconPosition.topRight,
    ].contains(widget.closeIconPosition);
    final bool isBottom = <FlanImagePreviewCloseIconPosition>[
      FlanImagePreviewCloseIconPosition.bottomLeft,
      FlanImagePreviewCloseIconPosition.bottomRight,
    ].contains(widget.closeIconPosition);

    final bool isLeft = <FlanImagePreviewCloseIconPosition>[
      FlanImagePreviewCloseIconPosition.topLeft,
      FlanImagePreviewCloseIconPosition.bottomLeft,
    ].contains(widget.closeIconPosition);

    final bool isRight = <FlanImagePreviewCloseIconPosition>[
      FlanImagePreviewCloseIconPosition.topRight,
      FlanImagePreviewCloseIconPosition.bottomRight,
    ].contains(widget.closeIconPosition);

    if (widget.closeable) {
      return Positioned(
        top: isTop ? themeData.closeIconMargin : null,
        bottom: isBottom ? themeData.closeIconMargin : null,
        left: isLeft ? themeData.closeIconMargin : null,
        right: isRight ? themeData.closeIconMargin : null,
        child: Semantics(
          button: true,
          child: FlanActiveResponse(
            onClick: () {
              _emitClose(context);
            },
            builder: (BuildContext contenxt, bool active, Widget? child) {
              return FlanIcon(
                iconName: widget.closeIconName,
                iconUrl: widget.closeIconUrl,
                size: themeData.closeIconSize,
                color: active
                    ? themeData.closeIconActiveColor
                    : themeData.closeIconColor,
              );
            },
          ),
        ),
      );
    }
    return const SizedBox.shrink();
  }

  Widget _buildImages(BuildContext context) {
    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    final Size size = mediaQueryData.size;
    final EdgeInsets padding = mediaQueryData.padding;

    return GestureDetector(
      onTap: () {
        _emitClose(context);
      },
      onDoubleTap: () {
        if (swipeEnable) {
          _scaleAnimation = Matrix4Tween(
            begin: Matrix4.identity(),
            end: Matrix4.identity()
              ..scale(2.0, 2.0, 1.0)
              ..translate(-size.width / 4.0, -size.height / 4.0),
          ).animate(_scaleAnimationController);
        } else {
          _scaleAnimation = Matrix4Tween(
            begin: transformationController.value,
            end: Matrix4.identity(),
          ).animate(_scaleAnimationController);
        }
        _scaleAnimationController
          ..reset()
          ..forward();
      },
      child: InteractiveViewer(
        transformationController: transformationController,
        minScale: widget.minZoom,
        maxScale: widget.maxZoom,
        onInteractionUpdate: (ScaleUpdateDetails details) {
          widget.onScale?.call(current, details.scale);
        },
        child: ValueListenableBuilder<bool>(
          valueListenable: _swipeEnable,
          builder: (BuildContext context, bool enable, Widget? child) {
            return FlanSwipe(
              controller: swipeController,
              touchable: enable,
              itemBuilder: (BuildContext context, int index) {
                return Center(
                  child: FlanImage(
                    src: widget.images[index],
                    fit: BoxFit.contain,
                  ),
                );
              },
              itemCount: widget.images.length,
              onChange: (int value) {
                _current.value = value;
                widget.onChange?.call(value);
              },
              width: size.width - padding.left - padding.right,
              height: size.height - padding.top - padding.bottom,
              duration: widget.swipeDuration,
              showIndicators: widget.showIndicators,
              indicatorColor: Colors.white,
            );
          },
        ),
      ),
    );
  }

  Future<void> _emitClose(BuildContext context) async {
    final bool canClose = (await widget.beforeClose?.call(current)) ?? true;
    if (canClose) {
      Navigator.of(context).maybePop(<String, dynamic>{
        'index': current,
        'url': widget.images[current],
      });
    }
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties.add(DiagnosticsProperty<List<String>>('images', widget.images));
    properties
        .add(DiagnosticsProperty<int>('startPosition', widget.startPosition));
    properties.add(
        DiagnosticsProperty<Duration>('swipeDuration', widget.swipeDuration));
    properties.add(DiagnosticsProperty<bool>('showIndex', widget.showIndex));
    properties.add(
        DiagnosticsProperty<bool>('showIndicators', widget.showIndicators));
    properties.add(DiagnosticsProperty<bool>('loop', widget.loop));
    properties.add(DiagnosticsProperty<bool>('closeable', widget.closeable));
    properties.add(
        DiagnosticsProperty<IconData>('closeIconName', widget.closeIconName));
    properties
        .add(DiagnosticsProperty<String>('closeIconUrl', widget.closeIconUrl));
    properties.add(DiagnosticsProperty<FlanImagePreviewBeforeClose>(
        'beforeClose', widget.beforeClose));
    properties.add(DiagnosticsProperty<double>('maxZoom', widget.maxZoom));
    properties.add(DiagnosticsProperty<double>('minZoom', widget.minZoom));

    super.debugFillProperties(properties);
  }
}

/// 关闭图标位置
enum FlanImagePreviewCloseIconPosition {
  topLeft,
  topRight,
  bottomLeft,
  bottomRight,
}
