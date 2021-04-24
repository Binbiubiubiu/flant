// 🐦 Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'badge.dart';

export '../styles/icons.dart';

/// ### FlanIcon 单元格
/// 基于字体的图标集，可以通过 Icon 组件使用，也可以在其他组件中通过 `icon` 属性引用。
class FlanIcon extends StatelessWidget {
  const FlanIcon({
    Key? key,
    this.iconName,
    this.iconUrl,
    this.dot = false,
    this.size,
    this.color,
    this.badge = '',
    this.onClick,
  }) : super(key: key);

  const FlanIcon.name(
    this.iconName, {
    Key? key,
    this.dot = false,
    this.size,
    this.color,
    this.badge = '',
    this.onClick,
  })  : iconUrl = null,
        super(key: key);

  const FlanIcon.url(
    this.iconUrl, {
    Key? key,
    this.dot = false,
    this.size,
    this.color,
    this.badge = '',
    this.onClick,
  })  : iconName = null,
        super(key: key);

  // ****************** Props ******************
  /// 图标名称
  final IconData? iconName;

  /// 图片链接
  final String? iconUrl;

  /// 是否显示图标右上角小红点
  final bool dot;

  /// 图标右上角徽标的内容
  final String badge;

  /// 图标颜色
  final Color? color;

  /// 图标大小
  final double? size;

  // ****************** Events ******************
  /// 点击图标时触发
  final GestureTapCallback? onClick;

  // ****************** Slots ******************

  @override
  Widget build(BuildContext context) {
    final FlanBadge badge = FlanBadge(
      dot: dot,
      content: this.badge,
      child: _buildIcon(context),
    );

    if (onClick != null) {
      return GestureDetector(
        onTap: onClick,
        child: badge,
      );
    }

    return badge;
  }

  // 构建图片图标
  Widget _buildIcon(BuildContext context) {
    final IconThemeData iconTheme = IconTheme.of(context);
    final double? iconSize = size ?? iconTheme.size;

    if (iconName != null) {
      return Icon(
        iconName,
        color: color ?? iconTheme.color,
        size: iconSize,
      );
    }

    final bool isNetWork = RegExp('^https?:\/\/').hasMatch(iconUrl!);

    if (isNetWork) {
      return ImageIcon(
        NetworkImage(iconUrl!),
        size: iconSize,
        color: color,
      );
    }

    return ImageIcon(
      AssetImage(iconUrl!),
      size: iconSize,
      color: color,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties.add(DiagnosticsProperty<IconData>('iconName', iconName));
    properties.add(DiagnosticsProperty<String>('iconUrl', iconUrl));
    properties.add(DiagnosticsProperty<bool>('dot', dot));
    properties.add(DiagnosticsProperty<double>('size', size));
    properties.add(DiagnosticsProperty<Color>('color', color));
    properties.add(DiagnosticsProperty<String>('badge', badge));
    super.debugFillProperties(properties);
  }
}
