// 🐦 Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'components/badge_theme.dart';
import 'components/button_theme.dart';
import 'components/cell_group_theme.dart';
import 'components/cell_theme.dart';
import 'components/circle_theme.dart';
import 'components/collapse_theme.dart';
import 'components/contact_card_theme.dart';
import 'components/count_down_theme.dart';
import 'components/divider_theme.dart';
import 'components/empty_theme.dart';
import 'components/image_theme.dart';
import 'components/loading_theme.dart';
import 'components/nav_bar_theme.dart';
import 'components/notice_bar_theme.dart';
import 'components/progress_theme.dart';
import 'components/tabbar_theme.dart';
import 'components/tag_theme.dart';

class FlanTheme extends StatelessWidget {
  const FlanTheme({
    Key? key,
    required this.data,
    required this.child,
  }) : super(key: key);

  final FlanThemeData data;

  final Widget child;

  static double Function(num n) rpx = (num n) => n.toDouble();

  static final FlanThemeData _kFallbackTheme = FlanThemeData.fallback();

  static FlanThemeData of(BuildContext context) {
    final _InheritedFlanTheme? inheritedTheme =
        context.dependOnInheritedWidgetOfExactType<_InheritedFlanTheme>();

    return inheritedTheme?.theme.data ?? _kFallbackTheme;
  }

  @override
  Widget build(BuildContext context) {
    return _InheritedFlanTheme(
      theme: this,
      child: child,
    );
  }
}

class _InheritedFlanTheme extends InheritedTheme {
  const _InheritedFlanTheme({
    Key? key,
    required this.theme,
    required Widget child,
  }) : super(key: key, child: child);

  final FlanTheme theme;

  @override
  Widget wrap(BuildContext context, Widget child) {
    return FlanTheme(data: theme.data, child: child);
  }

  @override
  bool updateShouldNotify(_InheritedFlanTheme old) =>
      theme.data != old.theme.data;
}

@immutable
class FlanThemeData with Diagnosticable {
  factory FlanThemeData({
    FlanBadgeThemeData? badgeTheme,
    FlanButtonThemeData? buttonTheme,
    FlanCellThemeData? cellTheme,
    FlanCellGroupThemeData? cellGroupTheme,
    FlanCircleThemeData? circleTheme,
    FlanCollapseThemeData? collapseTheme,
    FlanCountDownThemeData? countDownTheme,
    FlanContactCardThemeData? contactCardTheme,
    FlanDividerThemeData? dividerTheme,
    FlanEmptyThemeData? emptyTheme,
    FlanImageThemeData? imageTheme,
    FlanProgressThemeData? progressTheme,
    FlanTagThemeData? tagTheme,
    FlanTabbarThemeData? tabbarTheme,
    FlanLoadingThemeData? loadingTheme,
    FlanNavBarThemeData? navBarTheme,
    FlanNoticeBarThemeData? noticeBarTheme,
  }) {
    return FlanThemeData.raw(
      badgeTheme: badgeTheme ?? FlanBadgeThemeData(),
      buttonTheme: buttonTheme ?? FlanButtonThemeData(),
      cellTheme: cellTheme ?? FlanCellThemeData(),
      cellGroupTheme: cellGroupTheme ?? FlanCellGroupThemeData(),
      circleTheme: circleTheme ?? FlanCircleThemeData(),
      collapseTheme: collapseTheme ?? FlanCollapseThemeData(),
      countDownTheme: countDownTheme ?? FlanCountDownThemeData(),
      contactCardTheme: contactCardTheme ?? FlanContactCardThemeData(),
      dividerTheme: dividerTheme ?? FlanDividerThemeData(),
      emptyTheme: emptyTheme ?? FlanEmptyThemeData(),
      imageTheme: imageTheme ?? FlanImageThemeData(),
      progressTheme: progressTheme ?? FlanProgressThemeData(),
      tagTheme: tagTheme ?? FlanTagThemeData(),
      tabbarTheme: tabbarTheme ?? FlanTabbarThemeData(),
      loadingTheme: loadingTheme ?? FlanLoadingThemeData(),
      navBarTheme: navBarTheme ?? FlanNavBarThemeData(),
      noticeBarTheme: noticeBarTheme ?? FlanNoticeBarThemeData(),
    );
  }

  const FlanThemeData.raw({
    required this.badgeTheme,
    required this.buttonTheme,
    required this.cellTheme,
    required this.cellGroupTheme,
    required this.circleTheme,
    required this.collapseTheme,
    required this.countDownTheme,
    required this.contactCardTheme,
    required this.dividerTheme,
    required this.emptyTheme,
    required this.imageTheme,
    required this.progressTheme,
    required this.tagTheme,
    required this.tabbarTheme,
    required this.loadingTheme,
    required this.navBarTheme,
    required this.noticeBarTheme,
  });

  factory FlanThemeData.fallback() => FlanThemeData();

  /// Badge 徽标
  final FlanBadgeThemeData badgeTheme;

  /// Button 按钮
  final FlanButtonThemeData buttonTheme;

  /// ContactCard 联系人卡片
  final FlanContactCardThemeData contactCardTheme;

  /// Cell 单元格
  final FlanCellThemeData cellTheme;

  /// CellGroup 单元格组
  final FlanCellGroupThemeData cellGroupTheme;

  /// Circle 环形进度条
  final FlanCircleThemeData circleTheme;

  /// Collapse 折叠面板
  final FlanCollapseThemeData collapseTheme;

  /// CountDown 倒计时
  final FlanCountDownThemeData countDownTheme;

  /// Empty 空状态
  final FlanEmptyThemeData emptyTheme;

  /// Divider 分割线
  final FlanDividerThemeData dividerTheme;

  /// Image 图片
  final FlanImageThemeData imageTheme;

  /// Loading 加载
  final FlanLoadingThemeData loadingTheme;

  /// NavBar 导航栏
  final FlanNavBarThemeData navBarTheme;

  /// NoticeBar 通知栏
  final FlanNoticeBarThemeData noticeBarTheme;

  /// Progress 进度条
  final FlanProgressThemeData progressTheme;

  // Tabbar 标签栏
  final FlanTabbarThemeData tabbarTheme;

  // Tag 标签
  final FlanTagThemeData tagTheme;

  static FlanThemeData lerp(FlanThemeData a, FlanThemeData b, double t) {
    return FlanThemeData.raw(
      badgeTheme: FlanBadgeThemeData.lerp(a.badgeTheme, b.badgeTheme, t),
      buttonTheme: FlanButtonThemeData.lerp(a.buttonTheme, b.buttonTheme, t),
      cellTheme: FlanCellThemeData.lerp(a.cellTheme, b.cellTheme, t),
      cellGroupTheme:
          FlanCellGroupThemeData.lerp(a.cellGroupTheme, b.cellGroupTheme, t),
      circleTheme: FlanCircleThemeData.lerp(a.circleTheme, b.circleTheme, t),
      collapseTheme:
          FlanCollapseThemeData.lerp(a.collapseTheme, b.collapseTheme, t),
      contactCardTheme: FlanContactCardThemeData.lerp(
          a.contactCardTheme, b.contactCardTheme, t),
      countDownTheme:
          FlanCountDownThemeData.lerp(a.countDownTheme, b.countDownTheme, t),
      dividerTheme:
          FlanDividerThemeData.lerp(a.dividerTheme, b.dividerTheme, t),
      emptyTheme: FlanEmptyThemeData.lerp(a.emptyTheme, b.emptyTheme, t),
      imageTheme: FlanImageThemeData.lerp(a.imageTheme, b.imageTheme, t),
      progressTheme:
          FlanProgressThemeData.lerp(a.progressTheme, b.progressTheme, t),
      tagTheme: FlanTagThemeData.lerp(a.tagTheme, b.tagTheme, t),
      tabbarTheme: FlanTabbarThemeData.lerp(a.tabbarTheme, b.tabbarTheme, t),
      loadingTheme:
          FlanLoadingThemeData.lerp(a.loadingTheme, b.loadingTheme, t),
      navBarTheme: FlanNavBarThemeData.lerp(a.navBarTheme, b.navBarTheme, t),
      noticeBarTheme:
          FlanNoticeBarThemeData.lerp(a.noticeBarTheme, b.noticeBarTheme, t),
    );
  }

  @override
  int get hashCode {
    final List<Object?> values = <Object?>[];
    return hashList(values);
  }

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) {
      return false;
    }

    return other is FlanThemeData && other.buttonTheme == buttonTheme;
  }
}

class FlanThemeDataTween extends Tween<FlanThemeData> {
  FlanThemeDataTween({FlanThemeData? begin, FlanThemeData? end})
      : super(begin: begin, end: end);

  @override
  FlanThemeData lerp(double t) => FlanThemeData.lerp(begin!, end!, t);
}

class FlanAnimatedTheme extends ImplicitlyAnimatedWidget {
  const FlanAnimatedTheme({
    Key? key,
    required this.data,
    Curve curve = Curves.linear,
    Duration duration = kThemeAnimationDuration,
    VoidCallback? onEnd,
    required this.child,
  }) : super(key: key, curve: curve, duration: duration, onEnd: onEnd);

  final FlanThemeData data;

  final Widget child;

  @override
  _AnimatedThemeState createState() => _AnimatedThemeState();
}

class _AnimatedThemeState extends AnimatedWidgetBaseState<AnimatedTheme> {
  FlanThemeDataTween? _data;

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    _data = visitor(
            _data,
            widget.data,
            (dynamic value) =>
                FlanThemeDataTween(begin: value as FlanThemeData))!
        as FlanThemeDataTween;
  }

  @override
  Widget build(BuildContext context) {
    return FlanTheme(
      child: widget.child,
      data: _data!.evaluate(animation),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder description) {
    super.debugFillProperties(description);
    description.add(DiagnosticsProperty<FlanThemeDataTween>('data', _data,
        showName: false, defaultValue: null));
  }
}
