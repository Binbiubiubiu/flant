// 🐦 Flutter imports:
import 'package:flant/components/common/active_response.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// 🌎 Project imports:
import '../locale/l10n.dart';
import '../styles/components/share_sheet_theme.dart';
import '../styles/theme.dart';
import '../styles/var.dart';
import '../utils/widget.dart';
import 'popup.dart';

typedef FlanShareSheetSelectCallback = void Function(
    FlanShareSheetOption option, int index);

/// SwipeCell 滑动单元格
Future<T?> showFlanShareSheet<T extends Object?>(
  BuildContext context, {

  /// 分享选项
  List<Object> options = const <Object>[],

  /// 顶部标题
  String title = '',

  /// 取消按钮文字，传入空字符串可以隐藏按钮
  String cancelText = '',

  /// 标题下方的辅助描述文字
  String description = '',

  /// 动画时长
  Duration? duration,

  /// 是否显示圆角
  bool round = true,

  /// 自定义遮罩层样式
  Color? overlayColor,

  /// 是否在点击遮罩层后关闭
  bool closeOnClickOverlay = true,

  /// 是否开启底部安全区适配
  bool safeAreaInsetBottom = true,

  /// 点击选项时触发，禁用或加载状态下不会触发
  FlanShareSheetSelectCallback? onSelect,

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

  /// 自定义顶部标题
  WidgetBuilder? titleBuilder,

  /// 自定义描述文字
  WidgetBuilder? descriptionBuilder,

  /// 自定义取消按钮内容
  WidgetBuilder? cancelBuilder,
}) {
  assert(options.isEmpty ||
      options is List<FlanShareSheetOption> ||
      options is List<List<FlanShareSheetOption>>);
  return showFlanPopup(
    context,
    builder: (BuildContext context) {
      return _FlanShareSheet<Object>(
        options: options,
        title: title,
        description: description,
        cancelText: cancelText,
        onSelect: onSelect,
        onCancel: onCancel,
        titleSlot: titleBuilder?.call(context),
        descriptionSlot: descriptionBuilder?.call(context),
        cancelSlot: cancelBuilder?.call(context),
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

@optionalTypeArgs
class _FlanShareSheet<T extends dynamic> extends StatelessWidget {
  const _FlanShareSheet({
    Key? key,
    required this.options,
    this.title = '',
    this.cancelText = '',
    this.description = '',
    this.onSelect,
    this.onCancel,
    this.titleSlot,
    this.descriptionSlot,
    this.cancelSlot,
  }) : super(key: key);

  // ****************** Props ******************

  /// 顶部标题
  final String title;

  /// 取消按钮文字，传入空字符串可以隐藏按钮
  final String cancelText;

  /// 标题下方的辅助描述文字
  final String description;

  /// 分享选项
  final List<T> options;

  // ****************** Events ******************

  /// 点击分享选项时触发
  final FlanShareSheetSelectCallback? onSelect;

  /// 点击取消按钮时触发
  final VoidCallback? onCancel;

  // ****************** Slots ******************
  /// 自定义顶部标题
  final Widget? titleSlot;

  /// 自定义描述文字
  final Widget? descriptionSlot;

  /// 自定义取消按钮内容
  final Widget? cancelSlot;

  @override
  Widget build(BuildContext context) {
    final FlanShareSheetThemeData themeData =
        FlanTheme.of(context).shareSheetTheme;

    final bool hasCancel = cancelSlot != null || cancelText.isNotEmpty;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildHeader(themeData),
        ..._buildRows(context),
        Visibility(
          visible: hasCancel,
          child: Container(
            width: double.infinity,
            height: FlanThemeVars.paddingXs.rpx,
            color: FlanThemeVars.backgroundColor,
          ),
        ),
        Visibility(
          visible: hasCancel,
          child: _buildCancelButton(context),
        ),
      ],
    );
  }

  Widget _buildHeader(FlanShareSheetThemeData themeData) {
    final Widget titleWidget = titleSlot ??
        Visibility(
          visible: title.isNotEmpty,
          child: Text(
            title,
            style: TextStyle(
              fontSize: themeData.titleFontSize,
              color: themeData.titleColor,
              fontWeight: FontWeight.normal,
              height: themeData.titleLineHeight,
            ),
            textAlign: TextAlign.center,
            textHeightBehavior: FlanThemeVars.textHeightBehavior,
          ),
        );
    final Widget descriptionWidget = descriptionSlot ??
        Visibility(
          visible: description.isNotEmpty,
          child: Text(
            description,
            style: TextStyle(
              fontSize: themeData.descriptionFontSize,
              color: themeData.descriptionColor,
              height: themeData.descriptionLineHeight,
            ),
            textAlign: TextAlign.center,
            textHeightBehavior: FlanThemeVars.textHeightBehavior,
          ),
        );

    final bool hasTitle = titleSlot != null || title.isNotEmpty;
    final bool hasDescription =
        descriptionSlot != null || description.isNotEmpty;
    return Visibility(
      visible: hasTitle || hasDescription,
      child: Container(
        width: double.infinity,
        padding: ThemeVars.shareSheetHeaderPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: FlanThemeVars.paddingXs.rpx),
            titleWidget,
            SizedBox(height: FlanThemeVars.paddingXs.rpx),
            descriptionWidget,
          ],
        ),
      ),
    );
  }

  Widget _buildOptions(
      BuildContext context, List<FlanShareSheetOption> options) {
    // 避免懒加载
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const ClampingScrollPhysics(),
      padding: EdgeInsets.only(
        top: FlanThemeVars.paddingMd.rpx,
        bottom: FlanThemeVars.paddingMd.rpx,
        left: FlanThemeVars.paddingXs.rpx,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List<Widget>.generate(
          options.length,
          (int i) {
            final FlanShareSheetOption option = options[i];
            return _FlanShareSheetOption(
              option: option,
              onClick: () {
                onSelect?.call(option, i);
                Navigator.of(context).maybePop(
                  <String, dynamic>{
                    'option': option,
                    'index': i,
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }

  List<Widget> _buildRows(BuildContext context) {
    if (options.isEmpty) {
      return <Widget>[];
    }
    if (options[0] is List<FlanShareSheetOption>) {
      final List<Widget> content = <Widget>[];
      for (int i = 0; i < options.length; i++) {
        if (i != 0) {
          content.add(
            Divider(
              color: FlanThemeVars.borderColor,
              height: 0.5,
              indent: FlanThemeVars.paddingMd.rpx,
            ),
          );
        }
        content.add(
          _buildOptions(context, options[i] as List<FlanShareSheetOption>),
        );
      }
      return content;
    }
    return <Widget>[
      _buildOptions(context, options as List<FlanShareSheetOption>),
    ];
  }

  Widget _buildCancelButton(BuildContext context) {
    final String cancelText =
        this.cancelText.isEmpty ? FlanS.of(context).cancel : this.cancelText;

    return _FlanShareSheetCancelButton(
      onClick: () {
        onCancel?.call();
        Navigator.of(context).maybePop();
      },
      child: cancelSlot ?? Text(cancelText),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
        .add(DiagnosticsProperty<String>('title', title, defaultValue: ''));
    properties.add(DiagnosticsProperty<String>('cancelText', cancelText));
    properties.add(DiagnosticsProperty<String>('description', description,
        defaultValue: ''));

    properties.add(DiagnosticsProperty<List<T>>('options', options,
        defaultValue: const <FlanShareSheetOption>[]));

    super.debugFillProperties(properties);
  }
}

class _FlanShareSheetCancelButton extends StatelessWidget {
  const _FlanShareSheetCancelButton({
    Key? key,
    required this.child,
    this.onClick,
  }) : super(key: key);

  final Widget child;
  final VoidCallback? onClick;

  @override
  Widget build(BuildContext context) {
    final FlanShareSheetThemeData themeData =
        FlanTheme.of(context).shareSheetTheme;
    return Semantics(
      button: true,
      child: FlanActiveResponse(
        onClick: onClick,
        builder: (BuildContext contenxt, bool active, Widget? child) {
          return Container(
            width: double.infinity,
            height: themeData.cancelButtonHeight,
            color: active
                ? FlanThemeVars.activeColor
                : themeData.cancelButtonBackground,
            alignment: Alignment.center,
            child: child,
          );
        },
        child: DefaultTextStyle(
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: FlanThemeVars.textColor,
            fontSize: themeData.cancelButtonFontSize,
            height: themeData.cancelButtonHeight,
          ),
          textHeightBehavior: FlanThemeVars.textHeightBehavior,
          child: child,
        ),
      ),
    );
  }
}

class _FlanShareSheetOption extends StatelessWidget {
  const _FlanShareSheetOption({
    Key? key,
    required this.option,
    required this.onClick,
  }) : super(key: key);

  final FlanShareSheetOption option;
  final VoidCallback onClick;

  @override
  Widget build(BuildContext context) {
    final FlanShareSheetThemeData themeData =
        FlanTheme.of(context).shareSheetTheme;

    final Widget name = Visibility(
      visible: option.name.isNotEmpty,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: FlanThemeVars.paddingBase.rpx,
        ),
        child: Text(
          option.name,
          style: TextStyle(
            color: themeData.optionNameColor,
            fontSize: themeData.optionNameFontSize,
          ),
        ),
      ),
    );

    final Widget description = Visibility(
      visible: option.description.isNotEmpty,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: FlanThemeVars.paddingBase.rpx,
        ),
        child: Text(
          option.description,
          style: TextStyle(
            color: themeData.descriptionColor,
            fontSize: themeData.descriptionFontSize,
          ),
        ),
      ),
    );

    return Semantics(
      button: true,
      child: FlanActiveResponse(
        onClick: onClick,
        builder: (BuildContext contenxt, bool active, Widget? child) {
          return Opacity(
            opacity: active ? FlanThemeVars.activeOpacity : 1.0,
            child: child,
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: FlanThemeVars.paddingMd.rpx,
              ),
              child: Image.network(
                option.icon,
                width: themeData.iconSize,
                height: themeData.iconSize,
              ),
            ),
            SizedBox(height: FlanThemeVars.paddingXs.rpx),
            name,
            description,
          ],
        ),
      ),
    );
  }
}

class FlanShareSheetOption {
  const FlanShareSheetOption({
    required this.name,
    required this.icon,
    this.description = '',
  });

  /// 分享渠道名称
  final String name;

  /// 图标，可选值为 `wechat` `weibo` `qq` `link` `qrcode` `poster` `weapp-qrcode` `wechat-moments`，支持传入图片 URL;
  final String icon;

  /// 分享选项描述
  final String description;
}

class FlanShareSheetIcons {
  FlanShareSheetIcons._();

  static String qq = getIconURL('qq');
  static String link = getIconURL('link');
  static String weibo = getIconURL('weibo');
  static String wechat = getIconURL('wechat');
  static String poster = getIconURL('poster');
  static String qrcode = getIconURL('qrcode');
  static String weappQrcode = getIconURL('weapp-qrcode');
  static String wechatMoments = getIconURL('wechat-moments');

  static String getIconURL(String icon) =>
      'https://img.yzcdn.cn/vant/share-sheet-$icon.png';
}
