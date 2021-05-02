// 🎯 Dart imports:
import 'dart:math' as math;

// 🐦 Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../locale/l10n.dart';
import '../styles/components/contact_card_theme.dart';
import '../styles/theme.dart';
import '../styles/var.dart';
import '../utils/widget.dart';
import 'cell.dart';
import 'icon.dart';

/// ### ContactCard 联系人卡片
/// 以卡片的形式展示联系人信息。
class FlanContactCard extends StatelessWidget {
  const FlanContactCard({
    Key? key,
    this.type = FlanContactCardType.add,
    this.name = '',
    this.tel = '',
    this.addText = '',
    this.editable = true,
    this.onClick,
  }) : super(key: key);

  // ****************** Props ******************
  /// 卡片类型，可选值为 `edit` `add`
  final FlanContactCardType type;

  /// 联系人姓名
  final String name;

  /// 联系人手机号
  final String tel;

  /// 添加时的文案提示
  final String addText;

  /// 是否可编辑
  final bool editable;

  // ****************** Events ******************
  /// 点击时触发
  final VoidCallback? onClick;

  // ****************** Slots ******************

  @override
  Widget build(BuildContext context) {
    final FlanContactCardThemeData themeData =
        FlanTheme.of(context).contactCardTheme;
    return Stack(
      children: <Widget>[
        FlanCell(
          center: true,
          iconSlot: type == FlanContactCardType.edit
              ? const FlanIcon(iconName: FlanIcons.contact)
              : FlanIcon(
                  iconName: FlanIcons.add_square,
                  size: themeData.addIconSize,
                  color: themeData.addIconColor,
                ),
          border: false,
          isLink: editable,
          padding: EdgeInsets.all(themeData.padding),
          onClick: onClick,
          child: _buildContent(context, themeData),
        ),
        const Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: _ColorsDashLine(),
        ),
      ],
    );
  }

  Widget _buildContent(
    BuildContext context,
    FlanContactCardThemeData themeData,
  ) {
    final FlanS S = FlanS.of(context);

    Widget content;
    if (type == FlanContactCardType.add) {
      content = Container(
        height: themeData.addIconSize,
        alignment: Alignment.centerLeft,
        child: Text(
          addText.isNotEmpty ? addText : S.ContactCard_addText,
        ),
      );
    } else {
      content = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('${S.name}:$name'),
          Text('${S.tel}:$tel'),
        ],
      );
    }

    return Padding(
      padding: EdgeInsets.only(left: 5.0.rpx),
      child: content,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties.add(DiagnosticsProperty<FlanContactCardType>('type', type,
        defaultValue: FlanContactCardType.add));
    properties.add(DiagnosticsProperty<String>('name', name, defaultValue: ''));
    properties.add(DiagnosticsProperty<String>('tel', tel, defaultValue: ''));
    properties
        .add(DiagnosticsProperty<String>('addText', addText, defaultValue: ''));
    properties.add(
        DiagnosticsProperty<bool>('editable', editable, defaultValue: true));

    super.debugFillProperties(properties);
  }
}

/// 卡片类型
enum FlanContactCardType {
  add,
  edit,
}

class _ColorsDashLine extends StatelessWidget {
  const _ColorsDashLine({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final double maxWidth = constraints.maxWidth;
        return Container(
          height: 2.0,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              transform: const GradientRotation(math.pi / 4),
              tileMode: TileMode.repeated,
              begin: const Alignment(0.0, 0.0),
              end: Alignment(80.0 / maxWidth, 0.0),
              stops: const <double>[
                0.0,
                0.4,
                0.4,
                0.5,
                0.5,
                0.9,
                0.9,
                1.0,
              ],
              colors: const <Color>[
                Color(0xffff6c6c),
                Color(0xffff6c6c),
                Colors.transparent,
                Colors.transparent,
                FlanThemeVars.blue,
                FlanThemeVars.blue,
                Colors.transparent,
                Colors.transparent,
              ],
            ),
          ),
        );
      },
    );
  }
}
