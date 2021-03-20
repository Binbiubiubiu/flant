import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import '../styles/var.dart';
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
    this.number = '',
    this.price = '',
    this.originPrice = '',
    this.centered = false,
    this.currency = '¥',
    this.thumbLink,
    this.onClick,
    this.onClickThumb,
    this.titleSlot,
    this.descSlot,
    this.numberSlot,
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
  final String number;

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

  /// 点击时触发
  final VoidCallback? onClick;

  /// 点击自定义图片时触发
  final VoidCallback? onClickThumb;

  // ****************** Slots ******************
  /// 自定义标题
  final Widget? titleSlot;

  /// 自定义描述
  final Widget? descSlot;

  /// 自定义数量
  final Widget? numberSlot;

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
    return Container(
      padding: ThemeVars.cardPadding,
      color: ThemeVars.cardBackgroundColor,
      child: DefaultTextStyle(
        style: const TextStyle(
          color: ThemeVars.cardTextColor,
          fontSize: ThemeVars.cardFontSize,
        ),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                _buildThumb(),
                Expanded(
                  child: Container(
                    constraints: const BoxConstraints(
                      minWidth: 0.0,
                      minHeight: ThemeVars.cardThumbSize,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            _buildTitle(),
                            _buildDesc(),
                            const SizedBox(height: 2.0),
                            tagsSlot ?? const SizedBox.shrink(),
                          ],
                        ),
                        _buildBottom(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            _buildFooter(),
          ],
        ),
      ),
    );
  }

  bool get _showNum => numberSlot != null || number.isNotEmpty;
  bool get _showPrice => priceSlot != null || price.isNotEmpty;
  bool get _showOriginPrice =>
      originPriceSlot != null || originPrice.isNotEmpty;
  bool get _showBottom =>
      _showNum || _showPrice || _showOriginPrice || bottomSlot != null;

  Widget _buildPrice() {
    if (_showPrice) {
      return DefaultTextStyle(
        style: const TextStyle(
          color: ThemeVars.cardPriceColor,
          fontSize: ThemeVars.cardPriceFontSize,
          fontWeight: ThemeVars.fontWeightBold,
        ),
        child: priceSlot ?? _buildPriceText(),
      );
    }
    return const SizedBox.shrink();
  }

  Widget _buildOriginPrice() {
    if (_showOriginPrice) {
      return Padding(
        padding: const EdgeInsets.only(left: 5.0),
        child: DefaultTextStyle(
          style: const TextStyle(
            color: ThemeVars.cardOriginPriceColor,
            fontSize: ThemeVars.cardOriginPriceFontSize,
            decoration: TextDecoration.lineThrough,
          ),
          child: originPriceSlot ?? Text('$currency $originPrice'),
        ),
      );
    }
    return const SizedBox.shrink();
  }

  Widget _buildNumber() {
    if (_showNum) {
      return DefaultTextStyle(
        style: const TextStyle(
          color: ThemeVars.cardNumColor,
        ),
        child: numberSlot ?? Text('x$number'),
      );
    }
    return const SizedBox.shrink();
  }

  Widget _buildBottom() {
    if (_showBottom) {
      return Row(
        children: <Widget>[
          Expanded(
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: <Widget>[
                priceTopSlot ?? const SizedBox.shrink(),
                _buildPrice(),
                _buildOriginPrice(),
                bottomSlot ?? const SizedBox.shrink(),
              ],
            ),
          ),
          _buildNumber()
        ],
      );
    }

    return const SizedBox.shrink();
  }

  Widget _buildPriceText() {
    final List<String> priceArr = price.split('.');
    return Text.rich(
      TextSpan(children: <InlineSpan>[
        TextSpan(text: currency),
        TextSpan(
          text: priceArr.elementAt(0),
          style: const TextStyle(
            fontSize: ThemeVars.cardPriceIntegerFontSize,
          ),
        ),
        TextSpan(text: '.${priceArr.elementAt(1)}'),
      ]),
    );
  }

  Widget _buildTitle() {
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
          fontWeight: ThemeVars.fontWeightBold,
          // height: ThemeVars.cardTitleLineHeight,
        ),
      ),
    );
  }

  Widget _buildDesc() {
    if (descSlot != null) {
      return descSlot!;
    }
    if (desc.isNotEmpty) {
      return Text(
        desc,
        style: const TextStyle(
          color: ThemeVars.cardDescColor,
          // height: ThemeVars.cardDescLineHeight ,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      );
    }
    return const SizedBox.shrink();
  }

  Widget _buildThumbTag() {
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

    return const SizedBox.shrink();
  }

  Widget _bulidThumbImage() {
    if (thumbSlot != null) {
      return thumbSlot!;
    }

    return FlanImage(
      src: thumb,
      fit: BoxFit.cover,
      width: ThemeVars.cardThumbSize,
      height: ThemeVars.cardThumbSize,
      radius: ThemeVars.cardThumbBorderRadius,
    );
  }

  Widget _buildThumb() {
    if (thumbSlot != null || thumb.isNotEmpty) {
      return GestureDetector(
        onTap: () {
          if (onClickThumb != null) {
            onClickThumb!();
          }
        },
        child: Stack(
          children: <Widget>[
            _bulidThumbImage(),
            _buildThumbTag(),
          ],
        ),
      );
    }

    return const SizedBox.shrink();
  }

  Widget _buildFooter() {
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

    return const SizedBox.shrink();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
        .add(DiagnosticsProperty<String>('thumb', thumb, defaultValue: ''));
    properties
        .add(DiagnosticsProperty<String>('title', title, defaultValue: ''));
    properties.add(DiagnosticsProperty<String>('desc', desc, defaultValue: ''));
    properties.add(DiagnosticsProperty<String>('tag', tag, defaultValue: ''));
    properties
        .add(DiagnosticsProperty<String>('number', number, defaultValue: ''));
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
