// 🐦 Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// 📦 Package imports:
import 'package:flutter_svg/flutter_svg.dart';

// 🌎 Project imports:
import 'package:flant/components/loading.dart';
import '../styles/var.dart';

/// ### FlanNumberKeyboard 数字键盘
/// 虚拟数字键盘，可以配合密码输入框组件或自定义的输入框组件使用。
class FlanNumberKeyboard extends StatefulWidget {
  const FlanNumberKeyboard({
    Key? key,
    this.show = false,
    this.title,
    this.randomKeyOrder = false,
    this.closeButtonText,
    this.deleteButtonText,
    this.closeButtonLoading = false,
    this.theme = FlanNumberKeyboardTheme.normal,
    this.value = '',
    this.extraKey = const <String>[''],
    this.maxlength,
    // this.transition = true,
    this.blurOnClose = true,
    this.showDeleteKey = true,
    this.hideOnClickOutside = true,
    this.safeAreaInsetBottom = true,
    this.onInput,
    this.onDelete,
    this.onClose,
    this.onBlur,
    this.onShow,
    this.onHide,
    this.onChange,
    this.deleteSlot,
    this.extraKeySlot,
    this.titleLeftSlot,
  }) : super(key: key);

  // ****************** Props ******************
  /// 是否显示键盘
  final bool show;

  /// 键盘标题
  final String? title;

  /// 是否将通过随机顺序展示按键
  final bool randomKeyOrder;

  /// 关闭按钮文字，空则不展示
  final String? closeButtonText;

  /// 删除按钮文字，空则展示删除图标
  final String? deleteButtonText;

  /// 是否将关闭按钮设置为加载中状态，仅在 `theme="custom"` 时有效
  final bool closeButtonLoading;

  /// 样式风格，可选值为 `custom` `normal`
  final FlanNumberKeyboardTheme theme;

  /// 当前输入值
  final String value;

  /// 底部额外按键的内容
  final List<String> extraKey;

  /// 输入值最大长度
  final int? maxlength;

  /// 是否开启过场动画
  // final bool transition;

  /// 是否在点击关闭按钮时触发 `blur` 事件
  final bool blurOnClose;

  /// 是否展示删除图标
  final bool showDeleteKey;

  /// 是否在点击外部时收起键盘
  final bool hideOnClickOutside;

  /// 是否开启底部安全区适配
  final bool safeAreaInsetBottom;

  // ****************** Events ******************

  /// 值变化
  final ValueChanged<String>? onChange;

  /// 点击按键时触发
  final ValueChanged<String>? onInput;

  /// 点击删除键时触发
  final VoidCallback? onDelete;

  /// 点击关闭按钮时触发
  final VoidCallback? onClose;

  /// 点击关闭按钮或非键盘区域时触发
  final VoidCallback? onBlur;

  /// 键盘完全弹出时触发
  final VoidCallback? onShow;

  /// 键盘完全收起时触发
  final VoidCallback? onHide;

  // ****************** Slots ******************
  /// 自定义删除按键内容
  final Widget? deleteSlot;

  /// 自定义左下角按键内容
  final Widget? extraKeySlot;

  /// 自定义标题栏左侧内容
  final Widget? titleLeftSlot;

  @override
  _FlanNumberKeyboardState createState() => _FlanNumberKeyboardState();
}

class _FlanNumberKeyboardState extends State<FlanNumberKeyboard>
    with TickerProviderStateMixin {
  @override
  void initState() {
    if (widget.show) {
      openPopup();
    }
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant FlanNumberKeyboard oldWidget) {
    if (widget.show != oldWidget.show) {
      if (widget.show) {
        openPopup();
      }
      onAnimationEnd();
    }
    super.didUpdateWidget(oldWidget);
  }

  void onAnimationEnd() {
    if (widget.show) {
      widget.onShow?.call();
    } else {
      widget.onHide?.call();
    }
  }

  void openPopup() {
    WidgetsBinding.instance.addPostFrameCallback((Duration timeStamp) {
      showModalBottomSheet<dynamic>(
        context: context,
        builder: _buildContent,
        enableDrag: false,
        barrierColor: Colors.transparent,
        transitionAnimationController: AnimationController(
          duration: ThemeVars.animationDurationBase,
          vsync: this,
        ),
      ).then((dynamic value) {
        blur();
      });
    });
  }

  Widget _buildContent(BuildContext context) {
    final Widget? title = _buildTitle();
    return Container(
      padding: const EdgeInsets.only(bottom: 22.0),
      decoration: BoxDecoration(
        color: ThemeVars.numberKeyboardBackgroundColor,
        borderRadius: title != null
            ? const BorderRadius.vertical(top: Radius.circular(20.0))
            : BorderRadius.zero,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          title ?? const SizedBox.shrink(),
          Padding(
            padding: const EdgeInsets.only(top: 6.0, left: 6.0),
            child: Stack(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Wrap(
                        children: _buildKeys(),
                      ),
                      flex: 3,
                    ),
                    Expanded(flex: isCustom ? 1 : 0, child: const SizedBox())
                  ],
                ),
                _buildSidebar(),
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }

  Widget? _buildTitle() {
    final bool showClose = widget.closeButtonText != null &&
        widget.theme == FlanNumberKeyboardTheme.normal;
    final bool showTitle =
        widget.title != null || showClose || widget.titleLeftSlot != null;
    if (!showTitle) {
      return null;
    }

    return Padding(
      padding: const EdgeInsets.only(top: 6.0),
      child: Stack(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            height: ThemeVars.numberKeyboardTitleHeight,
            child: Text(
              widget.title ?? '',
              style: const TextStyle(
                color: ThemeVars.numberKeyboardTitleColor,
                fontSize: ThemeVars.numberKeyboardTitleFontSize,
              ),
            ),
          ),
          Positioned(
            left: 0.0,
            child: widget.titleLeftSlot ?? const SizedBox.shrink(),
          ),
          Positioned(
            right: 0.0,
            top: 0.0,
            bottom: 0.0,
            child: Visibility(
              visible: showClose,
              child: GestureDetector(
                onTap: close,
                child: Container(
                  padding: ThemeVars.numberKeyboardClosePadding,
                  color: Colors.transparent,
                  alignment: Alignment.center,
                  child: Text(
                    widget.closeButtonText!,
                    style: const TextStyle(
                      fontSize: ThemeVars.numberKeyboardCloseFontSize,
                      color: ThemeVars.numberKeyboardCloseColor,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildKeys() {
    return keys.map((_KeyConfig key) {
      Widget? keySlot;
      if (key.type == FlanKeyType.delete) {
        keySlot = widget.deleteSlot;
      }

      if (key.type == FlanKeyType.extra) {
        keySlot = widget.extraKeySlot;
      }
      return FractionallySizedBox(
        widthFactor: key.wider ? 0.666 : .333,
        child: FlanNumberKeyboardKey(
          child: keySlot,
          key: ValueKey<String>('${key.text}--${key.type}'),
          text: key.text,
          type: key.type,
          wider: key.wider,
          color: key.color,
          onPress: onPress,
        ),
      );
    }).toList();
  }

  bool get isCustom => widget.theme == FlanNumberKeyboardTheme.custom;

  Widget _buildSidebar() {
    if (isCustom) {
      return Positioned(
        top: 0.0,
        bottom: 0.0,
        right: 0.0,
        width: MediaQuery.of(context).size.width * .25,
        child: Column(
          children: <Widget>[
            if (widget.showDeleteKey)
              Expanded(
                child: FlanNumberKeyboardKey(
                  child: widget.deleteSlot,
                  large: true,
                  text: widget.deleteButtonText ?? '',
                  type: FlanKeyType.delete,
                  onPress: onPress,
                ),
              )
            else
              const SizedBox.shrink(),
            Expanded(
              child: FlanNumberKeyboardKey(
                large: true,
                text: widget.closeButtonText ?? '',
                type: FlanKeyType.close,
                color: _ColorTheme.blue,
                loading: widget.closeButtonLoading,
                onPress: onPress,
              ),
            ),
          ],
        ),
      );
    }
    return const SizedBox.shrink();
  }

  void blur() {
    if (widget.show) {
      widget.onBlur?.call();
    }
  }

  void close() {
    widget.onClose?.call();

    if (widget.blurOnClose) {
      blur();
    }
    Navigator.of(context).maybePop();
  }

  void onPress(String text, FlanKeyType type) {
    if (text.isEmpty && type == FlanKeyType.extra) {
      blur();
      Navigator.of(context).maybePop();
      return;
    }
    if (type == FlanKeyType.delete) {
      widget.onDelete?.call();
      widget.onChange?.call(widget.value.substring(0, widget.value.length - 1));
    } else if (type == FlanKeyType.close) {
      close();
    } else if (widget.value.length < (widget.maxlength ?? double.infinity)) {
      widget.onInput?.call(text);

      widget.onChange?.call(widget.value + text);
    }
  }

  List<_KeyConfig> get basicKeys {
    final List<_KeyConfig> keys =
        List<_KeyConfig>.generate(9, (int i) => _KeyConfig(text: '${i + 1}'));
    if (widget.randomKeyOrder) {
      keys.shuffle();
    }
    return keys;
  }

  List<_KeyConfig> get defaultKeys {
    return <_KeyConfig>[
      ...basicKeys,
      _KeyConfig(text: widget.extraKey[0], type: FlanKeyType.extra),
      const _KeyConfig(text: '0'),
      _KeyConfig(
          text: widget.showDeleteKey ? (widget.deleteButtonText ?? '') : '',
          type: widget.showDeleteKey ? FlanKeyType.delete : FlanKeyType.normal),
    ];
  }

  List<_KeyConfig> get customKeys {
    final List<_KeyConfig> keys = basicKeys.toList();
    if (widget.extraKey.length == 1) {
      keys.addAll(<_KeyConfig>[
        const _KeyConfig(text: '0', wider: true),
        _KeyConfig(text: widget.extraKey[0], type: FlanKeyType.extra),
      ]);
    } else {
      keys.addAll(<_KeyConfig>[
        _KeyConfig(text: widget.extraKey[0], type: FlanKeyType.extra),
        const _KeyConfig(text: '0'),
        _KeyConfig(text: widget.extraKey[1], type: FlanKeyType.extra),
      ]);
    }
    return keys;
  }

  List<_KeyConfig> get keys =>
      widget.theme == FlanNumberKeyboardTheme.custom ? customKeys : defaultKeys;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties.add(
        DiagnosticsProperty<bool>('show', widget.show, defaultValue: false));
    properties.add(DiagnosticsProperty<String>('title', widget.title));
    properties.add(DiagnosticsProperty<bool>(
        'randomKeyOrder', widget.randomKeyOrder,
        defaultValue: false));
    properties.add(
        DiagnosticsProperty<String>('closeButtonText', widget.closeButtonText));
    properties.add(DiagnosticsProperty<String>(
        'deleteButtonText', widget.deleteButtonText));
    properties.add(DiagnosticsProperty<FlanNumberKeyboardTheme>(
        'theme', widget.theme,
        defaultValue: FlanNumberKeyboardTheme.normal));
    properties.add(
        DiagnosticsProperty<String>('value', widget.value, defaultValue: ''));
    properties.add(DiagnosticsProperty<List<String>>(
        'extraKey', widget.extraKey,
        defaultValue: const <String>[]));
    properties.add(DiagnosticsProperty<int>('maxlength', widget.maxlength));

    // properties.add(DiagnosticsProperty<bool>('transition', widget.transition,
    //     defaultValue: true));

    properties.add(DiagnosticsProperty<bool>('blurOnClose', widget.blurOnClose,
        defaultValue: true));

    properties.add(DiagnosticsProperty<bool>(
        'showDeleteKey', widget.showDeleteKey,
        defaultValue: true));

    properties.add(DiagnosticsProperty<bool>(
        'hideOnClickOutside', widget.hideOnClickOutside,
        defaultValue: true));
    properties.add(DiagnosticsProperty<bool>(
        'safeAreaInsetBottom', widget.safeAreaInsetBottom,
        defaultValue: true));

    super.debugFillProperties(properties);
  }
}

class _KeyConfig {
  const _KeyConfig({
    required this.text,
    this.type = FlanKeyType.normal,
    this.color = _ColorTheme.normal,
    this.wider = false,
  });
  final String text;
  final FlanKeyType type;
  final _ColorTheme color;
  final bool wider;
}

enum _ColorTheme {
  normal,
  blue,
}

class FlanNumberKeyboardKey extends StatefulWidget {
  const FlanNumberKeyboardKey({
    Key? key,
    this.type = FlanKeyType.normal,
    required this.text,
    this.color = _ColorTheme.normal,
    this.wider = false,
    this.large = false,
    this.loading = false,
    this.onPress,
    this.child,
  }) : super(key: key);

  // ****************** Props ******************
  final FlanKeyType type;
  final String text;
  final _ColorTheme color;
  final bool wider;
  final bool large;
  final bool loading;

  // ****************** Events ******************
  final void Function(String, FlanKeyType)? onPress;

  // ****************** Slots ******************
  final Widget? child;

  @override
  _FlanNumberKeyboardKeyState createState() => _FlanNumberKeyboardKeyState();
}

class _FlanNumberKeyboardKeyState extends State<FlanNumberKeyboardKey> {
  bool active = false;

  void onTouchEnd() {
    setState(() => active = false);
    widget.onPress?.call(widget.text, widget.type);
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        dragStartBehavior: DragStartBehavior.down,
        onTapDown: (TapDownDetails details) {
          setState(() => active = true);
        },
        onTapCancel: onTouchEnd,
        onTapUp: (TapUpDetails details) {
          onTouchEnd();
        },
        child: Container(
          alignment: Alignment.center,
          height: ThemeVars.numberKeyboardKeyHeight,
          margin: const EdgeInsets.only(right: 6.0, bottom: 6.0),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(ThemeVars.borderRadiusLg),
          ),
          child: DefaultTextStyle(
            style: TextStyle(
              fontSize: fontSize,
              color: textColor,
              // height: 1,
            ),
            child: _renderContent(),
          ),
        ),
      ),
    );
  }

  Color get bgColor {
    if (widget.color == _ColorTheme.blue) {
      return active
          ? const Color(0xFF0570DB)
          : ThemeVars.numberKeyboardButtonBackgroundColor;
    }
    return active ? ThemeVars.numberKeyboardKeyActiveColor : ThemeVars.white;
  }

  double get fontSize {
    if (widget.color == _ColorTheme.blue || widget.type == FlanKeyType.delete) {
      return ThemeVars.numberKeyboardDeleteFontSize;
    }
    return ThemeVars.numberKeyboardKeyFontSize;
  }

  Color get textColor {
    if (widget.color == _ColorTheme.blue) {
      return ThemeVars.numberKeyboardButtonTextColor;
    }
    return ThemeVars.textColor;
  }

  Widget _renderContent() {
    if (widget.loading) {
      return const FlanLoading(color: ThemeVars.numberKeyboardButtonTextColor);
    }

    final Widget? text =
        widget.child ?? (widget.text.isNotEmpty ? Text(widget.text) : null);
    switch (widget.type) {
      case FlanKeyType.delete:
        return text ?? kDeleteIcon;
      case FlanKeyType.extra:
        return text ?? kCollapseIcon;
      default:
        return text ?? const SizedBox.shrink();
    }
  }
}

SvgPicture kCollapseIcon = SvgPicture.string(
  '''
   <svg viewBox="0 0 30 24">
    <path
      d="M25.877 12.843h-1.502c-.188 0-.188 0-.188.19v1.512c0 .188 0 .188.188.188h1.5c.187 0 .187 0 .187-.188v-1.511c0-.19 0-.191-.185-.191zM17.999 10.2c0 .188 0 .188.188.188h1.687c.188 0 .188 0 .188-.188V8.688c0-.187.004-.187-.186-.19h-1.69c-.187 0-.187 0-.187.19V10.2zm2.25-3.967h1.5c.188 0 .188 0 .188-.188v-1.7c0-.19 0-.19-.188-.19h-1.5c-.189 0-.189 0-.189.19v1.7c0 .188 0 .188.19.188zm2.063 4.157h3.563c.187 0 .187 0 .187-.189V4.346c0-.19.004-.19-.185-.19h-1.69c-.187 0-.187 0-.187.188v4.155h-1.688c-.187 0-.187 0-.187.189v1.514c0 .19 0 .19.187.19zM14.812 24l2.812-3.4H12l2.813 3.4zm-9-11.157H4.31c-.188 0-.188 0-.188.19v1.512c0 .188 0 .188.188.188h1.502c.187 0 .187 0 .187-.188v-1.511c0-.19.01-.191-.189-.191zm15.937 0H8.25c-.188 0-.188 0-.188.19v1.512c0 .188 0 .188.188.188h13.5c.188 0 .188 0 .188-.188v-1.511c0-.19 0-.191-.188-.191zm-11.438-2.454h1.5c.188 0 .188 0 .188-.188V8.688c0-.187 0-.187-.188-.189h-1.5c-.187 0-.187 0-.187.189V10.2c0 .188 0 .188.187.188zM27.94 0c.563 0 .917.21 1.313.567.518.466.748.757.748 1.51v14.92c0 .567-.188 1.134-.562 1.512-.376.378-.938.566-1.313.566H2.063c-.563 0-.938-.188-1.313-.566-.562-.378-.75-.945-.75-1.511V2.078C0 1.51.188.944.562.567.938.189 1.5 0 1.875 0zm-.062 2H2v14.92h25.877V2zM5.81 4.157c.19 0 .19 0 .19.189v1.762c-.003.126-.024.126-.188.126H4.249c-.126-.003-.126-.023-.126-.188v-1.7c-.187-.19 0-.19.188-.19zm10.5 2.077h1.503c.187 0 .187 0 .187-.188v-1.7c0-.19 0-.19-.187-.19h-1.502c-.188 0-.188.001-.188.19v1.7c0 .188 0 .188.188.188zM7.875 8.5c.187 0 .187.002.187.189V10.2c0 .188 0 .188-.187.188H4.249c-.126-.002-.126-.023-.126-.188V8.625c.003-.126.024-.126.188-.126zm7.875 0c.19.002.19.002.19.189v1.575c-.003.126-.024.126-.19.126h-1.563c-.126-.002-.126-.023-.126-.188V8.625c.002-.126.023-.126.189-.126zm-6-4.342c.187 0 .187 0 .187.189v1.7c0 .188 0 .188-.187.188H8.187c-.126-.003-.126-.023-.126-.188V4.283c.003-.126.024-.126.188-.126zm3.94 0c.185 0 .372 0 .372.189v1.762c-.002.126-.023.126-.187.126h-1.75C12 6.231 12 6.211 12 6.046v-1.7c0-.19.187-.19.187-.19z"
    />
  </svg>''',
  color: ThemeVars.textColor,
);

SvgPicture kDeleteIcon = SvgPicture.string(
  '''
  <svg  viewBox="0 0 32 22">
    <path
      d="M28.016 0A3.991 3.991 0 0132 3.987v14.026c0 2.2-1.787 3.987-3.98 3.987H10.382c-.509 0-.996-.206-1.374-.585L.89 13.09C.33 12.62 0 11.84 0 11.006c0-.86.325-1.62.887-2.08L9.01.585A1.936 1.936 0 0110.383 0zm0 1.947H10.368L2.24 10.28c-.224.226-.312.432-.312.73 0 .287.094.51.312.729l8.128 8.333h17.648a2.041 2.041 0 002.037-2.04V3.987c0-1.127-.915-2.04-2.037-2.04zM23.028 6a.96.96 0 01.678.292.95.95 0 01-.003 1.377l-3.342 3.348 3.326 3.333c.189.188.292.43.292.679 0 .248-.103.49-.292.679a.96.96 0 01-.678.292.959.959 0 01-.677-.292L18.99 12.36l-3.343 3.345a.96.96 0 01-.677.292.96.96 0 01-.678-.292.962.962 0 01-.292-.68c0-.248.104-.49.292-.679l3.342-3.348-3.342-3.348A.963.963 0 0114 6.971c0-.248.104-.49.292-.679A.96.96 0 0114.97 6a.96.96 0 01.677.292l3.358 3.348 3.345-3.348A.96.96 0 0123.028 6z"
    />
  </svg>''',
  color: ThemeVars.textColor,
);

/// 样式风格
enum FlanNumberKeyboardTheme {
  normal,
  custom,
}

/// 按键类型
enum FlanKeyType {
  normal,
  delete,
  extra,
  close,
}
