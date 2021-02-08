import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import '../show/badge.dart';

export '../../styles/icons.dart';

/// ### FlanIcon 单元格
/// 基于字体的图标集，可以通过 Icon 组件使用，也可以在其他组件中通过 `icon` 属性引用。
class FlanIcon extends StatelessWidget {
  const FlanIcon({
    Key key,
    @required this.name,
    this.dot = false,
    this.size,
    this.color,
    this.classPrefix,
    this.badge,
    this.height,
    this.onClick,
  })  : assert(name != null && (name is IconData || name is String)),
        assert(dot != null),
        super(key: key);

  // ****************** Props ******************
  /// 图标名称或图片链接
  final dynamic name;

  /// 是否显示图标右上角小红点
  final bool dot;

  /// 图标右上角徽标的内容
  final String badge;

  /// 图标颜色
  final Color color;

  /// 图标大小
  final double size;

  /// 类名前缀，用于使用自定义图标
  final String classPrefix;

  /// 图表行高
  final double height;

  // ****************** Events ******************
  /// 点击图标时触发
  final GestureTapCallback onClick;

  // ****************** Slots ******************

  // bool get isImage {
  //   return this.name != null ? this.name.indexOf('/') != -1 : false;
  // }

  @override
  Widget build(BuildContext context) {
    final badge = FlanBadge(
      dot: this.dot,
      content: this.badge,
      child: SizedBox(
        height: this.height,
        child: this.name is IconData
            ? Icon(this.name, color: this.color, size: this.size ?? null)
            : this._buildImageIcon(context),
      ),
    );

    if (this.onClick != null) {
      return GestureDetector(
        onTap: this.onClick,
        child: badge,
      );
    }

    return badge;
  }

  // 构建图片图标
  Widget _buildImageIcon(BuildContext context) {
    final isNetWork = RegExp("^https?:\/\/").hasMatch(this.name);

    final size = this.size ?? IconTheme.of(context).size;
    return isNetWork
        ? Image.network(
            this.name,
            color: this.color,
            width: size,
            height: size,
            fit: BoxFit.contain,
          )
        : Image.asset(
            this.name,
            color: this.color,
            width: size,
            height: size,
            fit: BoxFit.contain,
          );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties.add(DiagnosticsProperty<dynamic>("name", name));
    properties.add(DiagnosticsProperty<bool>("dot", dot));
    properties.add(DiagnosticsProperty<double>("size", size));
    properties.add(DiagnosticsProperty<Color>("color", color));
    properties.add(DiagnosticsProperty<String>("classPrefix", classPrefix));
    properties.add(DiagnosticsProperty<String>("badge", badge));
    properties.add(DiagnosticsProperty<double>("height", height));
    super.debugFillProperties(properties);
  }
}
