import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import '../../styles/var.dart';
import '../../styles/icons.dart';
import './icon.dart';

/// ### FlanImage 图片
/// 增强版的 img 标签，提供多种图片填充模式，支持图片懒加载、加载中提示、加载失败提示。
class FlanImage extends StatelessWidget {
  const FlanImage({
    Key key,
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
    this.errorIcon = FlanIcons.photo_fail,
    this.loadingIcon = FlanIcons.photo,
    this.onClick,
    this.onLoad,
    this.onError,
    this.child,
    this.loadingSlot,
    this.errorSlot,
  })  : assert(fit != null && fit is BoxFit),
        assert(round != null),
        assert(lazyLoad != null),
        assert(showError != null),
        assert(showLoading != null),
        assert(errorIcon != null &&
            (errorIcon is IconData || errorIcon is String)),
        assert(loadingIcon != null &&
            (loadingIcon is IconData || loadingIcon is String)),
        super(key: key);

  // ****************** Props ******************
  /// 图片链接
  final String src;

  /// 图片填充模式
  final BoxFit fit;

  /// 替代文本
  final String alt;

  /// 宽度
  final double width;

  /// 高度
  final double height;

  /// 圆角大小
  final double radius;

  /// 是否显示为圆形
  final bool round;

  /// 是否开启图片懒加载(暂不支持)
  final bool lazyLoad; //TODO: 暂时解决不了
  /// 是否展示图片加载失败提示
  final bool showError;

  /// 是否展示图片加载失败提示
  final bool showLoading;

  /// 失败时提示的图标名称或图片链接
  final dynamic errorIcon;

  /// 加载时提示的图标名称或图片链接
  final dynamic loadingIcon;

  // ****************** Events ******************
  /// 点击图片时触发
  final VoidCallback onClick;

  /// 图片加载完毕时触发
  final VoidCallback onLoad;

  /// 图片加载失败时触发
  final VoidCallback onError;

  // ****************** Slots ******************
  /// 自定义图片下方的内容
  final Widget child;

  /// 自定义加载中的提示内容
  final Widget loadingSlot;

  /// 自定义加载失败时的提示内容
  final Widget errorSlot;

  @override
  Widget build(BuildContext context) {
    Widget image = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        this._buildImage(),
        this.child,
      ].where((element) => element != null).toList(),
    );

    if (this.round) {
      image = ClipOval(child: image);
    } else if (this.radius != null) {
      image = ClipRRect(
        child: image,
        borderRadius: BorderRadius.circular(this.radius),
      );
    }

    return Semantics(
      image: true,
      label: this.alt,
      excludeSemantics: false,
      child: image,
    );
  }

  /// 构建图片Loading图标
  Widget _buildLoadingIcon() {
    return DefaultTextStyle(
      style: TextStyle(
        color: ThemeVars.imagePlaceholderTextColor,
        fontSize: ThemeVars.imagePlaceholderFontSize,
      ),
      child: IconTheme(
        data: IconThemeData(
          color: ThemeVars.imageLoadingIconColor,
          size: ThemeVars.imageLoadingIconSize,
        ),
        child: Container(
          width: this.width,
          height: this.height,
          color: ThemeVars.imagePlaceholderBackgroundColor,
          child: Center(
            child: this.loadingSlot ?? FlanIcon(name: this.loadingIcon),
          ),
        ),
      ),
    );
  }

  /// 图片加载回调
  Widget onImageLoad(
      BuildContext context, Widget child, ImageChunkEvent loadingProgress) {
    if (this.src.isNotEmpty && loadingProgress == null) {
      return child;
    }

    if (this.showLoading) {
      return this._buildLoadingIcon();
    }

    return null;
  }

  /// 图片加载错误回调
  Widget _onImageError(
      BuildContext context, Object error, StackTrace stackTrace) {
    if (!this.showError) {
      return null;
    }

    return DefaultTextStyle(
      style: TextStyle(
        color: ThemeVars.imagePlaceholderTextColor,
        fontSize: ThemeVars.imagePlaceholderFontSize,
      ),
      child: IconTheme(
        data: IconThemeData(
          color: ThemeVars.imageErrorIconColor,
          size: ThemeVars.imageErrorIconSize,
        ),
        child: Container(
          width: this.width,
          height: this.height,
          color: ThemeVars.imagePlaceholderBackgroundColor,
          child: Center(
            child: this.errorSlot ?? FlanIcon(name: this.errorIcon),
          ),
        ),
      ),
    );
  }

  /// 构建图片内容
  Widget _buildImage() {
    if (this.src == null) {
      return this._buildLoadingIcon();
    }

    final isNetwork = RegExp("^https?:\/\/").hasMatch(this.src);

    if (isNetwork) {
      return Image.network(
        this.src,
        width: this.width,
        height: this.height,
        loadingBuilder: this.onImageLoad,
        errorBuilder: this._onImageError,
        fit: this.fit,
      );
    }

    return Image.asset(
      this.src,
      width: this.width,
      height: this.height,
      fit: this.fit,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties.add(DiagnosticsProperty<String>("src", src));
    properties.add(DiagnosticsProperty<String>("alt", alt));
    properties.add(
        DiagnosticsProperty<BoxFit>("fit", fit, defaultValue: BoxFit.fill));
    properties
        .add(DiagnosticsProperty<bool>("round", round, defaultValue: false));
    properties.add(DiagnosticsProperty<double>("width", width));
    properties.add(DiagnosticsProperty<double>("height", height));
    properties.add(DiagnosticsProperty<double>("radius", radius));
    properties.add(
        DiagnosticsProperty<bool>("lazyLoad", lazyLoad, defaultValue: false));
    properties.add(
        DiagnosticsProperty<bool>("showError", showError, defaultValue: true));
    properties.add(DiagnosticsProperty<bool>("showLoading", showLoading,
        defaultValue: true));
    properties.add(DiagnosticsProperty<dynamic>("errorIcon", errorIcon,
        defaultValue: FlanIcons.photo_fail));
    properties.add(DiagnosticsProperty<dynamic>("loadingIcon", loadingIcon,
        defaultValue: FlanIcons.photo));
    super.debugFillProperties(properties);
  }
}
