// 🐦 Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// 🌎 Project imports:
import '../styles/components/card_theme.dart';
import '../styles/theme.dart';
import '../styles/var.dart';
import '../utils/widget.dart';
import 'image.dart';
import 'tag.dart';

/// ### FlanCard 卡片
/// 商品卡片，用于展示商品的图片、价格等信息。
class FlanCard extends StatelessWidget {
  const FlanCard({
    Key? key,
    this.thumb = '',
    this.title = '',
    this.desc = '',
    this.tag = '',
    this.num = '',
    this.price = '',
    this.originPrice = '',
    this.centered = false,
    this.currency = '¥',
    this.thumbLink,
    this.onClickThumb,
    this.titleSlot,
    this.descSlot,
    this.numSlot,
    this.priceSlot,
    this.originPriceSlot,
    this.priceTopSlot,
    this.bottomSlot,
    this.thumbSlot,
    this.tagSlot,
    this.tagsSlot,
    this.footerSlot,
  }) : super(key: key);

  // ****************** Props ******************
  /// 左侧图片 URL
  final String thumb;

  /// 标题
  final String title;

  /// 描述
  final String desc;

  /// 图片角标
  final String tag;

  /// 商品数量
  final String num;

  /// 商品价格
  final String price;

  /// price
  final String originPrice;

  /// 内容是否垂直居中
  final bool centered;

  /// 货币符号
  final String currency;

  /// 点击左侧图片后跳转的链接地址
  final String? thumbLink;

  // /// 是否开启图片懒加载，
  // final bool lazyLoad;

  // ****************** Events ******************

  /// 点击自定义图片时触发
  final VoidCallback? onClickThumb;

  // ****************** Slots ******************
  /// 自定义标题
  final Widget? titleSlot;

  /// 自定义描述
  final Widget? descSlot;

  /// 自定义数量
  final Widget? numSlot;

  /// 自定义价格
  final Widget? priceSlot;

  /// 	自定义商品原价
  final Widget? originPriceSlot;

  /// 自定义价格上方区域
  final Widget? priceTopSlot;

  /// 自定义价格下方区域
  final Widget? bottomSlot;

  /// 自定义图片
  final Widget? thumbSlot;

  /// 自定义图片角标
  final Widget? tagSlot;

  /// 自定义描述下方标签区域
  final Widget? tagsSlot;

  /// 自定义右下角内容
  final List<Widget>? footerSlot;
  @override
  Widget build(BuildContext context) {
    final FlanCardThemeData themeData = FlanTheme.of(context).cardTheme;
    return Container(
      padding: themeData.padding,
      color: themeData.backgroundColor,
      child: DefaultTextStyle(
        style: TextStyle(
          color: themeData.textColor,
          fontSize: themeData.fontSize,
        ),
        child: Column(
          children: <Widget?>[
            Row(
              children: <Widget?>[
                _buildThumb(themeData),
                Expanded(
                  child: Container(
                    constraints: BoxConstraints(
                      minWidth: 0.0,
                      minHeight: themeData.thumbSize,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget?>[
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget?>[
                            _buildTitle(themeData),
                            _buildDesc(themeData),
                            SizedBox(height: 2.0.rpx),
                            tagsSlot,
                          ].noNull,
                        ),
                        _buildBottom(themeData),
                      ].noNull,
                    ),
                  ),
                ),
              ].noNull,
            ),
            _buildFooter(),
          ].noNull,
        ),
      ),
    );
  }

  bool get _showNum => numSlot != null || num.isNotEmpty;
  bool get _showPrice => priceSlot != null || price.isNotEmpty;
  bool get _showOriginPrice =>
      originPriceSlot != null || originPrice.isNotEmpty;
  bool get _showBottom =>
      _showNum || _showPrice || _showOriginPrice || bottomSlot != null;

  Widget _buildPrice(FlanCardThemeData themeData) {
    if (_showPrice) {
      return DefaultTextStyle(
        style: TextStyle(
          color: themeData.priceColor,
          fontSize: themeData.priceFontSize,
          fontWeight: FlanThemeVars.fontWeightBold,
        ),
        child: priceSlot ?? _buildPriceText(themeData),
      );
    }
    return const SizedBox.shrink();
  }

  Widget? _buildOriginPrice(FlanCardThemeData themeData) {
    if (_showOriginPrice) {
      return Padding(
        padding: EdgeInsets.only(left: 5.0.rpx),
        child: DefaultTextStyle(
          style: TextStyle(
            color: themeData.originPriceColor,
            fontSize: themeData.originPriceFontSize,
            decoration: TextDecoration.lineThrough,
          ),
          child: originPriceSlot ?? Text('$currency $originPrice'),
        ),
      );
    }
  }

  Widget _buildNumber(FlanCardThemeData themeData) {
    if (_showNum) {
      return DefaultTextStyle(
        style: TextStyle(
          color: themeData.numColor,
        ),
        child: numSlot ?? Text('x$num'),
      );
    }
    return const SizedBox.shrink();
  }

  Widget? _buildBottom(FlanCardThemeData themeData) {
    if (_showBottom) {
      return Row(
        children: <Widget>[
          Expanded(
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: <Widget?>[
                priceTopSlot,
                _buildPrice(themeData),
                _buildOriginPrice(themeData),
                bottomSlot,
              ].noNull,
            ),
          ),
          _buildNumber(themeData)
        ],
      );
    }
  }

  Widget _buildPriceText(FlanCardThemeData themeData) {
    final List<String> priceArr = price.split('.');
    return Text.rich(
      TextSpan(children: <InlineSpan>[
        TextSpan(text: currency),
        TextSpan(
          text: priceArr.elementAt(0),
          style: TextStyle(
            fontSize: themeData.priceIntegerFontSize,
          ),
        ),
        TextSpan(text: '.${priceArr.elementAt(1)}'),
      ]),
    );
  }

  Widget _buildTitle(FlanCardThemeData themeData) {
    if (titleSlot != null) {
      return titleSlot!;
    }

    return ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 32.0),
      child: Text(
        title,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          fontWeight: FlanThemeVars.fontWeightBold,
          // height: themeData.titleLineHeight,
        ),
      ),
    );
  }

  Widget? _buildDesc(FlanCardThemeData themeData) {
    if (descSlot != null) {
      return descSlot!;
    }
    if (desc.isNotEmpty) {
      return Text(
        desc,
        style: TextStyle(
          color: themeData.descColor,
          // height: themeData.descLineHeight ,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      );
    }
  }

  Widget? _buildThumbTag() {
    if (tagSlot != null || tag.isNotEmpty) {
      return Positioned(
        top: 2.0,
        left: 0.0,
        child: tagSlot ??
            FlanTag(
              mark: true,
              type: FlanTagType.danger,
              child: Text(tag),
            ),
      );
    }
  }

  Widget _bulidThumbImage(FlanCardThemeData themeData) {
    if (thumbSlot != null) {
      return thumbSlot!;
    }

    return FlanImage(
      src: thumb,
      fit: BoxFit.cover,
      width: themeData.thumbSize,
      height: themeData.thumbSize,
      radius: themeData.thumbBorderRadius,
    );
  }

  Widget? _buildThumb(FlanCardThemeData themeData) {
    if (thumbSlot != null || thumb.isNotEmpty) {
      return GestureDetector(
        onTap: () {
          if (onClickThumb != null) {
            onClickThumb!();
          }
        },
        child: Stack(
          children: <Widget?>[
            _bulidThumbImage(themeData),
            _buildThumbTag(),
          ].noNull,
        ),
      );
    }
  }

  Widget? _buildFooter() {
    if (footerSlot != null) {
      return SizedBox(
        width: double.infinity,
        child: Wrap(
          spacing: 5.0,
          alignment: WrapAlignment.end,
          children: footerSlot!,
        ),
      );
    }
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
        .add(DiagnosticsProperty<String>('thumb', thumb, defaultValue: ''));
    properties
        .add(DiagnosticsProperty<String>('title', title, defaultValue: ''));
    properties.add(DiagnosticsProperty<String>('desc', desc, defaultValue: ''));
    properties.add(DiagnosticsProperty<String>('tag', tag, defaultValue: ''));
    properties.add(DiagnosticsProperty<String>('num', num, defaultValue: ''));
    properties
        .add(DiagnosticsProperty<String>('price', price, defaultValue: ''));
    properties.add(DiagnosticsProperty<String>('originPrice', originPrice,
        defaultValue: ''));
    properties.add(
        DiagnosticsProperty<bool>('centered', centered, defaultValue: false));
    properties.add(
        DiagnosticsProperty<String>('currency', currency, defaultValue: '¥'));

    properties.add(DiagnosticsProperty<String>('thumbLink', thumbLink));

    super.debugFillProperties(properties);
  }
}
