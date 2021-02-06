import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
// import 'package:flant/styles/var.dart';

import '../show/badge.dart';

class FlanIcon extends StatelessWidget {
  const FlanIcon({
    Key key,
    this.dot = false,
    this.name,
    this.size,
    this.color,
    this.classPrefix,
    this.badge,
    this.height,
  }) : super(key: key);

  final bool dot;
  final dynamic name;
  final double size;
  final Color color;
  final String classPrefix;
  final String badge;
  final double height;

  // bool get isImage {
  //   return this.name != null ? this.name.indexOf('/') != -1 : false;
  // }

  @override
  Widget build(BuildContext context) {
    return FlanBadge(
      dot: this.dot,
      content: this.badge,
      child: SizedBox(
        height: this.height,
        child: this.name is IconData
            ? Icon(this.name, color: this.color, size: this.size ?? null)
            : this.buildImageIcon(context),
      ),
    );
  }

  buildImageIcon(BuildContext context) {
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
}
