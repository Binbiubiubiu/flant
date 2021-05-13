// 🐦 Flutter imports:
import 'package:flant/styles/components/action_bar_theme.dart';
import 'package:flant/styles/components/card_theme.dart';
import 'package:flant/styles/components/pagination_theme.dart';
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
import 'components/field_theme.dart';
import 'components/empty_theme.dart';
import 'components/image_theme.dart';
import 'components/loading_theme.dart';
import 'components/nav_bar_theme.dart';
import 'components/notice_bar_theme.dart';
import 'components/progress_theme.dart';
import 'components/sidebar_theme.dart';
import 'components/skeleton_theme.dart';
import 'components/submit_bar_theme.dart';
import 'components/switch_theme.dart';
import 'components/tabbar_theme.dart';
import 'components/tag_theme.dart';
import 'components/tree_select_theme.dart';

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
    FlanActionBarThemeData? actionBarTheme,
    FlanBadgeThemeData? badgeTheme,
    FlanButtonThemeData? buttonTheme,
    FlanCardThemeData? cardTheme,
    FlanCellThemeData? cellTheme,
    FlanCellGroupThemeData? cellGroupTheme,
    FlanCircleThemeData? circleTheme,
    FlanCollapseThemeData? collapseTheme,
    FlanCountDownThemeData? countDownTheme,
    FlanContactCardThemeData? contactCardTheme,
    FlanDividerThemeData? dividerTheme,
    FlanFieldThemeData? fieldTheme,
    FlanEmptyThemeData? emptyTheme,
    FlanImageThemeData? imageTheme,
    FlanPaginationThemeData? paginationTheme,
    FlanProgressThemeData? progressTheme,
    FlanTagThemeData? tagTheme,
    FlanTabbarThemeData? tabbarTheme,
    FlanTreeSelectThemeData? treeSelectTheme,
    FlanSidebarThemeData? sidebarTheme,
    FlanSkeletonThemeData? skeletonTheme,
    FlanSubmitBarThemeData? submitBarTheme,
    FlanSwitchThemeData? switchTheme,
    FlanLoadingThemeData? loadingTheme,
    FlanNavBarThemeData? navBarTheme,
    FlanNoticeBarThemeData? noticeBarTheme,
  }) {
    return FlanThemeData.raw(
      actionBarTheme: actionBarTheme ?? FlanActionBarThemeData(),
      badgeTheme: badgeTheme ?? FlanBadgeThemeData(),
      buttonTheme: buttonTheme ?? FlanButtonThemeData(),
      cardTheme: cardTheme ?? FlanCardThemeData(),
      cellTheme: cellTheme ?? FlanCellThemeData(),
      cellGroupTheme: cellGroupTheme ?? FlanCellGroupThemeData(),
      circleTheme: circleTheme ?? FlanCircleThemeData(),
      collapseTheme: collapseTheme ?? FlanCollapseThemeData(),
      countDownTheme: countDownTheme ?? FlanCountDownThemeData(),
      contactCardTheme: contactCardTheme ?? FlanContactCardThemeData(),
      dividerTheme: dividerTheme ?? FlanDividerThemeData(),
      emptyTheme: emptyTheme ?? FlanEmptyThemeData(),
      fieldTheme: fieldTheme ?? FlanFieldThemeData(),
      imageTheme: imageTheme ?? FlanImageThemeData(),
      paginationTheme: paginationTheme ?? FlanPaginationThemeData(),
      progressTheme: progressTheme ?? FlanProgressThemeData(),
      tagTheme: tagTheme ?? FlanTagThemeData(),
      tabbarTheme: tabbarTheme ?? FlanTabbarThemeData(),
      treeSelectTheme: treeSelectTheme ?? FlanTreeSelectThemeData(),
      sidebarTheme: sidebarTheme ?? FlanSidebarThemeData(),
      skeletonTheme: skeletonTheme ?? FlanSkeletonThemeData(),
      switchTheme: switchTheme ?? FlanSwitchThemeData(),
      loadingTheme: loadingTheme ?? FlanLoadingThemeData(),
      navBarTheme: navBarTheme ?? FlanNavBarThemeData(),
      submitBarTheme: submitBarTheme ?? FlanSubmitBarThemeData(),
      noticeBarTheme: noticeBarTheme ?? FlanNoticeBarThemeData(),
    );
  }

  const FlanThemeData.raw({
    required this.actionBarTheme,
    required this.badgeTheme,
    required this.buttonTheme,
    required this.cardTheme,
    required this.cellTheme,
    required this.cellGroupTheme,
    required this.circleTheme,
    required this.collapseTheme,
    required this.countDownTheme,
    required this.contactCardTheme,
    required this.dividerTheme,
    required this.fieldTheme,
    required this.emptyTheme,
    required this.imageTheme,
    required this.paginationTheme,
    required this.progressTheme,
    required this.tagTheme,
    required this.tabbarTheme,
    required this.treeSelectTheme,
    required this.sidebarTheme,
    required this.skeletonTheme,
    required this.switchTheme,
    required this.submitBarTheme,
    required this.loadingTheme,
    required this.navBarTheme,
    required this.noticeBarTheme,
  });

  factory FlanThemeData.fallback() => FlanThemeData();

  /// ActionBar 动作栏
  final FlanActionBarThemeData actionBarTheme;

  /// Badge 徽标
  final FlanBadgeThemeData badgeTheme;

  /// Button 按钮
  final FlanButtonThemeData buttonTheme;

  /// Card 卡片
  final FlanCardThemeData cardTheme;

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

  /// Field 输入框
  final FlanFieldThemeData fieldTheme;

  /// Image 图片
  final FlanImageThemeData imageTheme;

  /// Loading 加载
  final FlanLoadingThemeData loadingTheme;

  /// NavBar 导航栏
  final FlanNavBarThemeData navBarTheme;

  /// NoticeBar 通知栏
  final FlanNoticeBarThemeData noticeBarTheme;

  /// Progress 进度条
  final FlanPaginationThemeData paginationTheme;

  /// Progress 进度条
  final FlanProgressThemeData progressTheme;

  /// Tabbar 标签栏
  final FlanSidebarThemeData sidebarTheme;

  /// Skeleton 骨架屏
  final FlanSkeletonThemeData skeletonTheme;

  /// SubmitBar 提交订单栏
  final FlanSubmitBarThemeData submitBarTheme;

  ///  Switch 开关
  final FlanSwitchThemeData switchTheme;

  /// Tabbar 标签栏
  final FlanTabbarThemeData tabbarTheme;

  /// TreeSelect 分类选择
  final FlanTreeSelectThemeData treeSelectTheme;

  /// Tag 标签
  final FlanTagThemeData tagTheme;

  static FlanThemeData lerp(FlanThemeData a, FlanThemeData b, double t) {
    return FlanThemeData.raw(
      actionBarTheme:
          FlanActionBarThemeData.lerp(a.actionBarTheme, b.actionBarTheme, t),
      badgeTheme: FlanBadgeThemeData.lerp(a.badgeTheme, b.badgeTheme, t),
      buttonTheme: FlanButtonThemeData.lerp(a.buttonTheme, b.buttonTheme, t),
      cardTheme: FlanCardThemeData.lerp(a.cardTheme, b.cardTheme, t),
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
      fieldTheme: FlanFieldThemeData.lerp(a.fieldTheme, b.fieldTheme, t),
      emptyTheme: FlanEmptyThemeData.lerp(a.emptyTheme, b.emptyTheme, t),
      imageTheme: FlanImageThemeData.lerp(a.imageTheme, b.imageTheme, t),
      paginationTheme:
          FlanPaginationThemeData.lerp(a.paginationTheme, b.paginationTheme, t),
      progressTheme:
          FlanProgressThemeData.lerp(a.progressTheme, b.progressTheme, t),
      tagTheme: FlanTagThemeData.lerp(a.tagTheme, b.tagTheme, t),
      tabbarTheme: FlanTabbarThemeData.lerp(a.tabbarTheme, b.tabbarTheme, t),
      sidebarTheme:
          FlanSidebarThemeData.lerp(a.sidebarTheme, b.sidebarTheme, t),
      skeletonTheme:
          FlanSkeletonThemeData.lerp(a.skeletonTheme, b.skeletonTheme, t),
      submitBarTheme:
          FlanSubmitBarThemeData.lerp(a.submitBarTheme, b.submitBarTheme, t),
      switchTheme: FlanSwitchThemeData.lerp(a.switchTheme, b.switchTheme, t),
      treeSelectTheme:
          FlanTreeSelectThemeData.lerp(a.treeSelectTheme, b.treeSelectTheme, t),
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
