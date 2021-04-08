// 🐦 Flutter imports:
import 'package:flutter/material.dart';

class ThemeVars {
  ThemeVars._();
  // Color Palette

  static const Color black = Color(0xFF000000);
  static const Color white = Color(0xFFFFFFFF);
  static const Color gray1 = Color(0xFFF7F8Fa);
  static const Color gray2 = Color(0xFFF2F3F5);
  static const Color gray3 = Color(0xFFEBEDF0);
  static const Color gray4 = Color(0xFFDCDEE0);
  static const Color gray5 = Color(0xFFC8C9CC);
  static const Color gray6 = Color(0xFF969799);
  static const Color gray7 = Color(0xFF646566);
  static const Color gray8 = Color(0xFF323233);
  static const Color red = Color(0xFFEE0A24);
  static const Color blue = Color(0xFF1989Fa);
  static const Color orange = Color(0xFFFF976A);
  static const Color orangeDark = Color(0xFFED6A0C);
  static const Color orangeLight = Color(0xFFFFFBE8);
  static const Color green = Color(0xFF07C160);

  // Gradient Colors
  static const LinearGradient gradientRed = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: <Color>[
      Color(0xffff6034),
      Color(0xffee0a24),
    ],
  );
  static const LinearGradient gradientOrange = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: <Color>[
      Color(0xffffd01e),
      Color(0xffff8917),
    ],
  );

  // Component Colors
  static const Color textColor = gray8;
  static const Color activeColor = gray2;
  static const double activeOpacity = 0.7;
  static const double disabledOpacity = 0.5;
  static const Color backgroundColor = gray1;
  static const Color backgroundColorLight = Color(0xFFFAFAFA);
  static const Color textLinkColor = Color(0xFF576b95);

  // Padding
  static const double paddingBase = 4.0;
  static const double paddingXs = paddingBase * 2;
  static const double paddingSm = paddingBase * 3;
  static const double paddingMd = paddingBase * 4;
  static const double paddingLg = paddingBase * 6;
  static const double paddingXl = paddingBase * 8;

  // Font
  static const double fontSizeXs = 10.0;
  static const double fontSizeSm = 12.0;
  static const double fontSizeMd = 14.0;
  static const double fontSizeLg = 16.0;
  static const FontWeight fontWeightBold = FontWeight.w500;
  static const double lineHeightXs = 14.0;
  static const double lineHeightSm = 18.0;
  static const double lineHeightMd = 20.0;
  static const double lineHeightLg = 22.0;
  static const String baseFontFamily =
      "-apple-system, BlinkMacSystemFont, 'Helvetica Neue',Helvetica, Segoe UI, Arial, Roboto, 'PingFang SC', 'miui', 'Hiragino Sans GB','Microsoft Yahei', sans-serif";
  static const String priceIntegerFontFamily =
      'Avenir-Heavy, PingFang SC, Helvetica Neue, Arial,sans-serif';

  // Animation
  static const Duration animationDurationBase = Duration(milliseconds: 300);
  static const Duration animationDurationFast = Duration(milliseconds: 200);
  static const Curve animationTimingFunctionEnter = Curves.easeOut;
  static const Curve animationTimingFunctionLeave = Curves.easeIn;

  // Border
  static const Color borderColor = gray3;
  static const double borderWidthBase = 1.0;
  static const double borderRadiusSm = 2.0;
  static const double borderRadiusMd = 4.0;
  static const double borderRadiusLg = 8.0;
  static const double borderRadiusMax = 999.0;

  // ActionSheet
  static const String actionSheetMaxHeight = '80%';
  static const double actionSheetHeaderHeight = 48.0;
  static const double actionSheetHeaderFontSize = fontSizeLg;
  static const Color actionSheetDescriptionColor = gray6;
  static const double actionSheetDescriptionFontSize = fontSizeMd;
  static const double actionSheetDescriptionLineHeight = lineHeightMd;
  static const Color actionSheetItemBackground = white;
  static const double actionSheetItemFontSize = fontSizeLg;
  static const double actionSheetItemLineHeight = lineHeightLg;
  static const Color actionSheetItemTextColor = textColor;
  static const Color actionSheetItemDisabledTextColor = gray5;
  static const Color actionSheetSubnameColor = gray6;
  static const double actionSheetSubnameFontSize = fontSizeSm;
  static const double actionSheetSubnameLineHeight = lineHeightSm;
  static const double actionSheetCloseIconSize = 22.0;
  static const Color actionSheetCloseIconColor = gray5;
  static const Color actionSheetCloseIconActiveColor = gray6;
  static const EdgeInsets actionSheetCloseIconPadding =
      EdgeInsets.symmetric(vertical: 0.0, horizontal: paddingMd);
  static const Color actionSheetCancelTextColor = gray7;
  static const double actionSheetCancelPaddingTop = paddingXs;
  static const Color actionSheetCancelPaddingColor = backgroundColor;
  static const double actionSheetLoadingIconSize = 22.0;

  // AddressEdit
  static const double addressEditPadding = paddingSm;
  static const EdgeInsets addressEditButtonsPadding =
      EdgeInsets.symmetric(vertical: paddingXl, horizontal: paddingBase);
  static const double addressEditButtonMarginBottom = paddingSm;
  static const Color addressEditDetailFinishColor = blue;
  static const double addressEditDetailFinishFontSize = fontSizeSm;

  // AddressList
  static const EdgeInsets addressListPadding = EdgeInsets.only(
      top: paddingSm, left: paddingSm, right: paddingSm, bottom: 80.0);
  static const Color addressListDisabledTextColor = gray6;
  static const EdgeInsets addressListDisabledTextPadding = EdgeInsets.only(
      top: paddingBase * 5, left: 0, right: 0, bottom: paddingMd);
  static const double addressListDisabledTextFontSize = fontSizeMd;
  static const double addressListDisabledTextLineHeight = lineHeightMd;
  static const int addressListAddButtonZIndex = 999;
  static const double addressListItemPadding = paddingSm;
  static const Color addressListItemTextColor = textColor;
  static const Color addressListItemDisabledTextColor = gray5;
  static const double addressListItemFontSize = 13.0;
  static const double addressListItemLineHeight = lineHeightSm;
  static const Color addressListItemRadioIconColor = red;
  static const double addressListEditIconSize = 20.0;

  // // Badge
  static const double badgeSize = 16.0;
  static const Color badgeColor = Color(0xFFFFFFFF);
  static const EdgeInsets badgePadding =
      EdgeInsets.symmetric(vertical: 0.0, horizontal: 3.0);
  static const double badgeFontSize = fontSizeSm;
  static const FontWeight badgeFontWeight = fontWeightBold;
  static const double badgeBorderWidth = borderWidthBase;
  static const Color badgeBackgroundColor = red;
  static const Color badgeDotColor = red;
  static const double badgeDotSize = 8.0;
  static const String badgeFontFamily =
      '-apple-system-font, Helvetica Neue, Arial, sans-serif';

  // // Button
  static const double buttonMiniHeight = 24.0;
  static const double buttonMiniFontSize = fontSizeXs;
  static const double buttonSmallHeight = 32.0;
  static const double buttonSmallFontSize = fontSizeSm;
  static const double buttonNormalFontSize = fontSizeMd;
  static const double buttonLargeHeight = 50.0;
  static const double buttonDefaultHeight = 44.0;
  static const double buttonDefaultLineHeight = 1.2;
  static const double buttonDefaultFontSize = fontSizeLg;
  static const Color buttonDefaultColor = textColor;
  static const Color buttonDefaultBackgroundColor = white;
  static const Color buttonDefaultBorderColor = borderColor;
  static const Color buttonPrimaryColor = white;
  static const Color buttonPrimaryBackgroundColor = blue;
  static const Color buttonPrimaryBorderColor = blue;
  static const Color buttonSuccessColor = white;
  static const Color buttonSuccessBackgroundColor = green;
  static const Color buttonSuccessBorderColor = green;
  static const Color buttonDangerColor = white;
  static const Color buttonDangerBackgroundColor = red;
  static const Color buttonDangerBorderColor = red;
  static const Color buttonWarningColor = white;
  static const Color buttonWarningBackgroundColor = orange;
  static const Color buttonWarningBorderColor = orange;
  static const double buttonBorderWidth = borderWidthBase;
  static const double buttonBorderRadius = borderRadiusSm;
  static const double buttonRoundBorderRadius = borderRadiusMax;
  static const Color buttonPlainBackgroundColor = white;
  static const double buttonDisabledOpacity = disabledOpacity;

  // Calendar
  static const Color calendarBackgroundColor = white;
  static const String calendarPopupHeight = '80%';
  static const List<BoxShadow> calendarHeaderBoxShadow = <BoxShadow>[
    BoxShadow(
        offset: Offset(0.0, 2.0),
        blurRadius: 10.0,
        color: Color.fromRGBO(125, 126, 128, 0.16))
  ];
  static const double calendarHeaderTitleHeight = 44.0;
  static const double calendarHeaderTitleFontSize = fontSizeLg;
  static const double calendarHeaderSubtitleFontSize = fontSizeMd;
  static const double calendarWeekdaysHeight = 30.0;
  static const double calendarWeekdaysFontSize = fontSizeSm;
  static const double calendarMonthTitleFontSize = fontSizeMd;
  static const String calendarMonthMarkColor = 'fade(gray2, 80%)';
  static const double calendarMonthMarkFontSize = 160.0;
  static const double calendarDayHeight = 64.0;
  static const double calendarDayFontSize = fontSizeLg;
  static const Color calendarRangeEdgeColor = white;
  static const Color calendarRangeEdgeBackgroundColor = red;
  static const Color calendarRangeMiddleColor = red;
  static const double calendarRangeMiddleBackgroundOpacity = 0.1;
  static const double calendarSelectedDaySize = 54.0;
  static const Color calendarSelectedDayColor = white;
  static const double calendarInfoFontSize = fontSizeXs;
  static const double calendarInfoLineHeight = lineHeightXs;
  static const Color calendarSelectedDayBackgroundColor = red;
  static const Color calendarDayDisabledColor = gray5;
  static const double calendarConfirmButtonHeight = 36.0;
  static const EdgeInsets calendarConfirmButtonMargin =
      EdgeInsets.symmetric(vertical: 7.0);

  // Card
  static const EdgeInsets cardPadding =
      EdgeInsets.symmetric(vertical: paddingXs, horizontal: paddingMd);
  static const double cardFontSize = fontSizeSm;
  static const Color cardTextColor = textColor;
  static const Color cardBackgroundColor = backgroundColorLight;
  static const double cardThumbSize = 88.0;
  static const double cardThumbBorderRadius = borderRadiusLg;
  static const double cardTitleLineHeight = 16.0;
  static const Color cardDescColor = gray7;
  static const double cardDescLineHeight = lineHeightMd;
  static const Color cardPriceColor = gray8;
  static const Color cardOriginPriceColor = gray6;
  static const Color cardNumColor = gray6;
  static const double cardOriginPriceFontSize = fontSizeXs;
  static const double cardPriceFontSize = fontSizeSm;
  static const double cardPriceIntegerFontSize = fontSizeLg;
  static const String cardPriceFontFamily = priceIntegerFontFamily;

  // Cell
  static const double cellFontSize = fontSizeMd;
  static const double cellLineHeight = 24.0;
  static const double cellVerticalPadding = 10.0;
  static const double cellHorizontalPadding = paddingMd;
  static const Color cellTextColor = textColor;
  static const Color cellBackgroundColor = white;
  static const Color cellBorderColor = borderColor;
  static const Color cellActiveColor = activeColor;
  static const Color cellRequiredColor = red;
  static const Color cellLabelColor = gray6;
  static const double cellLabelFontSize = fontSizeSm;
  static const double cellLabelLineHeight = lineHeightSm;
  static const double cellLabelMarginTop = paddingBase;
  static const Color cellValueColor = gray6;
  static const double cellIconSize = 16.0;
  static const Color cellRightIconColor = gray6;
  static const double cellLargeVerticalPadding = paddingSm;
  static const double cellLargeTitleFontSize = fontSizeLg;
  static const double cellLargeLabelFontSize = fontSizeMd;

  // CellGroup
  static const Color cellGroupBackgroundColor = white;
  static const Color cellGroupTitleColor = gray6;
  static const EdgeInsets cellGroupTitlePadding = EdgeInsets.only(
      top: paddingMd, left: paddingMd, right: paddingMd, bottom: paddingXs);
  static const double cellGroupTitleFontSize = fontSizeMd;
  static const double cellGroupTitleLineHeight = 16.0;

  // Checkbox
  static const double checkboxSize = 20.0;
  static const Color checkboxborderColor = gray5;
  static const Duration checkboxTransitionDuration = animationDurationFast;
  static const double checkboxLabelMargin = paddingXs;
  static const Color checkboxLabelColor = textColor;
  static const Color checkboxCheckedIconColor = blue;
  static const Color checkboxDisabledIconColor = gray5;
  static const Color checkboxDisabledLabelColor = gray5;
  static const Color checkboxDisabledBackgroundColor = borderColor;

  // Circle
  static const Color circleTextColor = textColor;
  static const FontWeight circleTextFontWeight = fontWeightBold;
  static const double circleTextFontSize = fontSizeMd;
  static const double circleTextLineHeight = lineHeightMd;

  // Collapse
  static const Duration collapseItemTransitionDuration = animationDurationBase;
  static const EdgeInsets collapseItemContentPadding =
      EdgeInsets.symmetric(vertical: paddingSm, horizontal: paddingMd);
  static const double collapseItemContentFontSize = fontSizeMd;
  static const double collapseItemContentLineHeight = 1.5;
  static const Color collapseItemContentTextColor = gray6;
  static const Color collapseItemContentBackgroundColor = white;
  static const Color collapseItemTitleDisabledColor = gray5;

  // ContactCard
  static const double contactCardPadding = paddingMd;
  static const double contactCardAddIconSize = 40.0;
  static const Color contactCardAddIconColor = blue;
  static const double contactCardValueLineHeight = lineHeightMd;

  // ContactEdit
  static const double contactEditPadding = paddingMd;
  static const double contactEditFieldsRadius = borderRadiusMd;
  static const EdgeInsets contactEditButtonsPadding =
      EdgeInsets.symmetric(vertical: paddingXl, horizontal: 0);
  static const double contactEditButtonMarginBottom = paddingSm;
  static const double contactEditButtonFontSize = 16.0;
  static const double contactEditFieldLabelWidth = 4.1 * 16.0;

  // ContactList
  static const double contactListEditIconSize = 16.0;
  static const int contactListAddButtonZIndex = 999;
  static const double contactListItemPadding = paddingMd;

  // CountDown
  static const Color countDownTextColor = textColor;
  static const double countDownFontSize = fontSizeMd;
  static const double countDownLineHeight = lineHeightMd;

  // Coupon
  static const EdgeInsets couponMargin = EdgeInsets.only(
      top: 0.0, left: paddingSm, right: paddingSm, bottom: paddingSm);
  static const double couponContentHeight = 84.0;
  static const EdgeInsets couponContentPadding =
      EdgeInsets.symmetric(vertical: 14.0, horizontal: 0.0);
  static const Color couponBackgroundColor = white;
  static const Color couponActiveBackgroundColor = activeColor;
  static const double couponBorderRadius = borderRadiusLg;
  static const List<BoxShadow> couponBoxShadow = <BoxShadow>[
    BoxShadow(
        offset: Offset(0.0, 0.0),
        blurRadius: 4.0,
        color: Color.fromRGBO(0, 0, 0, 0.1))
  ];
  static const double couponHeadWidth = 96.0;
  static const Color couponAmountColor = red;
  static const double couponAmountFontSize = 30.0;
  static const String couponCurrencyFontSize = '40%';
  static const double couponNameFontSize = fontSizeMd;
  static const Color couponDisabledTextColor = gray6;
  static const EdgeInsets couponDescriptionPadding =
      EdgeInsets.symmetric(vertical: paddingXs, horizontal: paddingMd);
  static const Color couponDescriptionBorderColor = borderColor;

  // CouponCell
  static const Color couponCellSelectedTextColor = textColor;

  // CouponList
  static const Color couponListBackgroundColor = backgroundColor;
  static const EdgeInsets couponListFieldPadding =
      EdgeInsets.only(top: 5.0, right: 0.0, bottom: 5.0, left: paddingMd);
  static const double couponListExchangeButtonHeight = 32.0;
  static const double couponListCloseButtonHeight = 40.0;
  static const double couponListEmptyImageSize = 200.0;
  static const Color couponListEmptyTipColor = gray6;
  static const double couponListEmptyTipFontSize = fontSizeMd;
  static const double couponListEmptyTipLineHeight = lineHeightMd;

  // Dialog
  static const double dialogWidth = 320.0;
  static const String dialogSmallScreenWidth = '90%';
  static const double dialogFontSize = fontSizeLg;
  static const Duration dialogTransition = animationDurationBase;
  static const double dialogBorderRadius = 16.0;
  static const Color dialogBackgroundColor = white;
  static const FontWeight dialogHeaderFontWeight = fontWeightBold;
  static const double dialogHeaderLineHeight = 24.0;
  static const double dialogHeaderPaddingTop = 26.0;
  static const EdgeInsets dialogHeaderIsolatedPadding =
      EdgeInsets.symmetric(vertical: paddingLg, horizontal: 0.0);
  static const double dialogMessagePadding = paddingLg;
  static const double dialogMessageFontSize = fontSizeMd;
  static const double dialogMessageLineHeight = lineHeightMd;
  static const String dialogMessageMaxHeight = '60vh';
  static const Color dialogHasTitleMessageTextColor = gray7;
  static const double dialogHasTitleMessagePaddingTop = paddingXs;
  static const double dialogButtonHeight = 48.0;
  static const double dialogRoundButtonHeight = 36.0;
  static const Color dialogConfirmButtonTextColor = red;

  // // Divider
  static const EdgeInsets dividerMargin =
      EdgeInsets.symmetric(vertical: paddingMd, horizontal: 0);
  static const Color dividerTextColor = gray6;
  static const double dividerFontSize = fontSizeMd;
  static const double dividerLineHeight = 24.0;
  static const Color dividerBorderColor = borderColor;
  static const double dividerContentPadding = paddingMd;
  static const String dividerContentLeftWidth = '10%';
  static const String dividerContentRightWidth = '10%';

  // DropdownMenu
  static const double dropdownMenuHeight = 48.0;
  static const Color dropdownMenuBackgroundColor = white;
  static final List<BoxShadow> dropdownMenuBoxShadow = <BoxShadow>[
    BoxShadow(
        offset: const Offset(0.0, 2.0),
        blurRadius: 12.0,
        color: gray7.withOpacity(.12))
  ];
  static const double dropdownMenuTitleFontSize = 15.0;
  static const Color dropdownMenuTitleTextColor = textColor;
  static const Color dropdownMenuTitleActiveTextColor = red;
  static const Color dropdownMenuTitleDisabledTextColor = gray6;
  static const EdgeInsets dropdownMenuTitlePadding =
      EdgeInsets.symmetric(vertical: 0.0, horizontal: paddingXs);
  static const double dropdownMenuTitleLineHeight = lineHeightLg;
  static const Color dropdownMenuOptionActiveColor = red;
  static const String dropdownMenuContentMaxHeight = '80%';
  static const int dropdownItemZIndex = 10;

  // Empty
  static const EdgeInsets emptyPadding =
      EdgeInsets.symmetric(vertical: paddingXl, horizontal: 0);
  static const double emptyImageSize = 160.0;
  static const double emptyDescriptionMarginTop = paddingMd;
  static const EdgeInsets emptyDescriptionPadding =
      EdgeInsets.symmetric(vertical: 0, horizontal: 60.0);
  static const Color emptyDescriptionColor = gray6;
  static const double emptyDescriptionFontSize = fontSizeMd;
  static const double emptyDescriptionLineHeight = lineHeightMd;
  static const double emptyBottomMarginTop = 24.0;

  // Field
  static const double fieldLabelWidth = 6.2;
  static const Color fieldLabelColor = gray7;
  static const double fieldLabelMarginRight = paddingSm;
  static const Color fieldInputTextColor = textColor;
  static const Color fieldInputErrorTextColor = red;
  static const Color fieldInputDisabledTextColor = gray5;
  static const Color fieldPlaceholderTextColor = gray5;
  static const double fieldIconSize = 16.0;
  static const double fieldClearIconSize = 16.0;
  static const Color fieldClearIconColor = gray5;
  static const Color fieldRightIconColor = gray6;
  static const Color fieldErrorMessageColor = red;
  static const double fieldErrorMessageTextColor = 12.0;
  static const double fieldTextAreaMinHeight = 60.0;
  static const Color fieldWordLimitColor = gray7;
  static const double fieldWordLimitFontSize = fontSizeSm;
  static const double fieldWordLimitLineHeight = 16.0;
  static const Color fieldDisabledTextColor = gray5;

  // GridItem
  static const EdgeInsets gridItemContentPadding =
      EdgeInsets.symmetric(vertical: paddingMd, horizontal: paddingXs);
  static const Color gridItemContentBackgroundColor = white;
  static const Color gridItemContentActiveColor = activeColor;
  static const double gridItemIconSize = 28.0;
  static const Color gridItemTextColor = gray7;
  static const double gridItemTextFontSize = fontSizeSm;

  // ActionBar
  static const Color actionBarBackgroundColor = white;
  static const double actionBarHeight = 50.0;
  static const double actionBarIconWidth = 48.0;
  static const String actionBarIconHeight = '100%';
  static const Color actionBarIconColor = textColor;
  static const double actionBarIconSize = 18.0;
  static const double actionBarIconFontSize = fontSizeXs;
  static const Color actionBarIconActiveColor = activeColor;
  static const Color actionBarIconTextColor = gray7;
  static const double actionBarButtonHeight = 40.0;
  static const LinearGradient actionBarButtonWarningColor = gradientOrange;
  static const LinearGradient actionBarButtonDangerColor = gradientRed;

  // IndexAnchor
  static const int indexAnchorZIndex = 1;
  static const EdgeInsets indexAnchorPadding =
      EdgeInsets.symmetric(vertical: 0.0, horizontal: paddingMd);
  static const Color indexAnchorTextColor = textColor;
  static const FontWeight indexAnchorFontWeight = fontWeightBold;
  static const double indexAnchorFontSize = fontSizeMd;
  static const double indexAnchorLineHeight = 32.0;
  static const Color indexAnchorBackgroundColor = Colors.transparent;
  static const Color indexAnchorStickyTextColor = green;
  static const Color indexAnchorStickyBackgroundColor = white;

  // IndexBar
  static const int indexBarSidebarZIndex = 2;
  static const double indexBarIndexFontSize = fontSizeXs;
  static const double indexBarIndexLineHeight = lineHeightXs;
  static const Color indexBarIndexActiveColor = green;

  // Image
  static const Color imagePlaceholderTextColor = gray6;
  static const double imagePlaceholderFontSize = fontSizeMd;
  static const Color imagePlaceholderBackgroundColor = backgroundColor;
  static const double imageLoadingIconSize = 32.0;
  static const Color imageLoadingIconColor = gray4;
  static const double imageErrorIconSize = 32.0;
  static const Color imageErrorIconColor = gray4;

  // ImagePreview
  static const Color imagePreviewIndexTextColor = white;
  static const double imagePreviewIndexFontSize = fontSizeMd;
  static const double imagePreviewIndexLineHeight = lineHeightMd;
  static const List<BoxShadow> imagePreviewIndexTextShadow = <BoxShadow>[
    BoxShadow(offset: Offset(0.0, 1.0), blurRadius: 1.0, color: gray8)
  ];
  static const Color imagePreviewOverlayBackgroundColor =
      Color.fromRGBO(0, 0, 0, 0.9);
  static const double imagePreviewCloseIconSize = 22.0;
  static const Color imagePreviewCloseIconColor = gray5;
  static const Color imagePreviewCloseIconActiveColor = gray6;
  static const double imagePreviewCloseIconMargin = paddingMd;
  static const int imagePreviewCloseIconZIndex = 1;

  // List
  static const double listIconMarginRight = paddingBase;
  static const Color listTextColor = gray6;
  static const double listTextFontSize = fontSizeMd;
  static const double listTextLineHeight = 50.0;
  static const double listLoadingIconSize = 16.0;

  // Loading
  static const Color loadingTextColor = gray6;
  static const double loadingTextFontSize = fontSizeMd;
  static const Color loadingSpinnerColor = gray5;
  static const double loadingSpinnerSize = 30.0;
  static const Duration loadingSpinnerAnimationDuration =
      Duration(milliseconds: 800);

  // NavBar
  static const double navBarHeight = 46.0;
  static const Color navBarBackgroundColor = white;
  static const double navBarArrowSize = 16.0;
  static const Color navBarIconColor = blue;
  static const Color navBarTextColor = blue;
  static const double navBarTitleFontSize = fontSizeLg;
  static const Color navBarTitleTextColor = textColor;
  static const int navBarZIndex = 1;

  // NoticeBar
  static const double noticeBarHeight = 40.0;
  static const EdgeInsets noticeBarPadding =
      EdgeInsets.symmetric(vertical: 0, horizontal: paddingMd);
  static const EdgeInsets noticeBarWrapablePadding =
      EdgeInsets.symmetric(vertical: paddingXs, horizontal: paddingMd);
  static const Color noticeBarTextColor = orangeDark;
  static const double noticeBarFontSize = fontSizeMd;
  static const double noticeBarLineHeight = 24.0;
  static const Color noticeBarBackgroundColor = orangeLight;
  static const double noticeBarIconSize = 16.0;
  static const double noticeBarIconMinWidth = 24.0;

  // Notify
  static const Color notifyTextColor = white;
  static const EdgeInsets notifyPadding =
      EdgeInsets.symmetric(vertical: paddingXs, horizontal: paddingMd);
  static const double notifyFontSize = fontSizeMd;
  static const double notifyLineHeight = lineHeightMd;
  static const Color notifyPrimaryBackgroundColor = blue;
  static const Color notifySuccessBackgroundColor = green;
  static const Color notifyDangerBackgroundColor = red;
  static const Color notifyWarningBackgroundColor = orange;

  // NumberKeyboard
  static const Color numberKeyboardBackgroundColor = gray2;
  static const double numberKeyboardKeyHeight = 48.0;
  static const double numberKeyboardKeyFontSize = 28.0;
  static const Color numberKeyboardKeyActiveColor = gray3;
  static const double numberKeyboardDeleteFontSize = fontSizeLg;
  static const Color numberKeyboardTitleColor = gray7;
  static const double numberKeyboardTitleHeight = 34.0;
  static const double numberKeyboardTitleFontSize = fontSizeLg;
  static const EdgeInsets numberKeyboardClosePadding =
      EdgeInsets.symmetric(vertical: 0.0, horizontal: paddingMd);
  static const Color numberKeyboardCloseColor = textLinkColor;
  static const double numberKeyboardCloseFontSize = fontSizeMd;
  static const Color numberKeyboardButtonTextColor = white;
  static const Color numberKeyboardButtonBackgroundColor = blue;
  static const Color numberKeyboardCursorColor = textColor;
  static const double numberKeyboardCursorWidth = 1.0;
  static const String numberKeyboardCursorHeight = '40%';
  static const Duration numberKeyboardCursorAnimationDuration =
      Duration(seconds: 1);
  static const int numberKeyboardZIndex = 100;

  // Overlay
  static const int overlayZIndex = 1;
  static const Color overlayBackgroundColor = Color.fromRGBO(0, 0, 0, .7);

  // Pagination
  static const double paginationHeight = 40.0;
  static const double paginationFontSize = fontSizeMd;
  static const double paginationItemWidth = 36.0;
  static const Color paginationItemDefaultColor = blue;
  static const Color paginationItemDisabledColor = gray7;
  static const Color paginationItemDisabledBackgroundColor = backgroundColor;
  static const Color paginationBackgroundColor = white;
  static const Color paginationDescColor = gray7;
  static const double paginationDisabledOpacity = disabledOpacity;

  // PasswordInput
  static const double passwordInputHeight = 50.0;
  static const EdgeInsets passwordInputMargin =
      EdgeInsets.symmetric(vertical: 0.0, horizontal: paddingMd);
  static const double passwordInputFontSize = 20.0;
  static const double passwordInputBorderRadius = 6.0;
  static const Color passwordInputBackgroundColor = white;
  static const Color passwordInputInfoColor = gray6;
  static const double passwordInputInfoFontSize = fontSizeMd;
  static const Color passwordInputErrorInfoColor = red;
  static const double passwordInputDotSize = 10.0;
  static const Color passwordInputDotColor = black;
  static const Color passwordInputCursorColor = textColor;
  static const double passwordInputCursorWidth = 1.0;
  static const double passwordInputCursorHeight = 0.4;
  static const Duration passwordInputCursorAnimationDuration =
      Duration(seconds: 1);

  // Picker
  static const Color pickerBackgroundColor = white;
  static const double pickerToolbarHeight = 44.0;
  static const double pickerTitleFontSize = fontSizeLg;
  static const double pickerTitleLineHeight = lineHeightMd;
  static const EdgeInsets pickerActionPadding =
      EdgeInsets.symmetric(vertical: 0.0, horizontal: paddingMd);
  static const double pickerActionFontSize = fontSizeMd;
  static const Color pickerConfirmActionColor = textLinkColor;
  static const Color pickerCancelActionColor = gray6;
  static const double pickerOptionFontSize = fontSizeLg;
  static const Color pickerOptionTextColor = black;
  static const double pickerOptionDisabledOpacity = 0.3;
  static const Color pickerLoadingIconColor = blue;
  static const Color pickerLoadingMaskColor =
      Color.fromRGBO(255, 255, 255, 0.9);

  // Popover
  static const double popoverArrowSize = 6.0;
  static const double popoverBorderRadius = borderRadiusLg;
  static const double popoverActionWidth = 128.0;
  static const double popoverActionHeight = 44.0;
  static const double popoverActionFontSize = fontSizeMd;
  static const double popoverActionLineHeight = lineHeightMd;
  static const double popoverActionIconSize = 20.0;
  static const Color popoverLightTextColor = textColor;
  static const Color popoverLightBackgroundColor = white;
  static const Color popoverLightActionDisabledTextColor = gray5;
  static const Color popoverDarkTextColor = white;
  static const Color popoverDarkBackgroundColor = Color(0xff4a4a4a);
  static const Color popoverDarkActionDisabledTextColor = gray6;

  // Popup
  static const Color popupBackgroundColor = white;
  static const Duration popupTransitionDuration = animationDurationBase;
  static const double popupRoundBorderRadius = 16.0;
  static const double popupCloseIconSize = 22.0;
  static const Color popupCloseIconColor = gray5;
  static const Color popupCloseIconActiveColor = gray6;
  static const double popupCloseIconMargin = 16.0;
  static const int popupCloseIconZIndex = 1;

  // Progress
  static const double progressHeight = 4.0;
  static const Color progressColor = blue;
  static const Color progressBackgroundColor = gray3;
  static const EdgeInsets progressPivotPadding =
      EdgeInsets.symmetric(vertical: 0.0, horizontal: 5.0);
  static const Color progressPivotTextColor = white;
  static const double progressPivotFontSize = fontSizeXs;
  static const double progressPivotLineHeight = 1.6;
  static const Color progressPivotBackgroundColor = blue;

  // PullRefresh
  static const double pullRefreshHeadHeight = 50.0;
  static const double pullRefreshHeadFontSize = fontSizeMd;
  static const Color pullRefreshHeadTextColor = gray6;

  // Radio
  static const double radioSize = 20.0;
  static const Color radioBorderColor = gray5;
  static const Duration radioTransitionDuration = animationDurationFast;
  static const double radioLabelMargin = paddingXs;
  static const Color radioLabelColor = textColor;
  static const Color radioCheckedIconColor = blue;
  static const Color radioDisabledIconColor = gray5;
  static const Color radioDisabledLabelColor = gray5;
  static const Color radioDisabledBackgroundColor = borderColor;

  // Rate
  static const double rateIconSize = 20.0;
  static const double rateIconGutter = paddingBase;
  static const Color rateIconVoidColor = gray5;
  static const Color rateIconFullColor = red;
  static const Color rateIconDisabledColor = gray5;

  // ShareSheet
  static const EdgeInsets shareSheetHeaderPadding = EdgeInsets.only(
      top: paddingSm, left: paddingMd, right: paddingMd, bottom: paddingBase);
  static const Color shareSheetTitleColor = textColor;
  static const double shareSheetTitleFontSize = fontSizeMd;
  static const double shareSheetTitleLineHeight = lineHeightMd;
  static const Color shareSheetDescriptionColor = gray6;
  static const double shareSheetDescriptionFontSize = fontSizeSm;
  static const double shareSheetDescriptionLineHeight = 16.0;
  static const double shareSheetIconSize = 48.0;
  static const Color shareSheetOptionNameColor = gray7;
  static const double shareSheetOptionNameFontSize = fontSizeSm;
  static const Color shareSheetOptionDescriptionColor = gray5;
  static const double shareSheetOptionDescriptionFontSize = fontSizeSm;
  static const double shareSheetCancelButtonFontSize = fontSizeLg;
  static const double shareSheetCancelButtonHeight = 48.0;
  static const Color shareSheetCancelButtonBackground = white;

  // Search
  static const EdgeInsets searchPadding =
      EdgeInsets.symmetric(vertical: 10.0, horizontal: paddingSm);
  static const Color searchBackgroundColor = white;
  static const Color searchContentBackgroundColor = gray1;
  static const double searchInputHeight = 34.0;
  static const EdgeInsets searchLabelPadding =
      EdgeInsets.symmetric(vertical: 0.0, horizontal: 5.0);
  static const Color searchLabelColor = textColor;
  static const double searchLabelFontSize = fontSizeMd;
  static const Color searchLeftIconColor = gray6;
  static const EdgeInsets searchActionPadding =
      EdgeInsets.symmetric(vertical: 0.0, horizontal: paddingXs);
  static const Color searchActionTextColor = textColor;
  static const double searchActionFontSize = fontSizeMd;

  // Sidebar
  static const double sidebarWidth = 80.0;
  static const double sidebarFontSize = fontSizeMd;
  static const double sidebarLineHeight = lineHeightMd;
  static const Color sidebarTextColor = textColor;
  static const Color sidebarDisabledTextColor = gray5;
  static const EdgeInsets sidebarPadding =
      EdgeInsets.symmetric(vertical: 20.0, horizontal: paddingSm);
  static const Color sidebarActiveColor = activeColor;
  static const Color sidebarBackgroundColor = backgroundColor;
  static const FontWeight sidebarSelectedFontWeight = fontWeightBold;
  static const Color sidebarSelectedTextColor = textColor;
  static const double sidebarSelectedBorderWidth = 4.0;
  static const double sidebarSelectedBorderHeight = 16.0;
  static const Color sidebarSelectedBorderColor = red;
  static const Color sidebarSelectedBackgroundColor = white;

  // Skeleton
  static const double skeletonRowHeight = 16.0;
  static const Color skeletonRowBackgroundColor = activeColor;
  static const double skeletonRowMarginTop = paddingSm;
  static const double skeletonTitleWidth = .4;
  static const double skeletonAvatarSize = 32.0;
  static const Color skeletonAvatarBackgroundColor = activeColor;
  static const Duration skeletonAnimationDuration =
      Duration(milliseconds: 1200);

  // Slider
  static const Color sliderActiveBackgroundColor = blue;
  static const Color sliderInactiveBackgroundColor = gray3;
  static const double sliderDisabledOpacity = disabledOpacity;
  static const double sliderBarHeight = 2.0;
  static const double sliderButtonWidth = 24.0;
  static const double sliderButtonHeight = 24.0;
  static const String sliderButtonBorderRadius = '50%';
  static const Color sliderButtonBackgroundColor = white;
  static const List<BoxShadow> sliderButtonBoxShadow = <BoxShadow>[
    BoxShadow(
        offset: Offset(0, 1.0),
        blurRadius: 2.0,
        color: Color.fromRGBO(0, 0, 0, .5))
  ];

  // Step
  static const Color stepTextColor = gray6;
  static const Color stepActiveColor = green;
  static const Color stepProcessTextColor = textColor;
  static const double stepFontSize = fontSizeMd;
  static const Color stepLineColor = borderColor;
  static const Color stepFinishLineColor = green;
  static const Color stepFinishTextColor = textColor;
  static const double stepIconSize = 12.0;
  static const double stepCircleSize = 5.0;
  static const Color stepCircleColor = gray6;
  static const double stepHorizontalTitleFontSize = fontSizeSm;

  // Steps
  static const Color stepsBackgroundColor = white;

  // Sticky
  static const int stickyZIndex = 99;

  // Stepper
  static const Color stepperActiveColor = Color(0xffe8e8e8);
  static const Color stepperBackgroundColor = activeColor;
  static const Color stepperButtonIconColor = textColor;
  static const Color stepperButtonDisabledColor = backgroundColor;
  static const Color stepperButtonDisabledIconColor = gray5;
  static const Color stepperButtonRoundThemeColor = red;
  static const double stepperInputWidth = 32.0;
  static const double stepperInputHeight = 28.0;
  static const double stepperInputFontSize = fontSizeMd;
  static const String stepperInputLineHeight = 'normal';
  static const Color stepperInputTextColor = textColor;
  static const Color stepperInputDisabledTextColor = gray5;
  static const Color stepperInputDisabledBackgroundColor = activeColor;
  static const double stepperBorderRadius = borderRadiusMd;

  // SubmitBar
  static const double submitBarHeight = 50.0;
  static const int submitBarZIndex = 100;
  static const Color submitBarBackgroundColor = white;
  static const double submitBarButtonWidth = 110.0;
  static const Color submitBarPriceColor = red;
  static const double submitBarPriceFontSize = fontSizeMd;
  static const double submitBarCurrencyFontSize = fontSizeMd;
  static const Color submitBarTextColor = textColor;
  static const double submitBarTextFontSize = fontSizeMd;
  static const EdgeInsets submitBarTipPadding =
      EdgeInsets.symmetric(vertical: paddingXs, horizontal: paddingSm);
  static const double submitBarTipFontSize = fontSizeSm;
  static const double submitBarTipLineHeight = 1.5;
  static const Color submitBarTipColor = Color(0xfff56723);
  static const Color submitBarTipBackgroundColor = Color(0xfffff7cc);
  static const double submitBarTipIconSize = 12.0;
  static const double submitBarButtonHeight = 40.0;
  static const EdgeInsets submitBarPadding =
      EdgeInsets.symmetric(vertical: 0.0, horizontal: paddingMd);
  static const double submitBarPriceIntegerFontSize = 20.0;
  static const String submitBarPriceFontFamily = priceIntegerFontFamily;

  // Swipe
  static const double swipeIndicatorSize = 6.0;
  static const double swipeIndicatorMargin = paddingSm;
  static const int swipeIndicatorActiveOpacity = 1;
  static const double swipeIndicatorInactiveOpacity = 0.3;
  static const Color swipeIndicatorActiveBackgroundColor = blue;
  static const Color swipeIndicatorInactiveBackgroundColor = borderColor;

  // Switch
  static const double switchSize = 30.0;
  static const double switchWidth = 2.0;
  static const double switchHeight = 1.0;
  static const double switchNodeSize = 1.0;
  static const Color switchNodeBackgroundColor = white;
  static final List<BoxShadow> switchNodeBoxShadow = <BoxShadow>[
    const BoxShadow(
      offset: Offset(0.0, 3.0),
      blurRadius: 1.0,
      spreadRadius: 0.0,
      color: Color.fromRGBO(0, 0, 0, 0.05),
    ),
    const BoxShadow(
      offset: Offset(0.0, 2.0),
      blurRadius: 2.0,
      spreadRadius: 0.0,
      color: Color.fromRGBO(0, 0, 0, 0.1),
    ),
    const BoxShadow(
      offset: Offset(0.0, 3.0),
      blurRadius: 3.0,
      spreadRadius: 0.0,
      color: Color.fromRGBO(0, 0, 0, 0.05),
    ),
  ];
  static const Color switchBackgroundColor = white;
  static const Color switchOnBackgroundColor = blue;
  static const Duration switchTransitionDuration = animationDurationBase;
  static const double switchDisabledOpacity = disabledOpacity;
  static const BorderSide switchBorder = BorderSide(
    width: borderWidthBase,
    style: BorderStyle.solid,
    color: Color.fromRGBO(0, 0, 0, .1),
  );

  // Tabbar
  static const double tabbarHeight = 50.0;
  static const int tabbarZIndex = 1;
  static const Color tabbarBackgroundColor = white;

  // TabbarItem
  static const double tabbarItemFontSize = fontSizeSm;
  static const Color tabbarItemTextColor = gray7;
  static const Color tabbarItemActiveColor = blue;
  static const Color tabbarItemActiveBackgroundColor = tabbarBackgroundColor;
  static const double tabbarItemLineHeight = 1.0;
  static const double tabbarItemIconSize = 22.0;
  static const double tabbarItemMarginBottom = 4.0;

  // Tab
  static const Color tabTextColor = gray7;
  static const Color tabActiveTextColor = textColor;
  static const Color tabDisabledTextColor = gray5;
  static const double tabFontSize = fontSizeMd;
  static const double tabLineHeight = lineHeightMd;

  // Tabs
  static const Color tabsDefaultColor = red;
  static const double tabsLineHeight = 44.0;
  static const double tabsCardHeight = 30.0;
  static const Color tabsNavBackgroundColor = white;
  static const double tabsBottomBarWidth = 40.0;
  static const double tabsBottomBarHeight = 3.0;
  static const Color tabsBottomBarColor = tabsDefaultColor;

  // Tag
  static const EdgeInsets tagPadding =
      EdgeInsets.symmetric(vertical: 0, horizontal: paddingBase);
  static const Color tagTextColor = white;
  static const double tagFontSize = fontSizeSm;
  static const double tagBorderRadius = 2.0;
  static const double tagLineHeight = 16.0;
  static const EdgeInsets tagMediumPadding =
      EdgeInsets.symmetric(vertical: 2.0, horizontal: 6.0);
  static const EdgeInsets tagLargePadding =
      EdgeInsets.symmetric(vertical: paddingBase, horizontal: paddingXs);
  static const double tagLargeBorderRadius = borderRadiusMd;
  static const double tagLargeFontSize = fontSizeMd;
  static const double tagRoundBorderRadius = borderRadiusMax;
  static const Color tagDangerColor = red;
  static const Color tagPrimaryColor = blue;
  static const Color tagSuccessColor = green;
  static const Color tagWarningColor = orange;
  static const Color tagDefaultColor = gray6;
  static const Color tagPlainBackgroundColor = white;

  // Toast
  static const double toastMaxWidth = .7;
  static const double toastFontSize = fontSizeMd;
  static const Color toastTextColor = white;
  static const Color toastLoadingIconColor = white;
  static const double toastLineHeight = lineHeightMd;
  static const double toastBorderRadius = borderRadiusLg;
  static final Color toastBackgroundColor = black.withOpacity(.7);
  static const double toastIconSize = 36.0;
  static const double toastTextMinWidth = 96.0;
  static const EdgeInsets toastTextPadding =
      EdgeInsets.symmetric(vertical: paddingXs, horizontal: paddingSm);
  static const EdgeInsets toastDefaultPadding = EdgeInsets.all(paddingMd);
  static const double toastDefaultWidth = 88.0;
  static const double toastDefaultMinHeight = 88.0;
  static const double toastPositionTopDistance = .2;
  static const double toastPositionBottomDistance = .2;

  // TreeSelect
  static const double treeSelectFontSize = fontSizeMd;
  static const Color treeSelectNavBackgroundColor = backgroundColor;
  static const Color treeSelectContentBackgroundColor = white;
  static const EdgeInsets treeSelectNavItemPadding =
      EdgeInsets.symmetric(vertical: 14.0, horizontal: paddingSm);
  static const double treeSelectItemHeight = 48.0;
  static const Color treeSelectItemActiveColor = red;
  static const Color treeSelectItemDisabledColor = gray5;
  static const double treeSelectItemSelectedSize = 16.0;

  // Uploader
  static const double uploaderSize = 80.0;
  static const double uploaderIconSize = 24.0;
  static const Color uploaderIconColor = gray4;
  static const Color uploaderTextColor = gray6;
  static const double uploaderTextFontSize = fontSizeSm;
  static const Color uploaderUploadBackgroundColor = gray1;
  static const Color uploaderUploadActiveColor = activeColor;
  static const Color uploaderDeleteColor = white;
  static const double uploaderDeleteIconSize = 14.0;
  static const Color uploaderDeleteBackgroundColor =
      Color.fromRGBO(0, 0, 0, 0.7);
  static const Color uploaderFileBackgroundColor = backgroundColor;
  static const double uploaderFileIconSize = 20.0;
  static const Color uploaderFileIconColor = gray7;
  static const EdgeInsets uploaderFileNamePadding =
      EdgeInsets.symmetric(vertical: 0.0, horizontal: paddingBase);
  static const double uploaderFileNameMarginTop = paddingXs;
  static const double uploaderFileNameFontSize = fontSizeSm;
  static const Color uploaderFileNameTextColor = gray7;
  static final Color uploaderMaskBackgroundColor = gray8.withOpacity(.88);
  static const double uploaderMaskIconSize = 22.0;
  static const double uploaderMaskMessageFontSize = fontSizeSm;
  static const double uploaderMaskMessageLineHeight = lineHeightXs;
  static const double uploaderLoadingIconSize = 22.0;
  static const Color uploaderLoadingIconColor = white;
  static const double uploaderDisabledOpacity = disabledOpacity;
}
