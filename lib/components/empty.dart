// 🐦 Flutter imports:

// 🐦 Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_svg/flutter_svg.dart';

// 🌎 Project imports:
import '../styles/components/empty_theme.dart';
import '../styles/theme.dart';
import '../utils/widget.dart';

/// ### FlanEmpty 空状态
/// 空状态时的占位提示
class FlanEmpty extends StatelessWidget {
  const FlanEmpty({
    Key? key,
    this.imageType = FlanEmptyImageType.normal,
    this.imageUrl,
    this.imageSize,
    this.description,
    this.child,
    this.imageSlot,
    this.descriptionSlot,
  }) : super(key: key);

  // ****************** Props ******************
  /// 图片类型，可选值为 `error` `network` `search`，支持传入图片 URL
  final FlanEmptyImageType imageType;

  /// 图片访问链接
  final String? imageUrl;

  /// 图片大小
  final double? imageSize;

  /// 图片下方的描述文字
  final String? description;

  // ****************** Events ******************

  // ****************** Slots ******************
  /// 自定义底部内容
  final Widget? child;

  /// 自定义图标
  final Widget? imageSlot;

  /// 自定义描述文字
  final Widget? descriptionSlot;

  @override
  Widget build(BuildContext context) {
    final FlanEmptyThemeData themeData = FlanTheme.of(context).emptyTheme;
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: themeData.padding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget?>[
            _buildImage(themeData),
            _buildDescription(themeData),
            _buildBottom(themeData),
          ].noNull,
        ),
      ),
    );
  }

  Widget _buildImage(FlanEmptyThemeData themeData) {
    if (imageSlot != null) {
      return imageSlot!;
    }

    if (imageType == FlanEmptyImageType.network) {
      return kNetWorkImage;
    }

    return Image.network(
      imageUrl ?? imageTypeUrl,
      width: imageSize ?? themeData.imageSize,
      height: imageSize ?? themeData.imageSize,
    );
  }

  Widget _buildDescription(FlanEmptyThemeData themeData) {
    final Widget text = descriptionSlot ?? Text(description ?? '');

    return Container(
      margin: EdgeInsets.only(top: themeData.descriptionMarginTop),
      padding: themeData.descriptionPadding,
      child: DefaultTextStyle(
        style: TextStyle(
          color: themeData.descriptionColor,
          fontSize: themeData.descriptionFontSize,
          height: themeData.descriptionLineHeight,
        ),
        child: text,
      ),
    );
  }

  Widget? _buildBottom(FlanEmptyThemeData themeData) {
    if (child != null) {
      return Padding(
        padding: EdgeInsets.only(top: themeData.bottomMarginTop),
        child: child,
      );
    }
  }

  String get imageTypeUrl {
    final String url = <FlanEmptyImageType, String>{
      FlanEmptyImageType.normal: 'default',
      FlanEmptyImageType.error: 'error',
      FlanEmptyImageType.network: 'network',
      FlanEmptyImageType.search: 'search',
    }[imageType]!;
    return 'https://img01.yzcdn.cn/vant/empty-image-$url.png';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
        .add(DiagnosticsProperty<FlanEmptyImageType>('imageType', imageType));
    properties.add(DiagnosticsProperty<String>('imageUrl', imageUrl));
    properties.add(DiagnosticsProperty<double>('imageSize', imageSize,
        defaultValue: false));
    properties.add(DiagnosticsProperty<String>('description', description));
    super.debugFillProperties(properties);
  }
}

/// 图片类型
enum FlanEmptyImageType {
  normal,
  error,
  search,
  network,
}

SvgPicture kNetWorkImage = SvgPicture.string(
    '''<svg viewBox="0 0 160 160" xmlns="http://www.w3.org/2000/svg">
    <defs>
        <linearGradient id="van-empty-network-1" x1="64.022%" y1="100%" x2="64.022%" y2="0%">
            <stop stop-color="#FFF" offset="0%" stop-opacity="0.5"></stop>
            <stop stop-color="#F2F3F5" offset="100%"></stop>
        </linearGradient>
        <linearGradient id="van-empty-network-2" x1="50%" y1="0%" x2="50%" y2="84.459%">
            <stop stop-color="#EBEDF0" offset="0%"></stop>
            <stop stop-color="#DCDEE0" offset="100%" stop-opacity="0"></stop>
        </linearGradient>
        <linearGradient id="van-empty-network-3" x1="100%" y1="0%" x2="100%" y2="100%">
            <stop stop-color="#EAEDF0" offset="0%"></stop>
            <stop stop-color="#DCDEE0" offset="100%"></stop>
        </linearGradient>
        <linearGradient id="van-empty-network-4" x1="100%" y1="100%" x2="100%" y2="0%">
            <stop stop-color="#EAEDF0" offset="0%"></stop>
            <stop stop-color="#DCDEE0" offset="100%"></stop>
        </linearGradient>
        <linearGradient id="van-empty-network-5" x1="0%" y1="43.982%" x2="100%" y2="54.703%">
            <stop stop-color="#EAEDF0" offset="0%"></stop>
            <stop stop-color="#DCDEE0" offset="100%"></stop>
        </linearGradient>
        <linearGradient id="van-empty-network-6" x1="94.535%" y1="43.837%" x2="5.465%" y2="54.948%">
            <stop stop-color="#EAEDF0" offset="0%"></stop>
            <stop stop-color="#DCDEE0" offset="100%"></stop>
        </linearGradient>
        <radialGradient id="van-empty-network-7" cx="50%" cy="0%" fx="50%" fy="0%" r="100%" gradientTransform="matrix(0 1 -.54835 0 .5 -.5)">
            <stop stop-color="#EBEDF0" offset="0%"></stop>
            <stop stop-color="#FFF" offset="100%" stop-opacity="0"></stop>
        </radialGradient>
    </defs>
    <g fill="none" fill-rule="evenodd">
        <g opacity=".8">
            <path d="M0 124V46h20v20h14v58H0z" fill="url(#van-empty-network-1)" transform="matrix(-1 0 0 1 36 7)"></path>
            <path d="M121 8h22.231v14H152v77.37h-31V8z" fill="url(#van-empty-network-1)" transform="translate(2 7)"></path>
        </g>
        <path fill="url(#van-empty-network-7)" d="M0 139h160v21H0z"></path>
        <path d="M37 18a7 7 0 013 13.326v26.742c0 1.23-.997 2.227-2.227 2.227h-1.546A2.227 2.227 0 0134 58.068V31.326A7 7 0 0137 18z" fill="url(#van-empty-network-2)" fill-rule="nonzero" transform="translate(43 36)"></path>
        <g opacity=".6" stroke-linecap="round" stroke-width="7">
            <path d="M20.875 11.136a18.868 18.868 0 00-5.284 13.121c0 5.094 2.012 9.718 5.284 13.12" stroke="url(#van-empty-network-3)" transform="translate(43 36)"></path>
            <path d="M9.849 0C3.756 6.225 0 14.747 0 24.146c0 9.398 3.756 17.92 9.849 24.145" stroke="url(#van-empty-network-3)" transform="translate(43 36)"></path>
            <path d="M57.625 11.136a18.868 18.868 0 00-5.284 13.121c0 5.094 2.012 9.718 5.284 13.12" stroke="url(#van-empty-network-4)" transform="rotate(-180 76.483 42.257)"></path>
            <path d="M73.216 0c-6.093 6.225-9.849 14.747-9.849 24.146 0 9.398 3.756 17.92 9.849 24.145" stroke="url(#van-empty-network-4)" transform="rotate(-180 89.791 42.146)"></path>
        </g>
        <g transform="translate(31 105)" fill-rule="nonzero">
            <rect fill="url(#van-empty-network-5)" width="98" height="34" rx="2"></rect>
            <rect fill="#FFF" x="9" y="8" width="80" height="18" rx="1.114"></rect>
            <rect fill="url(#van-empty-network-6)" x="15" y="12" width="18" height="6" rx="1.114"></rect>
        </g>
    </g>
</svg>''');
