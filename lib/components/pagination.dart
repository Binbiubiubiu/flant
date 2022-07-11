import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../locale/l10n.dart';
import '../styles/components/pagination_theme.dart';
import '../styles/var.dart';
import '../utils/widget.dart';
import 'common/active_response.dart';
import 'style.dart' show FlanHairLine;

/// Pagination 分页
class FlanPagination extends StatefulWidget {
  const FlanPagination({
    Key? key,
    required this.value,
    this.mode = FlanPaginationMode.multi,
    this.prevText,
    this.nextText,
    this.pageCount = 0,
    this.totalItems = 0,
    this.itemsPerPage = 10,
    this.showPageSize = 5,
    this.forceEllipses = false,
    required this.onChange,
    this.pageBuilder,
    this.prevTextSlot,
    this.nextTextSlot,
    this.pageDescSlot,
  }) : super(key: key);

  // ****************** Props ******************
  /// 当前页码
  final int value;

  /// 显示模式，可选值为 `simple` `multi`
  final FlanPaginationMode mode;

  /// 上一页按钮文字
  final String? prevText;

  /// 下一页按钮文字
  final String? nextText;

  /// 总页数
  final int pageCount;

  /// 总记录数
  final int totalItems;

  /// 每页记录数
  final int itemsPerPage;

  /// 显示的页码个数
  final int showPageSize;

  /// 是否显示省略号
  final bool forceEllipses;

  // ****************** Events ******************
  /// 页码改变时触发
  final ValueChanged<int> onChange;

  // ****************** Slots ******************
  /// 自定义页码
  final Widget Function(PageItem pageItem)? pageBuilder;

  /// 自定义上一页按钮文字
  final Widget? prevTextSlot;

  /// 自定义下一页按钮文字
  final Widget? nextTextSlot;

  /// 描述
  final Widget? pageDescSlot;

  @override
  _FlanPaginationState createState() => _FlanPaginationState();
}

class _FlanPaginationState extends State<FlanPagination> {
  @override
  void initState() {
    nextTick(() {
      select(widget.value);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final FlanPaginationThemeData themeData = FlanPaginationTheme.of(context);

    return DefaultTextStyle(
      style: TextStyle(
        fontSize: themeData.fontSize,
      ),
      child: Row(
        children: <Widget>[
          _PaginationItem(
            isPreOrNext: true,
            disabled: widget.value == 1,
            onClick: () => select(widget.value - 1),
            isLast: widget.mode == FlanPaginationMode.simple,
            child: widget.prevTextSlot ??
                Text(widget.prevText ?? FlanS.of(context).Pagination_prev),
          ),
          ...pages
              .map((PageItem e) => _PaginationItem(
                    active: e.active,
                    onClick: () => select(e.number),
                    child: widget.pageBuilder != null
                        ? widget.pageBuilder!(e)
                        : Text(e.text),
                  ))
              .toList(),
          _buildDesc(themeData),
          _PaginationItem(
            isPreOrNext: true,
            disabled: widget.value == count,
            isLast: true,
            onClick: () => select(widget.value + 1),
            child: widget.nextTextSlot ??
                Text(widget.nextText ?? FlanS.of(context).Pagination_next),
          ),
        ],
      ),
    );
  }

  Widget _buildDesc(FlanPaginationThemeData themeData) {
    if (widget.mode != FlanPaginationMode.multi) {
      return Expanded(
        child: Container(
          height: themeData.height,
          alignment: Alignment.center,
          child: DefaultTextStyle(
            style: TextStyle(
              color: themeData.descColor,
            ),
            child: widget.pageDescSlot ?? Text('${widget.value}/$count'),
          ),
        ),
      );
    }
    return const SizedBox.shrink();
  }

  void select(int page) {
    page = math.min(count, math.max(1, page));
    if (widget.value != page) {
      widget.onChange(page);
    }
  }

  int get count {
    final int count = widget.pageCount > 0
        ? widget.pageCount
        : (widget.totalItems / widget.itemsPerPage).ceil();
    return math.max(1, count);
  }

  List<PageItem> get pages {
    final List<PageItem> items = <PageItem>[];
    final int pageCount = count;
    final int showPageSize = widget.showPageSize;
    if (widget.mode != FlanPaginationMode.multi) {
      return items;
    }
    // Default page limits
    int startPage = 1;
    int endPage = pageCount;
    final bool isMaxSized = showPageSize < pageCount;
    // recompute if showPageSize
    if (isMaxSized) {
      // Current page is displayed in the middle of the visible ones
      startPage = math.max(widget.value - (showPageSize / 2).floor(), 1);
      endPage = startPage + showPageSize - 1;

      // Adjust if limit is exceeded
      if (endPage > pageCount) {
        endPage = pageCount;
        startPage = endPage - showPageSize + 1;
      }
    }

    // Add page number links
    for (int number = startPage; number <= endPage; number++) {
      final PageItem page =
          makePage(number, '$number', active: number == widget.value);
      items.add(page);
    }

    // Add links to move between page sets
    if (isMaxSized && showPageSize > 0 && widget.forceEllipses) {
      if (startPage > 1) {
        final PageItem prevPages = makePage(startPage - 1, '...');
        items.insert(0, prevPages);
      }

      if (endPage < pageCount) {
        final PageItem nextPages = makePage(endPage + 1, '...');
        items.add(nextPages);
      }
    }

    return items;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties.add(DiagnosticsProperty<int>('value', widget.value));
    properties.add(DiagnosticsProperty<FlanPaginationMode>('mode', widget.mode,
        defaultValue: FlanPaginationMode.multi));
    properties.add(DiagnosticsProperty<String>('preText', widget.prevText));
    properties.add(DiagnosticsProperty<String>('nextText', widget.nextText));
    properties.add(DiagnosticsProperty<int>('pageCount', widget.pageCount,
        defaultValue: 0));
    properties.add(DiagnosticsProperty<int>('totalItems', widget.totalItems,
        defaultValue: 0));
    properties.add(DiagnosticsProperty<int>('itemsPerPage', widget.itemsPerPage,
        defaultValue: 10));
    properties.add(DiagnosticsProperty<int>('showPageSize', widget.showPageSize,
        defaultValue: 5));
    properties.add(DiagnosticsProperty<bool>(
        'forceEllipses', widget.forceEllipses,
        defaultValue: false));

    super.debugFillProperties(properties);
  }
}

/// 显示模式
enum FlanPaginationMode {
  simple,
  multi,
}

class PageItem {
  PageItem(
    this.text,
    this.number,
    this.active,
  );

  String text;
  int number;
  bool active;
}

PageItem makePage(int number, String text, {bool active = false}) {
  return PageItem(text, number, active);
}

class _PaginationItem extends StatelessWidget {
  const _PaginationItem({
    Key? key,
    this.active = false,
    this.isPreOrNext = false,
    this.isLast = false,
    this.disabled = false,
    this.onClick,
    this.child,
  }) : super(key: key);

  final bool active;
  final bool isPreOrNext;
  final bool isLast;
  final bool disabled;

  final VoidCallback? onClick;

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final FlanPaginationThemeData themeData = FlanPaginationTheme.of(context);

    const BorderSide borderSide = FlanHairLine();

    return Expanded(
      flex: isPreOrNext ? 1 : 0,
      child: Opacity(
        opacity: disabled ? themeData.disabledOpacity : 1.0,
        child: FlanActiveResponse(
          disabled: disabled,
          builder: (BuildContext contenxt, bool isPressed, Widget? child) {
            final bool _active = isPressed || active;

            final Color bgColor = disabled
                ? themeData.itemDisabledBackgroundColor
                : _active
                    ? themeData.itemDefaultColor
                    : themeData.backgroundColor;

            final Color textColor = disabled
                ? themeData.itemDefaultColor
                : _active
                    ? FlanThemeVars.white
                    : themeData.itemDefaultColor;

            return IconTheme(
              data: IconThemeData(
                color: textColor,
                size: themeData.fontSize,
              ),
              child: DefaultTextStyle(
                style: TextStyle(color: textColor),
                child: DecoratedBox(
                  decoration: BoxDecoration(color: bgColor),
                  child: child,
                ),
              ),
            );
          },
          onClick: onClick,
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                top: borderSide,
                bottom: borderSide,
                left: borderSide,
                right: borderSide.copyWith(
                  width: isLast ? 1.0 : 0.0,
                ),
              ),
            ),
            padding: EdgeInsets.symmetric(
              horizontal: isPreOrNext ? FlanThemeVars.paddingBase.rpx : 0.0,
            ),
            height: themeData.height,
            constraints: BoxConstraints(
              minWidth: themeData.itemWidth,
            ),
            alignment: Alignment.center,
            child: child,
          ),
        ),
      ),
    );
  }
}
