// 🐦 Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// 🌎 Project imports:
import '../styles/var.dart';
import 'icon.dart';

/// ### FlanImage 图片
/// 增强版的 img 标签，提供多种图片填充模式，支持图片懒加载、加载中提示、加载失败提示。
class FlanImage extends StatelessWidget {
  const FlanImage({
    Key? key,
    this.src,
    this.alt,
    this.fit = BoxFit.fill,
    this.round = false,
    this.width,
    this.height,
    this.radius,
    this.lazyLoad = false,
    this.showError = true,
    this.showLoading = true,
    this.errorIconName = FlanIcons.photo_fail,
    this.errorIconUrl,
    this.loadingIconName = FlanIcons.photo,
    this.loadingIconUrl,
    this.onClick,
    this.onLoad,
    this.onError,
    this.child,
    this.loadingSlot,
    this.errorSlot,
  }) : super(key: key);

  // ****************** Props ******************
  /// 图片链接
  final String? src;

  /// 图片填充模式
  final BoxFit fit;

  /// 替代文本
  final String? alt;

  /// 宽度
  final double? width;

  /// 高度
  final double? height;

  /// 圆角大小
  final double? radius;

  /// 是否显示为圆形
  final bool round;

  /// 是否开启图片懒加载(暂不支持)
  // ignore: flutter_style_todos
  final bool lazyLoad; //TODO: 暂时解决不了
  /// 是否展示图片加载失败提示
  final bool showError;

  /// 是否展示图片加载失败提示
  final bool showLoading;

  /// 失败时提示的图标名称
  final IconData errorIconName;

  /// 失败时提示的图片链接
  final String? errorIconUrl;

  /// 加载时提示的图标名称
  final IconData loadingIconName;

  /// 加载时提示的图片链接
  final String? loadingIconUrl;

  // ****************** Events ******************
  /// 点击图片时触发
  final VoidCallback? onClick;

  /// 图片加载完毕时触发
  final VoidCallback? onLoad;

  /// 图片加载失败时触发
  final VoidCallback? onError;

  // ****************** Slots ******************
  /// 自定义图片下方的内容
  final Widget? child;

  /// 自定义加载中的提示内容
  final Widget? loadingSlot;

  /// 自定义加载失败时的提示内容
  final Widget? errorSlot;

  @override
  Widget build(BuildContext context) {
    Widget image = Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        _buildImage(),
        child ?? const SizedBox.shrink(),
      ],
    );

    if (round) {
      image = ClipOval(child: image);
    } else if (radius != null) {
      image = ClipRRect(
        child: image,
        borderRadius: BorderRadius.circular(radius!),
      );
    }

    return Semantics(
      image: true,
      label: alt,
      excludeSemantics: false,
      child: image,
    );
  }

  /// 构建图片Loading图标
  Widget _buildLoadingIcon() {
    return DefaultTextStyle(
      style: const TextStyle(
        color: ThemeVars.imagePlaceholderTextColor,
        fontSize: ThemeVars.imagePlaceholderFontSize,
      ),
      child: IconTheme(
        data: const IconThemeData(
          color: ThemeVars.imageLoadingIconColor,
          size: ThemeVars.imageLoadingIconSize,
        ),
        child: Container(
          width: width,
          height: height,
          color: ThemeVars.imagePlaceholderBackgroundColor,
          child: Center(
            child: loadingSlot ??
                FlanIcon(
                  iconName: loadingIconName,
                  iconUrl: loadingIconUrl,
                ),
          ),
        ),
      ),
    );
  }

  /// 图片加载回调
  Widget onImageLoad(
      BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
    if (src != null && src!.isNotEmpty && loadingProgress == null) {
      return child;
    }

    if (showLoading) {
      return _buildLoadingIcon();
    }

    return const SizedBox.shrink();
  }

  /// 图片加载错误回调
  Widget _onImageError(
      BuildContext context, Object error, StackTrace? stackTrace) {
    if (!showError) {
      return const SizedBox.shrink();
    }

    return DefaultTextStyle(
      style: const TextStyle(
        color: ThemeVars.imagePlaceholderTextColor,
        fontSize: ThemeVars.imagePlaceholderFontSize,
      ),
      child: IconTheme(
        data: const IconThemeData(
          color: ThemeVars.imageErrorIconColor,
          size: ThemeVars.imageErrorIconSize,
        ),
        child: Container(
          width: width,
          height: height,
          color: ThemeVars.imagePlaceholderBackgroundColor,
          child: Center(
            child: errorSlot ??
                FlanIcon(
                  iconName: errorIconName,
                  iconUrl: errorIconUrl,
                ),
          ),
        ),
      ),
    );
  }

  /// 构建图片内容
  Widget _buildImage() {
    if (src == null) {
      return _buildLoadingIcon();
    }

    final bool isNetwork = RegExp('^https?:\/\/').hasMatch(src!);

    if (isNetwork) {
      return Image.network(
        src!,
        width: width,
        height: height,
        loadingBuilder: onImageLoad,
        errorBuilder: _onImageError,
        fit: fit,
      );
    }

    return Image.asset(
      src!,
      width: width,
      height: height,
      fit: fit,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties.add(DiagnosticsProperty<String>('src', src));
    properties.add(DiagnosticsProperty<String>('alt', alt));
    properties.add(
        DiagnosticsProperty<BoxFit>('fit', fit, defaultValue: BoxFit.fill));
    properties
        .add(DiagnosticsProperty<bool>('round', round, defaultValue: false));
    properties.add(DiagnosticsProperty<double>('width', width));
    properties.add(DiagnosticsProperty<double>('height', height));
    properties.add(DiagnosticsProperty<double>('radius', radius));
    properties.add(
        DiagnosticsProperty<bool>('lazyLoad', lazyLoad, defaultValue: false));
    properties.add(
        DiagnosticsProperty<bool>('showError', showError, defaultValue: true));
    properties.add(DiagnosticsProperty<bool>('showLoading', showLoading,
        defaultValue: true));
    properties.add(DiagnosticsProperty<IconData>('errorIconName', errorIconName,
        defaultValue: FlanIcons.photo_fail));
    properties.add(DiagnosticsProperty<String>('errorIconUrl', errorIconUrl));
    properties.add(DiagnosticsProperty<IconData>(
        'loadingIconName', loadingIconName,
        defaultValue: FlanIcons.photo));
    properties
        .add(DiagnosticsProperty<String>('loadingIconUrl', loadingIconUrl));
    super.debugFillProperties(properties);
  }
}
