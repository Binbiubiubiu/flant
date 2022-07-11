import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../styles/components/image_theme.dart';
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
    this.iconSize,
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

  /// 加载图标和失败图标的大小
  final double? iconSize;

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
    final FlanImageThemeData themeData = FlanImageTheme.of(context);

    Widget image = Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        _buildImage(themeData),
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
  Widget _buildLoadingIcon(FlanImageThemeData themeData) {
    return _FlanImagePlaceHolder(
      width: width,
      height: height,
      child: IconTheme(
        data: IconThemeData(
          color: themeData.loadingIconColor,
          size: themeData.loadingIconSize,
        ),
        child: loadingSlot ??
            FlanIcon(
              size: iconSize ?? themeData.loadingIconSize,
              color: themeData.loadingIconColor,
              iconName: loadingIconName,
              iconUrl: loadingIconUrl,
            ),
      ),
    );
  }

  Widget _buildErrorIcon(FlanImageThemeData themeData) {
    return _FlanImagePlaceHolder(
      width: width,
      height: height,
      child: IconTheme(
        data: IconThemeData(
          color: themeData.errorIconColor,
          size: themeData.errorIconSize,
        ),
        child: errorSlot ??
            FlanIcon(
              size: iconSize ?? themeData.errorIconSize,
              color: themeData.errorIconColor,
              iconName: errorIconName,
              iconUrl: errorIconUrl,
            ),
      ),
    );
  }

  /// 构建图片内容
  Widget _buildImage(FlanImageThemeData themeData) {
    if (src == null) {
      return _buildLoadingIcon(themeData);
    }

    final bool isNetwork = RegExp('^https?:\/\/').hasMatch(src!);

    if (isNetwork) {
      return Image.network(
        src!,
        width: width,
        height: height,
        loadingBuilder: (BuildContext context, Widget child,
            ImageChunkEvent? loadingProgress) {
          if (src != null && src!.isNotEmpty && loadingProgress == null) {
            return child;
          }

          return showLoading
              ? _buildLoadingIcon(themeData)
              : const SizedBox.shrink();
        },
        errorBuilder:
            (BuildContext context, Object error, StackTrace? stackTrace) {
          return showError
              ? _buildErrorIcon(themeData)
              : const SizedBox.shrink();
        },
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
    properties.add(DiagnosticsProperty<double>('iconSize', iconSize));
    super.debugFillProperties(properties);
  }
}

class _FlanImagePlaceHolder extends StatelessWidget {
  const _FlanImagePlaceHolder({
    Key? key,
    this.width,
    this.height,
    this.child,
  }) : super(key: key);

  final double? width;
  final double? height;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final FlanImageThemeData themeData = FlanImageTheme.of(context);

    return DefaultTextStyle(
      style: TextStyle(
        color: themeData.placeholderTextColor,
        fontSize: themeData.placeholderFontSize,
      ),
      child: Container(
        width: width,
        height: height,
        color: themeData.placeholderBackgroundColor,
        alignment: Alignment.center,
        child: child,
      ),
    );
  }
}
