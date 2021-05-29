// 🐦 Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

// 🌎 Project imports:
import '../styles/components/action_sheet_theme.dart';
import '../styles/theme.dart';
import '../styles/var.dart';
import '../utils/widget.dart';
import 'common/active_response.dart';
import 'icon.dart';
import 'loading.dart';
import 'popup.dart';
import 'style.dart';

typedef FlanActionSheetSelectCallback = void Function(
    FlanActionSheetAction action, int index);

/// ### FlanActionSheet 动作面板
/// 底部弹起的模态面板，包含与当前情境相关的多个选项。
Future<T?> showFlanActionSheet<T extends Object?>(
  BuildContext context, {

  /// 面板选项列表
  List<FlanActionSheetAction> actions = const <FlanActionSheetAction>[],

  /// 顶部标题
  String title = '',

  /// 取消按钮文字
  String cancelText = '',

  /// 选项上方的描述信息
  String description = '',

  /// 是否显示关闭图标
  bool closeable = true,

  /// 关闭图标名称
  IconData closeIconName = FlanIcons.cross,

  /// 关闭图片链接
  String? closeIconUrl,

  /// 动画时长
  Duration? duration,

  /// 是否显示圆角
  bool round = true,

  /// 自定义遮罩层样式
  Color? overlayColor,

  /// 是否在点击选项后关闭
  bool closeOnClickAction = false,

  /// 是否在点击遮罩层后关闭
  bool closeOnClickOverlay = true,

  /// 是否开启底部安全区适配
  bool safeAreaInsetBottom = true,

  /// 点击选项时触发，禁用或加载状态下不会触发
  FlanActionSheetSelectCallback? onSelect,

  /// 点击取消按钮时触发
  VoidCallback? onCancel,

  /// 打开面板时触发
  VoidCallback? onOpen,

  /// 关闭面板时触发
  VoidCallback? onClose,

  /// 打开面板且动画结束后触发
  VoidCallback? onOpened,

  /// 关闭面板且动画结束后触发
  VoidCallback? onClosed,

  /// 自定义面板的展示内容
  WidgetBuilder? builder,

  /// 自定义描述文案
  WidgetBuilder? descriptionBuilder,

  /// 自定义取消按钮内容
  WidgetBuilder? cancelBuilder,
}) {
  return showFlanPopup(
    context,
    builder: (BuildContext context) {
      return _FlanActionSheet(
        actions: actions,
        title: title,
        description: description,
        cancelText: cancelText,
        closeOnClickAction: closeOnClickAction,
        onSelect: onSelect,
        onCancel: onCancel,
        child: builder?.call(context),
        descriptionSlot: descriptionBuilder?.call(context),
        cancelSlot: cancelBuilder?.call(context),
        closeIconName: closeIconName,
        closeIconUrl: closeIconUrl,
        closeable: closeable,
      );
    },
    position: FlanPopupPosition.bottom,
    duration: duration,
    round: round,
    overlayColor: overlayColor,
    safeAreaInsetBottom: safeAreaInsetBottom,
    closeOnClickOverlay: closeOnClickOverlay,
    onOpen: onOpen,
    onClose: onClose,
    onOpened: onOpened,
    onClosed: onClosed,
  );
}

class _FlanActionSheet extends StatelessWidget {
  const _FlanActionSheet({
    Key? key,
    this.actions = const <FlanActionSheetAction>[],
    this.title = '',
    this.cancelText = '',
    this.description = '',
    required this.closeOnClickAction,
    required this.closeable,
    required this.closeIconName,
    this.closeIconUrl,
    this.onSelect,
    this.onCancel,
    this.child,
    this.descriptionSlot,
    this.cancelSlot,
  }) : super(key: key);

  // ****************** Props ******************

  /// 面板选项列表
  final List<FlanActionSheetAction> actions;

  /// 顶部标题
  final String title;

  /// 取消按钮文字
  final String cancelText;

  /// 选项上方的描述信息
  final String description;

  /// 是否在点击选项后关闭
  final bool closeOnClickAction;

  /// 是否显示关闭图标
  final bool closeable;

  /// 关闭图标名称
  final IconData closeIconName;

  /// 关闭图片链接
  final String? closeIconUrl;

  // ****************** Events ******************

  /// 点击选项时触发，禁用或加载状态下不会触发
  final FlanActionSheetSelectCallback? onSelect;

  /// 点击取消按钮时触发
  final VoidCallback? onCancel;

  // ****************** Slots ******************
  /// 自定义面板的展示内容
  final Widget? child;

  /// 自定义描述文案
  final Widget? descriptionSlot;

  /// 自定义取消按钮内容
  final Widget? cancelSlot;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final FlanActionSheetThemeData themeData =
        FlanTheme.of(context).actionSheetTheme;

    return DefaultTextStyle(
      style: TextStyle(
        color: themeData.itemTextColor,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _buildHeader(context, themeData),
          _buildDescription(themeData),
          LimitedBox(
            maxHeight: size.height * themeData.maxHeightFactor,
            child: ListView(
                physics: const ClampingScrollPhysics(),
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                children: List<Widget>.generate(
                  actions.length,
                  (int index) =>
                      _buildOption(context, themeData, actions[index], index),
                )..add(child ?? const SizedBox.shrink())),
          ),
          ..._buildCancel(context, themeData),
        ],
      ),
    );
  }

  Widget _buildHeader(
      BuildContext context, FlanActionSheetThemeData themeData) {
    return Visibility(
      visible: title.isNotEmpty,
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: Text(
              title,
              style: TextStyle(
                fontWeight: FlanThemeVars.fontWeightBold,
                fontSize: themeData.headerFontSize,
                height: themeData.headerHeight,
              ),
              textHeightBehavior: FlanThemeVars.textHeightBehavior,
            ),
          ),
          Visibility(
            visible: closeable,
            child: _buildCloseIcon(context, themeData),
          ),
        ],
      ),
    );
  }

  Widget _buildCloseIcon(
      BuildContext context, FlanActionSheetThemeData themeData) {
    final Widget icon = Semantics(
      button: true,
      child: FlanActiveResponse(
        onClick: () {
          Navigator.of(context).maybePop();
        },
        builder: (BuildContext contenxt, bool active, Widget? child) {
          return Container(
            alignment: Alignment.center,
            padding: themeData.closeIconPadding,
            child: FlanIcon(
              iconName: closeIconName,
              iconUrl: closeIconUrl,
              color: active
                  ? themeData.closeIconActiveColor
                  : themeData.closeIconColor,
              size: themeData.closeIconSize,
            ),
          );
        },
      ),
    );

    return Positioned(
      top: 0,
      right: 0,
      bottom: 0,
      child: icon,
    );
  }

  List<Widget> _buildCancel(
      BuildContext context, FlanActionSheetThemeData themeData) {
    if (cancelSlot != null || cancelText.isNotEmpty) {
      return <Widget>[
        Container(
          color: themeData.cancelPaddingColor,
          height: themeData.cancelPaddingTop,
        ),
        _FlanActionSheetButton(
          onClick: () {
            onCancel?.call();
            Navigator.of(context).maybePop();
          },
          child: DefaultTextStyle(
            style: TextStyle(color: themeData.cancelTextColor),
            child: cancelSlot ?? Text(cancelText),
          ),
        ),
      ];
    }
    return <Widget>[];
  }

  Widget _buildOption(BuildContext context, FlanActionSheetThemeData themeData,
      FlanActionSheetAction item, int index) {
    return _FlanActionSheetButton(
      loading: item.loading,
      disabled: item.disabled,
      onClick: () {
        if (item.disabled || item.loading) {
          return;
        }

        item.callback?.call(item);

        if (closeOnClickAction) {
          Navigator.of(context).maybePop(<String, dynamic>{
            'action': item,
            'index': index,
          });
        }

        onSelect?.call(item, index);
      },
      child: Visibility(
        visible: !item.loading,
        replacement: FlanLoading(
          color: themeData.itemDisabledTextColor,
          size: themeData.loadingIconSize,
        ),
        child: Column(
          children: <Widget>[
            Text(
              item.name,
              style: TextStyle(color: item.color),
            ),
            Visibility(
              visible: item.subname.isNotEmpty,
              child: Padding(
                padding: EdgeInsets.only(top: FlanThemeVars.paddingXs.rpx),
                child: Text(
                  item.subname,
                  style: TextStyle(
                    color: themeData.subnameColor,
                    fontSize: themeData.subnameFontSize,
                    height: themeData.subnameLineHeight,
                  ),
                  textHeightBehavior: FlanThemeVars.textHeightBehavior,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDescription(FlanActionSheetThemeData themeData) {
    return Visibility(
      visible: description.isNotEmpty || descriptionSlot != null,
      child: Container(
        width: double.infinity,
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(horizontal: FlanThemeVars.paddingMd.rpx),
        padding: EdgeInsets.symmetric(vertical: 20.0.rpx),
        decoration: const BoxDecoration(border: Border(bottom: FlanHairLine())),
        child: DefaultTextStyle(
          style: TextStyle(
            color: themeData.descriptionColor,
            fontSize: themeData.descriptionFontSize,
            height: themeData.descriptionLineHeight,
          ),
          textHeightBehavior: FlanThemeVars.textHeightBehavior,
          child: descriptionSlot ?? Text(description),
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties.add(DiagnosticsProperty<List<FlanActionSheetAction>>(
        'actions', actions,
        defaultValue: const <FlanActionSheetAction>[]));
    properties
        .add(DiagnosticsProperty<String>('title', title, defaultValue: ''));
    properties.add(DiagnosticsProperty<String>('cancelText', cancelText,
        defaultValue: ''));
    properties.add(DiagnosticsProperty<String>('description', description,
        defaultValue: ''));

    properties.add(DiagnosticsProperty<bool>(
        'closeOnClickAction', closeOnClickAction,
        defaultValue: false));

    super.debugFillProperties(properties);
  }
}

class _FlanActionSheetButton extends StatelessWidget {
  const _FlanActionSheetButton({
    Key? key,
    this.text = '',
    this.disabled = false,
    this.loading = false,
    required this.child,
    this.onClick,
  }) : super(key: key);

  final String text;
  final bool disabled;
  final bool loading;
  final VoidCallback? onClick;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final bool disabled = this.disabled || loading;
    final FlanActionSheetThemeData themeData =
        FlanTheme.of(context).actionSheetTheme;
    return Semantics(
      button: true,
      enabled: !disabled,
      child: FlanActiveResponse(
        disabled: disabled,
        enable: !loading,
        cursorBuilder: (SystemMouseCursor cursor) {
          return loading ? SystemMouseCursors.basic : cursor;
        },
        onClick: onClick,
        builder: (BuildContext contenxt, bool active, Widget? child) {
          return Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              vertical: 14.0.rpx,
              horizontal: FlanThemeVars.paddingMd.rpx,
            ),
            color:
                active ? FlanThemeVars.activeColor : themeData.itemBackground,
            alignment: Alignment.center,
            child: child,
          );
        },
        child: DefaultTextStyle(
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: disabled
                ? themeData.itemDisabledTextColor
                : themeData.itemTextColor,
            fontSize: themeData.itemFontSize,
            height: themeData.itemLineHeight,
          ),
          textHeightBehavior: FlanThemeVars.textHeightBehavior,
          child: child,
        ),
      ),
    );
  }
}

class FlanActionSheetAction {
  const FlanActionSheetAction({
    this.name = '',
    this.color,
    this.subname = '',
    this.loading = false,
    this.disabled = false,
    this.callback,
    // this.className,
  });

  /// 标题
  final String name;

  /// 选项文字颜色
  final Color? color;

  /// 二级标题
  final String subname;

  /// 是否为加载状态
  final bool loading;

  /// 是否为禁用状态
  final bool disabled;

  /// 点击时触发的回调函数
  final void Function(FlanActionSheetAction action)? callback;

  /// 为对应列添加额外的 class
  // final String className;
}
