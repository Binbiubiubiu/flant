import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import '../../styles/var.dart';

class FlanToast extends StatelessWidget {
  const FlanToast({
    Key key,
    this.type,
    this.position,
    this.message,
  }) : super(key: key);

  // ****************** Props ******************
  /// 提示类型，可选值为 `loading` `success` `fail` `html` `text`
  final FlanToastType type;

  /// 位置，可选值为 `top` `middle` `bottom`
  final FlanToastPosition position;

  final String message;

  // ****************** Events ******************

  // ****************** Slots ******************

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

/// Toast位置集合
enum FlanToastPosition {
  top,
  middle,
  bottom,
}

/// Toast类型集合
enum FlanToastType {
  text,
  loading,
  success,
  fail,
  html,
}
