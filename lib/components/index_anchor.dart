// 🐦 Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class FlanIndexAnchor extends StatelessWidget {
  const FlanIndexAnchor({
    Key? key,
    required this.index,
    this.child,
  }) : super(key: key);

  // ****************** Props ******************

  final String index;

  // ****************** Events ******************

  // ****************** Slots ******************
  /// 内容
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
        // child: child,
        );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties.add(DiagnosticsProperty<String>('index', index));

    super.debugFillProperties(properties);
  }
}
