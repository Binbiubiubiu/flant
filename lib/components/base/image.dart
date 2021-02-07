import 'package:flant/components/base/icon.dart';
import 'package:flant/styles/icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flant/styles/var.dart';

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
    // this.lazyLoad = false,
    this.showError = true,
    this.showLoading = true,
    this.errorIcon = FlanIcons.photo_fail,
    this.loadingIcon = FlanIcons.photo,
    this.onError,
    this.onLoad,
    this.child,
    this.loadingSlot,
    this.errorSlot,
  }) : super(key: key);

  final String src;
  final String alt;
  final BoxFit fit;
  final bool round;
  final double width;
  final double height;
  final double radius;
  // final bool lazyLoad; //TODO: 暂时解决不了
  final bool showError;
  final bool showLoading;
  final IconData errorIcon;
  final IconData loadingIcon;

  final VoidCallback onLoad;
  final VoidCallback onError;

  //slot
  final Widget child;
  final Widget loadingSlot;
  final Widget errorSlot;

  @override
  Widget build(BuildContext context) {
    Widget image = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Column(
          children: [
            this.buildImage(),
            this.child,
          ].where((element) => element != null).toList(),
        )
      ],
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

  Widget buildLoadingIcon() {
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

  Widget onImageLoad(
      BuildContext context, Widget child, ImageChunkEvent loadingProgress) {
    if (this.src.isNotEmpty && loadingProgress == null) {
      return child;
    }

    if (this.showLoading) {
      return this.buildLoadingIcon();
    }

    return null;
  }

  Widget onImageError(
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

  Widget buildImage() {
    if (this.src == null) {
      return this.buildLoadingIcon();
    }

    final isNetwork = RegExp("^https?:\/\/").hasMatch(this.src);

    if (isNetwork) {
      return Image.network(
        this.src,
        width: this.width,
        height: this.height,
        loadingBuilder: this.onImageLoad,
        errorBuilder: this.onImageError,
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
}
