import 'package:flutter/material.dart';

class ThemeVars {
  ThemeVars._();
  // Color Palette

  static const black = Color(0xFF000000);
  static const white = Color(0xFFFFFFFF);
  static const gray1 = Color(0xFFF7F8Fa);
  static const gray2 = Color(0xFFF2F3F5);
  static const gray3 = Color(0xFFEBEDF0);
  static const gray4 = Color(0xFFDCDEE0);
  static const gray5 = Color(0xFFC8C9CC);
  static const gray6 = Color(0xFF969799);
  static const gray7 = Color(0xFF646566);
  static const gray8 = Color(0xFF323233);
  static const red = Color(0xFFEE0A24);
  static const blue = Color(0xFF1989Fa);
  static const orange = Color(0xFFFF976A);
  static const orangeDark = Color(0xFFED6A0C);
  static const orangeLight = Color(0xFFFFFBE8);
  static const green = Color(0xFF07C160);

  // Gradient Colors
  static const gradientRed = const LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [
        Color(0xffff6034),
        Color(0xffee0a24),
      ]);
  static const gradientOrange = const LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [
        Color(0xffffd01e),
        Color(0xffff8917),
      ]);

  // Component Colors
  static const textColor = gray8;
  static const activeColor = gray2;
  static const activeOpacity = 0.7;
  static const disabledOpacity = 0.5;
  static const backgroundColor = gray1;
  static const backgroundColorLight = Color(0xFFFAFAFA);
  static const textLinkColor = Color(0xFF576b95);

  // Padding
  static const paddingBase = 4.0;
  static const paddingXs = paddingBase * 2;
  static const paddingSm = paddingBase * 3;
  static const paddingMd = paddingBase * 4;
  static const paddingLg = paddingBase * 6;
  static const paddingXl = paddingBase * 8;

  // Font
  static const fontSizeXs = 10.0;
  static const fontSizeSm = 12.0;
  static const fontSizeMd = 14.0;
  static const fontSizeLg = 16.0;
  static const fontWeightBold = FontWeight.w500;
  static const lineHeightXs = 14.0;
  static const lineHeightSm = 18.0;
  static const lineHeightMd = 20.0;
  static const lineHeightLg = 22.0;
  static const baseFontFamily =
      "-apple-system, BlinkMacSystemFont, 'Helvetica Neue',Helvetica, Segoe UI, Arial, Roboto, 'PingFang SC', 'miui', 'Hiragino Sans GB','Microsoft Yahei', sans-serif";
  static const priceIntegerFontFamily =
      "Avenir-Heavy, PingFang SC, Helvetica Neue, Arial,sans-serif";

  // Animation
  static const animationDurationBase = const Duration(milliseconds: 300);
  static const animationDurationFast = const Duration(milliseconds: 200);
  static const animationTimingFunctionEnter = Curves.easeOut;
  static const animationTimingFunctionLeave = Curves.easeIn;

  // Border
  static const borderColor = gray3;
  static const borderWidthBase = 1.0;
  static const borderRadiusSm = 2.0;
  static const borderRadiusMd = 4.0;
  static const borderRadiusLg = 8.0;
  static const borderRadiusMax = 999.0;

  // ActionSheet
  static const actionSheetMaxHeight = '80%';
  static const actionSheetHeaderHeight = 48.0;
  static const actionSheetHeaderFontSize = fontSizeLg;
  static const actionSheetDescriptionColor = gray6;
  static const actionSheetDescriptionFontSize = fontSizeMd;
  static const actionSheetDescriptionLineHeight = lineHeightMd;
  static const actionSheetItemBackground = white;
  static const actionSheetItemFontSize = fontSizeLg;
  static const actionSheetItemLineHeight = lineHeightLg;
  static const actionSheetItemTextColor = textColor;
  static const actionSheetItemDisabledTextColor = gray5;
  static const actionSheetSubnameColor = gray6;
  static const actionSheetSubnameFontSize = fontSizeSm;
  static const actionSheetSubnameLineHeight = lineHeightSm;
  static const actionSheetCloseIconSize = 22.0;
  static const actionSheetCloseIconColor = gray5;
  static const actionSheetCloseIconActiveColor = gray6;
  static const actionSheetCloseIconPadding =
      const EdgeInsets.symmetric(vertical: 0.0, horizontal: paddingMd);
  static const actionSheetCancelTextColor = gray7;
  static const actionSheetCancelPaddingTop = paddingXs;
  static const actionSheetCancelPaddingColor = backgroundColor;
  static const actionSheetLoadingIconSize = 22.0;

  // AddressEdit
  static const addressEditPadding = paddingSm;
  static const addressEditButtonsPadding =
      const EdgeInsets.symmetric(vertical: paddingXl, horizontal: paddingBase);
  static const addressEditButtonMarginBottom = paddingSm;
  static const addressEditDetailFinishColor = blue;
  static const addressEditDetailFinishFontSize = fontSizeSm;

  // AddressList
  static const addressListPadding = const EdgeInsets.only(
      top: paddingSm, left: paddingSm, right: paddingSm, bottom: 80.0);
  static const addressListDisabledTextColor = gray6;
  static const addressListDisabledTextPadding = const EdgeInsets.only(
      top: paddingBase * 5, left: 0, right: 0, bottom: paddingMd);
  static const addressListDisabledTextFontSize = fontSizeMd;
  static const addressListDisabledTextLineHeight = lineHeightMd;
  static const addressListAddButtonZIndex = 999;
  static const addressListItemPadding = paddingSm;
  static const addressListItemTextColor = textColor;
  static const addressListItemDisabledTextColor = gray5;
  static const addressListItemFontSize = 13.0;
  static const addressListItemLineHeight = lineHeightSm;
  static const addressListItemRadioIconColor = red;
  static const addressListEditIconSize = 20.0;

  // // Badge
  static const badgeSize = 16.0;
  static const badgeColor = Color(0xFFFFFFFF);
  static const badgePadding =
      EdgeInsets.symmetric(vertical: 0.0, horizontal: 3.0);
  static const badgeFontSize = fontSizeSm;
  static const badgeFontWeight = fontWeightBold;
  static const badgeBorderWidth = borderWidthBase;
  static const badgeBackgroundColor = red;
  static const badgeDotColor = red;
  static const badgeDotSize = 8.0;
  static const badgeFontFamily =
      "-apple-system-font, Helvetica Neue, Arial, sans-serif";

  // // Button
  static const buttonMiniHeight = 24.0;
  static const buttonMiniFontSize = fontSizeXs;
  static const buttonSmallHeight = 32.0;
  static const buttonSmallFontSize = fontSizeSm;
  static const buttonNormalFontSize = fontSizeMd;
  static const buttonLargeHeight = 50.0;
  static const buttonDefaultHeight = 44.0;
  static const buttonDefaultLineHeight = 1.2;
  static const buttonDefaultFontSize = fontSizeLg;
  static const buttonDefaultColor = textColor;
  static const buttonDefaultBackgroundColor = white;
  static const buttonDefaultBorderColor = borderColor;
  static const buttonPrimaryColor = white;
  static const buttonPrimaryBackgroundColor = blue;
  static const buttonPrimaryBorderColor = blue;
  static const buttonSuccessColor = white;
  static const buttonSuccessBackgroundColor = green;
  static const buttonSuccessBorderColor = green;
  static const buttonDangerColor = white;
  static const buttonDangerBackgroundColor = red;
  static const buttonDangerBorderColor = red;
  static const buttonWarningColor = white;
  static const buttonWarningBackgroundColor = orange;
  static const buttonWarningBorderColor = orange;
  static const buttonBorderWidth = borderWidthBase;
  static const buttonBorderRadius = borderRadiusSm;
  static const buttonRoundBorderRadius = borderRadiusMax;
  static const buttonPlainBackgroundColor = white;
  static const buttonDisabledOpacity = disabledOpacity;

  // Calendar
  static const calendarBackgroundColor = white;
  static const calendarPopupHeight = '80%';
  static const calendarHeaderBoxShadow = const [
    BoxShadow(
        offset: Offset(0.0, 2.0),
        blurRadius: 10.0,
        color: Color.fromRGBO(125, 126, 128, 0.16))
  ];
  static const calendarHeaderTitleHeight = 44.0;
  static const calendarHeaderTitleFontSize = fontSizeLg;
  static const calendarHeaderSubtitleFontSize = fontSizeMd;
  static const calendarWeekdaysHeight = 30.0;
  static const calendarWeekdaysFontSize = fontSizeSm;
  static const calendarMonthTitleFontSize = fontSizeMd;
  static const calendarMonthMarkColor = 'fade(gray2, 80%)';
  static const calendarMonthMarkFontSize = 160.0;
  static const calendarDayHeight = 64.0;
  static const calendarDayFontSize = fontSizeLg;
  static const calendarRangeEdgeColor = white;
  static const calendarRangeEdgeBackgroundColor = red;
  static const calendarRangeMiddleColor = red;
  static const calendarRangeMiddleBackgroundOpacity = 0.1;
  static const calendarSelectedDaySize = 54.0;
  static const calendarSelectedDayColor = white;
  static const calendarInfoFontSize = fontSizeXs;
  static const calendarInfoLineHeight = lineHeightXs;
  static const calendarSelectedDayBackgroundColor = red;
  static const calendarDayDisabledColor = gray5;
  static const calendarConfirmButtonHeight = 36.0;
  static const calendarConfirmButtonMargin =
      const EdgeInsets.symmetric(vertical: 7.0);

  // Card
  static const cardPadding =
      const EdgeInsets.symmetric(vertical: paddingXs, horizontal: paddingMd);
  static const cardFontSize = fontSizeSm;
  static const cardTextColor = textColor;
  static const cardBackgroundColor = backgroundColorLight;
  static const cardThumbSize = 88.0;
  static const cardThumbBorderRadius = borderRadiusLg;
  static const cardTitleLineHeight = 16.0;
  static const cardDescColor = gray7;
  static const cardDescLineHeight = lineHeightMd;
  static const cardPriceColor = gray8;
  static const cardOriginPriceColor = gray6;
  static const cardNumColor = gray6;
  static const cardOriginPriceFontSize = fontSizeXs;
  static const cardPriceFontSize = fontSizeSm;
  static const cardPriceIntegerFontSize = fontSizeLg;
  static const cardPriceFontFamily = priceIntegerFontFamily;

  // Cell
  static const cellFontSize = fontSizeMd;
  static const cellLineHeight = 24.0;
  static const cellVerticalPadding = 10.0;
  static const cellHorizontalPadding = paddingMd;
  static const cellTextColor = textColor;
  static const cellBackgroundColor = white;
  static const cellBorderColor = borderColor;
  static const cellActiveColor = activeColor;
  static const cellRequiredColor = red;
  static const cellLabelColor = gray6;
  static const cellLabelFontSize = fontSizeSm;
  static const cellLabelLineHeight = lineHeightSm;
  static const cellLabelMarginTop = paddingBase;
  static const cellValueColor = gray6;
  static const cellIconSize = 16.0;
  static const cellRightIconColor = gray6;
  static const cellLargeVerticalPadding = paddingSm;
  static const cellLargeTitleFontSize = fontSizeLg;
  static const cellLargeLabelFontSize = fontSizeMd;

  // CellGroup
  static const cellGroupBackgroundColor = white;
  static const cellGroupTitleColor = gray6;
  static const cellGroupTitlePadding = EdgeInsets.only(
      top: paddingMd, left: paddingMd, right: paddingMd, bottom: paddingXs);
  static const cellGroupTitleFontSize = fontSizeMd;
  static const cellGroupTitleLineHeight = 16.0;

  // Checkbox
  static const checkboxSize = 20.0;
  static const checkboxborderColor = gray5;
  static const checkboxTransitionDuration = animationDurationFast;
  static const checkboxLabelMargin = paddingXs;
  static const checkboxLabelColor = textColor;
  static const checkboxCheckedIconColor = blue;
  static const checkboxDisabledIconColor = gray5;
  static const checkboxDisabledLabelColor = gray5;
  static const checkboxDisabledBackgroundColor = borderColor;

  // Circle
  static const circleTextColor = textColor;
  static const circleTextFontWeight = fontWeightBold;
  static const circleTextFontSize = fontSizeMd;
  static const circleTextLineHeight = lineHeightMd;

  // Collapse
  static const collapseItemTransitionDuration = animationDurationBase;
  static const collapseItemContentPadding =
      const EdgeInsets.symmetric(vertical: paddingSm, horizontal: paddingMd);
  static const collapseItemContentFontSize = fontSizeMd;
  static const collapseItemContentLineHeight = 1.5;
  static const collapseItemContentTextColor = gray6;
  static const collapseItemContentBackgroundColor = white;
  static const collapseItemTitleDisabledColor = gray5;

  // ContactCard
  static const contactCardPadding = paddingMd;
  static const contactCardAddIconSize = 40.0;
  static const contactCardAddIconColor = blue;
  static const contactCardValueLineHeight = lineHeightMd;

  // ContactEdit
  static const contactEditPadding = paddingMd;
  static const contactEditFieldsRadius = borderRadiusMd;
  static const contactEditButtonsPadding =
      const EdgeInsets.symmetric(vertical: paddingXl, horizontal: 0);
  static const contactEditButtonMarginBottom = paddingSm;
  static const contactEditButtonFontSize = 16.0;
  static const contactEditFieldLabelWidth = '4.1em';

  // ContactList
  static const contactListEditIconSize = 16.0;
  static const contactListAddButtonZIndex = 999;
  static const contactListItemPadding = paddingMd;

  // CountDown
  static const countDownTextColor = textColor;
  static const countDownFontSize = fontSizeMd;
  static const countDownLineHeight = lineHeightMd;

  // Coupon
  static const couponMargin = const EdgeInsets.only(
      top: 0.0, left: paddingSm, right: paddingSm, bottom: paddingSm);
  static const couponContentHeight = 84.0;
  static const couponContentPadding =
      const EdgeInsets.symmetric(vertical: 14.0, horizontal: 0.0);
  static const couponBackgroundColor = white;
  static const couponActiveBackgroundColor = activeColor;
  static const couponBorderRadius = borderRadiusLg;
  static const couponBoxShadow = [
    BoxShadow(
        offset: Offset(0.0, 0.0),
        blurRadius: 4.0,
        color: Color.fromRGBO(0, 0, 0, 0.1))
  ];
  static const couponHeadWidth = 96.0;
  static const couponAmountColor = red;
  static const couponAmountFontSize = 30.0;
  static const couponCurrencyFontSize = '40%';
  static const couponNameFontSize = fontSizeMd;
  static const couponDisabledTextColor = gray6;
  static const couponDescriptionPadding =
      const EdgeInsets.symmetric(vertical: paddingXs, horizontal: paddingMd);
  static const couponDescriptionBorderColor = borderColor;

  // CouponCell
  static const couponCellSelectedTextColor = textColor;

  // CouponList
  static const couponListBackgroundColor = backgroundColor;
  static const couponListFieldPadding =
      const EdgeInsets.only(top: 5.0, right: 0.0, bottom: 5.0, left: paddingMd);
  static const couponListExchangeButtonHeight = 32.0;
  static const couponListCloseButtonHeight = 40.0;
  static const couponListEmptyImageSize = 200.0;
  static const couponListEmptyTipColor = gray6;
  static const couponListEmptyTipFontSize = fontSizeMd;
  static const couponListEmptyTipLineHeight = lineHeightMd;

  // Dialog
  static const dialogWidth = 320.0;
  static const dialogSmallScreenWidth = '90%';
  static const dialogFontSize = fontSizeLg;
  static const dialogTransition = animationDurationBase;
  static const dialogBorderRadius = 16.0;
  static const dialogBackgroundColor = white;
  static const dialogHeaderFontWeight = fontWeightBold;
  static const dialogHeaderLineHeight = 24.0;
  static const dialogHeaderPaddingTop = 26.0;
  static const dialogHeaderIsolatedPadding =
      const EdgeInsets.symmetric(vertical: paddingLg, horizontal: 0.0);
  static const dialogMessagePadding = paddingLg;
  static const dialogMessageFontSize = fontSizeMd;
  static const dialogMessageLineHeight = lineHeightMd;
  static const dialogMessageMaxHeight = '60vh';
  static const dialogHasTitleMessageTextColor = gray7;
  static const dialogHasTitleMessagePaddingTop = paddingXs;
  static const dialogButtonHeight = 48.0;
  static const dialogRoundButtonHeight = 36.0;
  static const dialogConfirmButtonTextColor = red;

  // // Divider
  static const dividerMargin =
      const EdgeInsets.symmetric(vertical: paddingMd, horizontal: 0);
  static const dividerTextColor = gray6;
  static const dividerFontSize = fontSizeMd;
  static const dividerLineHeight = 24.0;
  static const dividerBorderColor = borderColor;
  static const dividerContentPadding = paddingMd;
  static const dividerContentLeftWidth = "10%";
  static const dividerContentRightWidth = "10%";

  // DropdownMenu
  static const dropdownMenuHeight = 48.0;
  static const dropdownMenuBackgroundColor = white;
  static final dropdownMenuBoxShadow = [
    BoxShadow(
        offset: Offset(0.0, 2.0),
        blurRadius: 12.0,
        color: gray7.withOpacity(.12))
  ];
  static const dropdownMenuTitleFontSize = 15.0;
  static const dropdownMenuTitleTextColor = textColor;
  static const dropdownMenuTitleActiveTextColor = red;
  static const dropdownMenuTitleDisabledTextColor = gray6;
  static const dropdownMenuTitlePadding =
      const EdgeInsets.symmetric(vertical: 0.0, horizontal: paddingXs);
  static const dropdownMenuTitleLineHeight = lineHeightLg;
  static const dropdownMenuOptionActiveColor = red;
  static const dropdownMenuContentMaxHeight = '80%';
  static const dropdownItemZIndex = 10;

  // Empty
  static const emptyPadding =
      const EdgeInsets.symmetric(vertical: paddingXl, horizontal: 0);
  static const emptyImageSize = 160.0;
  static const emptyDescriptionMarginTop = paddingMd;
  static const emptyDescriptionPadding =
      const EdgeInsets.symmetric(vertical: 0, horizontal: 60.0);
  static const emptyDescriptionColor = gray6;
  static const emptyDescriptionFontSize = fontSizeMd;
  static const emptyDescriptionLineHeight = lineHeightMd;
  static const emptyBottomMarginTop = 24.0;

  // Field
  static const fieldLabelWidth = '6.2em';
  static const fieldLabelColor = gray7;
  static const fieldLabelMarginRight = paddingSm;
  static const fieldInputTextColor = textColor;
  static const fieldInputErrorTextColor = red;
  static const fieldInputDisabledTextColor = gray5;
  static const fieldPlaceholderTextColor = gray5;
  static const fieldIconSize = 16.0;
  static const fieldClearIconSize = 16.0;
  static const fieldClearIconColor = gray5;
  static const fieldRightIconColor = gray6;
  static const fieldErrorMessageColor = red;
  static const fieldErrorMessageTextColor = 12.0;
  static const fieldTextAreaMinHeight = 60.0;
  static const fieldWordLimitColor = gray7;
  static const fieldWordLimitFontSize = fontSizeSm;
  static const fieldWordLimitLineHeight = 16.0;
  static const fieldDisabledTextColor = gray5;

  // GridItem
  static const gridItemContentPadding =
      const EdgeInsets.symmetric(vertical: paddingMd, horizontal: paddingXs);
  static const gridItemContentBackgroundColor = white;
  static const gridItemContentActiveColor = activeColor;
  static const gridItemIconSize = 28.0;
  static const gridItemTextColor = gray7;
  static const gridItemTextFontSize = fontSizeSm;

  // ActionBar
  static const actionBarBackgroundColor = white;
  static const actionBarHeight = 50.0;
  static const actionBarIconWidth = 48.0;
  static const actionBarIconHeight = '100%';
  static const actionBarIconColor = textColor;
  static const actionBarIconSize = 18.0;
  static const actionBarIconFontSize = fontSizeXs;
  static const actionBarIconActiveColor = activeColor;
  static const actionBarIconTextColor = gray7;
  static const actionBarButtonHeight = 40.0;
  static const actionBarButtonWarningColor = gradientOrange;
  static const actionBarButtonDangerColor = gradientRed;

  // IndexAnchor
  static const indexAnchorZIndex = 1;
  static const indexAnchorPadding =
      const EdgeInsets.symmetric(vertical: 0.0, horizontal: paddingMd);
  static const indexAnchorTextColor = textColor;
  static const indexAnchorFontWeight = fontWeightBold;
  static const indexAnchorFontSize = fontSizeMd;
  static const indexAnchorLineHeight = 32.0;
  static const indexAnchorBackgroundColor = Colors.transparent;
  static const indexAnchorStickyTextColor = green;
  static const indexAnchorStickyBackgroundColor = white;

  // IndexBar
  static const indexBarSidebarZIndex = 2;
  static const indexBarIndexFontSize = fontSizeXs;
  static const indexBarIndexLineHeight = lineHeightXs;
  static const indexBarIndexActiveColor = green;

  // Image
  static const imagePlaceholderTextColor = gray6;
  static const imagePlaceholderFontSize = fontSizeMd;
  static const imagePlaceholderBackgroundColor = backgroundColor;
  static const imageLoadingIconSize = 32.0;
  static const imageLoadingIconColor = gray4;
  static const imageErrorIconSize = 32.0;
  static const imageErrorIconColor = gray4;

  // ImagePreview
  static const imagePreviewIndexTextColor = white;
  static const imagePreviewIndexFontSize = fontSizeMd;
  static const imagePreviewIndexLineHeight = lineHeightMd;
  static const imagePreviewIndexTextShadow = [
    BoxShadow(offset: Offset(0.0, 1.0), blurRadius: 1.0, color: gray8)
  ];
  static const imagePreviewOverlayBackgroundColor =
      Color.fromRGBO(0, 0, 0, 0.9);
  static const imagePreviewCloseIconSize = 22.0;
  static const imagePreviewCloseIconColor = gray5;
  static const imagePreviewCloseIconActiveColor = gray6;
  static const imagePreviewCloseIconMargin = paddingMd;
  static const imagePreviewCloseIconZIndex = 1;

  // List
  static const listIconMarginRight = 5.0;
  static const listTextColor = gray6;
  static const listTextFontSize = fontSizeMd;
  static const listTextLineHeight = 50.0;

  // Loading
  static const loadingTextColor = gray6;
  static const loadingTextFontSize = fontSizeMd;
  static const loadingSpinnerColor = gray5;
  static const loadingSpinnerSize = 30.0;
  static const loadingSpinnerAnimationDuration =
      const Duration(milliseconds: 800);

  // NavBar
  static const navBarHeight = 46.0;
  static const navBarBackgroundColor = white;
  static const navBarArrowSize = 16.0;
  static const navBarIconColor = blue;
  static const navBarTextColor = blue;
  static const navBarTitleFontSize = fontSizeLg;
  static const navBarTitleTextColor = textColor;
  static const navBarZIndex = 1;

  // NoticeBar
  static const noticeBarHeight = 40.0;
  static const noticeBarPadding =
      const EdgeInsets.symmetric(vertical: 0, horizontal: paddingMd);
  static const noticeBarWrapablePadding =
      const EdgeInsets.symmetric(vertical: paddingXs, horizontal: paddingMd);
  static const noticeBarTextColor = orangeDark;
  static const noticeBarFontSize = fontSizeMd;
  static const noticeBarLineHeight = 24.0;
  static const noticeBarBackgroundColor = orangeLight;
  static const noticeBarIconSize = 16.0;
  static const noticeBarIconMinWidth = 24.0;

  // Notify
  static const notifyTextColor = white;
  static const notifyPadding =
      const EdgeInsets.symmetric(vertical: paddingXs, horizontal: paddingMd);
  static const notifyFontSize = fontSizeMd;
  static const notifyLineHeight = lineHeightMd;
  static const notifyPrimaryBackgroundColor = blue;
  static const notifySuccessBackgroundColor = green;
  static const notifyDangerBackgroundColor = red;
  static const notifyWarningBackgroundColor = orange;

  // NumberKeyboard
  static const numberKeyboardBackgroundColor = gray2;
  static const numberKeyboardKeyHeight = 48.0;
  static const numberKeyboardKeyFontSize = 28.0;
  static const numberKeyboardKeyActiveColor = gray3;
  static const numberKeyboardDeleteFontSize = fontSizeLg;
  static const numberKeyboardTitleColor = gray7;
  static const numberKeyboardTitleHeight = 34.0;
  static const numberKeyboardTitleFontSize = fontSizeLg;
  static const numberKeyboardClosePadding =
      const EdgeInsets.symmetric(vertical: 0.0, horizontal: paddingMd);
  static const numberKeyboardCloseColor = textLinkColor;
  static const numberKeyboardCloseFontSize = fontSizeMd;
  static const numberKeyboardButtonTextColor = white;
  static const numberKeyboardButtonBackgroundColor = blue;
  static const numberKeyboardCursorColor = textColor;
  static const numberKeyboardCursorWidth = 1.0;
  static const numberKeyboardCursorHeight = '40%';
  static const numberKeyboardCursorAnimationDuration =
      const Duration(seconds: 1);
  static const numberKeyboardZIndex = 100;

  // Overlay
  static const overlayZIndex = 1;
  static const overlayBackgroundColor = Color.fromRGBO(0, 0, 0, .7);

  // Pagination
  static const paginationHeight = 40.0;
  static const paginationFontSize = fontSizeMd;
  static const paginationItemWidth = 36.0;
  static const paginationItemDefaultColor = blue;
  static const paginationItemDisabledColor = gray7;
  static const paginationItemDisabledBackgroundColor = backgroundColor;
  static const paginationBackgroundColor = white;
  static const paginationDescColor = gray7;
  static const paginationDisabledOpacity = disabledOpacity;

  // PasswordInput
  static const passwordInputHeight = 50.0;
  static const passwordInputMargin =
      const EdgeInsets.symmetric(vertical: 0.0, horizontal: paddingMd);
  static const passwordInputFontSize = 20.0;
  static const passwordInputBorderRadius = 6.0;
  static const passwordInputBackgroundColor = white;
  static const passwordInputInfoColor = gray6;
  static const passwordInputInfoFontSize = fontSizeMd;
  static const passwordInputErrorInfoColor = red;
  static const passwordInputDotSize = 10.0;
  static const passwordInputDotColor = black;

  // Picker
  static const pickerBackgroundColor = white;
  static const pickerToolbarHeight = 44.0;
  static const pickerTitleFontSize = fontSizeLg;
  static const pickerTitleLineHeight = lineHeightMd;
  static const pickerActionPadding =
      const EdgeInsets.symmetric(vertical: 0.0, horizontal: paddingMd);
  static const pickerActionFontSize = fontSizeMd;
  static const pickerConfirmActionColor = textLinkColor;
  static const pickerCancelActionColor = gray6;
  static const pickerOptionFontSize = fontSizeLg;
  static const pickerOptionTextColor = black;
  static const pickerOptionDisabledOpacity = 0.3;
  static const pickerLoadingIconColor = blue;
  static const pickerLoadingMaskColor = Color.fromRGBO(255, 255, 255, 0.9);

  // Popover
  static const popoverArrowSize = 6.0;
  static const popoverBorderRadius = borderRadiusLg;
  static const popoverActionWidth = 128.0;
  static const popoverActionHeight = 44.0;
  static const popoverActionFontSize = fontSizeMd;
  static const popoverActionLineHeight = lineHeightMd;
  static const popoverActionIconSize = 20.0;
  static const popoverLightTextColor = textColor;
  static const popoverLightBackgroundColor = white;
  static const popoverLightActionDisabledTextColor = gray5;
  static const popoverDarkTextColor = white;
  static const popoverDarkBackgroundColor = Color(0xff4a4a4a);
  static const popoverDarkActionDisabledTextColor = gray6;

  // Popup
  static const popupBackgroundColor = white;
  static const popupTransitionDuration = animationDurationBase;
  static const popupRoundBorderRadius = 16.0;
  static const popupCloseIconSize = 22.0;
  static const popupCloseIconColor = gray5;
  static const popupCloseIconActiveColor = gray6;
  static const popupCloseIconMargin = 16.0;
  static const popupCloseIconZIndex = 1;

  // Progress
  static const progressHeight = 4.0;
  static const progressColor = blue;
  static const progressBackgroundColor = gray3;
  static const progressPivotPadding =
      const EdgeInsets.symmetric(vertical: 0.0, horizontal: 5.0);
  static const progressPivotTextColor = white;
  static const progressPivotFontSize = fontSizeXs;
  static const progressPivotLineHeight = 1.6;
  static const progressPivotBackgroundColor = blue;

  // PullRefresh
  static const pullRefreshHeadHeight = 50.0;
  static const pullRefreshHeadFontSize = fontSizeMd;
  static const pullRefreshHeadTextColor = gray6;

  // Radio
  static const radioSize = 20.0;
  static const radioBorderColor = gray5;
  static const radioTransitionDuration = animationDurationFast;
  static const radioLabelMargin = paddingXs;
  static const radioLabelColor = textColor;
  static const radioCheckedIconColor = blue;
  static const radioDisabledIconColor = gray5;
  static const radioDisabledLabelColor = gray5;
  static const radioDisabledBackgroundColor = borderColor;

  // Rate
  static const rateIconSize = 20.0;
  static const rateIconGutter = paddingBase;
  static const rateIconVoidColor = gray5;
  static const rateIconFullColor = red;
  static const rateIconDisabledColor = gray5;

  // ShareSheet
  static const shareSheetHeaderPadding = const EdgeInsets.only(
      top: paddingSm, left: paddingMd, right: paddingMd, bottom: paddingBase);
  static const shareSheetTitleColor = textColor;
  static const shareSheetTitleFontSize = fontSizeMd;
  static const shareSheetTitleLineHeight = lineHeightMd;
  static const shareSheetDescriptionColor = gray6;
  static const shareSheetDescriptionFontSize = fontSizeSm;
  static const shareSheetDescriptionLineHeight = 16.0;
  static const shareSheetIconSize = 48.0;
  static const shareSheetOptionNameColor = gray7;
  static const shareSheetOptionNameFontSize = fontSizeSm;
  static const shareSheetOptionDescriptionColor = gray5;
  static const shareSheetOptionDescriptionFontSize = fontSizeSm;
  static const shareSheetCancelButtonFontSize = fontSizeLg;
  static const shareSheetCancelButtonHeight = 48.0;
  static const shareSheetCancelButtonBackground = white;

  // Search
  static const searchPadding =
      const EdgeInsets.symmetric(vertical: 10.0, horizontal: paddingSm);
  static const searchBackgroundColor = white;
  static const searchContentBackgroundColor = gray1;
  static const searchInputHeight = 34.0;
  static const searchLabelPadding =
      const EdgeInsets.symmetric(vertical: 0.0, horizontal: 5.0);
  static const searchLabelColor = textColor;
  static const searchLabelFontSize = fontSizeMd;
  static const searchLeftIconColor = gray6;
  static const searchActionPadding =
      const EdgeInsets.symmetric(vertical: 0.0, horizontal: paddingXs);
  static const searchActionTextColor = textColor;
  static const searchActionFontSize = fontSizeMd;

  // Sidebar
  static const sidebarWidth = 80.0;
  static const sidebarFontSize = fontSizeMd;
  static const sidebarLineHeight = lineHeightMd;
  static const sidebarTextColor = textColor;
  static const sidebarDisabledTextColor = gray5;
  static const sidebarPadding =
      const EdgeInsets.symmetric(vertical: 20.0, horizontal: paddingSm);
  static const sidebarActiveColor = activeColor;
  static const sidebarBackgroundColor = backgroundColor;
  static const sidebarSelectedFontWeight = fontWeightBold;
  static const sidebarSelectedTextColor = textColor;
  static const sidebarSelectedBorderWidth = 4.0;
  static const sidebarSelectedBorderHeight = 16.0;
  static const sidebarSelectedBorderColor = red;
  static const sidebarSelectedBackgroundColor = white;

  // Skeleton
  static const skeletonRowHeight = 16.0;
  static const skeletonRowBackgroundColor = activeColor;
  static const skeletonRowMarginTop = paddingSm;
  static const skeletonTitleWidth = .4;
  static const skeletonAvatarSize = 32.0;
  static const skeletonAvatarBackgroundColor = activeColor;
  static const skeletonAnimationDuration = Duration(milliseconds: 1200);

  // Slider
  static const sliderActiveBackgroundColor = blue;
  static const sliderInactiveBackgroundColor = gray3;
  static const sliderDisabledOpacity = disabledOpacity;
  static const sliderBarHeight = 2.0;
  static const sliderButtonWidth = 24.0;
  static const sliderButtonHeight = 24.0;
  static const sliderButtonBorderRadius = '50%';
  static const sliderButtonBackgroundColor = white;
  static const sliderButtonBoxShadow = [
    BoxShadow(
        offset: Offset(0, 1.0),
        blurRadius: 2.0,
        color: Color.fromRGBO(0, 0, 0, .5))
  ];

  // Step
  static const stepTextColor = gray6;
  static const stepActiveColor = green;
  static const stepProcessTextColor = textColor;
  static const stepFontSize = fontSizeMd;
  static const stepLineColor = borderColor;
  static const stepFinishLineColor = green;
  static const stepFinishTextColor = textColor;
  static const stepIconSize = 12.0;
  static const stepCircleSize = 5.0;
  static const stepCircleColor = gray6;
  static const stepHorizontalTitleFontSize = fontSizeSm;

  // Steps
  static const stepsBackgroundColor = white;

  // Sticky
  static const stickyZIndex = 99;

  // Stepper
  static const stepperActiveColor = Color(0xffe8e8e8);
  static const stepperBackgroundColor = activeColor;
  static const stepperButtonIconColor = textColor;
  static const stepperButtonDisabledColor = backgroundColor;
  static const stepperButtonDisabledIconColor = gray5;
  static const stepperButtonRoundThemeColor = red;
  static const stepperInputWidth = 32.0;
  static const stepperInputHeight = 28.0;
  static const stepperInputFontSize = fontSizeMd;
  static const stepperInputLineHeight = 'normal';
  static const stepperInputTextColor = textColor;
  static const stepperInputDisabledTextColor = gray5;
  static const stepperInputDisabledBackgroundColor = activeColor;
  static const stepperBorderRadius = borderRadiusMd;

  // SubmitBar
  static const submitBarHeight = 50.0;
  static const submitBarZIndex = 100;
  static const submitBarBackgroundColor = white;
  static const submitBarButtonWidth = 110.0;
  static const submitBarPriceColor = red;
  static const submitBarPriceFontSize = fontSizeMd;
  static const submitBarCurrencyFontSize = fontSizeMd;
  static const submitBarTextColor = textColor;
  static const submitBarTextFontSize = fontSizeMd;
  static const submitBarTipPadding =
      const EdgeInsets.symmetric(vertical: paddingXs, horizontal: paddingSm);
  static const submitBarTipFontSize = fontSizeSm;
  static const submitBarTipLineHeight = 1.5;
  static const submitBarTipColor = Color(0xfff56723);
  static const submitBarTipBackgroundColor = Color(0xfffff7cc);
  static const submitBarTipIconSize = 12.0;
  static const submitBarButtonHeight = 40.0;
  static const submitBarPadding =
      const EdgeInsets.symmetric(vertical: 0.0, horizontal: paddingMd);
  static const submitBarPriceIntegerFontSize = 20.0;
  static const submitBarPriceFontFamily = priceIntegerFontFamily;

  // Swipe
  static const swipeIndicatorSize = 6.0;
  static const swipeIndicatorMargin = paddingSm;
  static const swipeIndicatorActiveOpacity = 1;
  static const swipeIndicatorInactiveOpacity = 0.3;
  static const swipeIndicatorActiveBackgroundColor = blue;
  static const swipeIndicatorInactiveBackgroundColor = borderColor;

  // Switch
  static const switchSize = 30.0;
  static const switchWidth = 2.0;
  static const switchHeight = 1.0;
  static const switchNodeSize = 1.0;
  static const switchNodeBackgroundColor = white;
  static final switchNodeBoxShadow = [
    BoxShadow(
      offset: Offset(0.0, 3.0),
      blurRadius: 1.0,
      spreadRadius: 0.0,
      color: Color.fromRGBO(0, 0, 0, 0.05),
    ),
    BoxShadow(
      offset: Offset(0.0, 2.0),
      blurRadius: 2.0,
      spreadRadius: 0.0,
      color: Color.fromRGBO(0, 0, 0, 0.1),
    ),
    BoxShadow(
      offset: Offset(0.0, 3.0),
      blurRadius: 3.0,
      spreadRadius: 0.0,
      color: Color.fromRGBO(0, 0, 0, 0.05),
    ),
  ];
  static const switchBackgroundColor = white;
  static const switchOnBackgroundColor = blue;
  static const switchTransitionDuration = animationDurationBase;
  static const switchDisabledOpacity = disabledOpacity;
  static final switchBorder = BorderSide(
    width: borderWidthBase,
    style: BorderStyle.solid,
    color: Color.fromRGBO(0, 0, 0, .1),
  );

  // Tabbar
  static const tabbarHeight = 50.0;
  static const tabbarZIndex = 1;
  static const tabbarBackgroundColor = white;

  // TabbarItem
  static const tabbarItemFontSize = fontSizeSm;
  static const tabbarItemTextColor = gray7;
  static const tabbarItemActiveColor = blue;
  static const tabbarItemActiveBackgroundColor = tabbarBackgroundColor;
  static const tabbarItemLineHeight = 1.0;
  static const tabbarItemIconSize = 22.0;
  static const tabbarItemMarginBottom = 4.0;

  // Tab
  static const tabTextColor = gray7;
  static const tabActiveTextColor = textColor;
  static const tabDisabledTextColor = gray5;
  static const tabFontSize = fontSizeMd;
  static const tabLineHeight = lineHeightMd;

  // Tabs
  static const tabsDefaultColor = red;
  static const tabsLineHeight = 44.0;
  static const tabsCardHeight = 30.0;
  static const tabsNavBackgroundColor = white;
  static const tabsBottomBarWidth = 40.0;
  static const tabsBottomBarHeight = 3.0;
  static const tabsBottomBarColor = tabsDefaultColor;

  // Tag
  static const tagPadding =
      const EdgeInsets.symmetric(vertical: 0, horizontal: paddingBase);
  static const tagTextColor = white;
  static const tagFontSize = fontSizeSm;
  static const tagBorderRadius = 2.0;
  static const tagLineHeight = 16.0;
  static const tagMediumPadding =
      const EdgeInsets.symmetric(vertical: 2.0, horizontal: 6.0);
  static const tagLargePadding =
      const EdgeInsets.symmetric(vertical: paddingBase, horizontal: paddingXs);
  static const tagLargeBorderRadius = borderRadiusMd;
  static const tagLargeFontSize = fontSizeMd;
  static const tagRoundBorderRadius = borderRadiusMax;
  static const tagDangerColor = red;
  static const tagPrimaryColor = blue;
  static const tagSuccessColor = green;
  static const tagWarningColor = orange;
  static const tagDefaultColor = gray6;
  static const tagPlainBackgroundColor = white;

  // Toast
  static const toastMaxWidth = .7;
  static const toastFontSize = fontSizeMd;
  static const toastTextColor = white;
  static const toastLoadingIconColor = white;
  static const toastLineHeight = lineHeightMd;
  static const toastBorderRadius = borderRadiusLg;
  static final toastBackgroundColor = black.withOpacity(.7);
  static const toastIconSize = 36.0;
  static const toastTextMinWidth = 96.0;
  static const toastTextPadding =
      const EdgeInsets.symmetric(vertical: paddingXs, horizontal: paddingSm);
  static const toastDefaultPadding = const EdgeInsets.all(paddingMd);
  static const toastDefaultWidth = 88.0;
  static const toastDefaultMinHeight = 88.0;
  static const toastPositionTopDistance = .2;
  static const toastPositionBottomDistance = .2;

  // TreeSelect
  static const treeSelectFontSize = fontSizeMd;
  static const treeSelectNavBackgroundColor = backgroundColor;
  static const treeSelectContentBackgroundColor = white;
  static const treeSelectNavItemPadding =
      const EdgeInsets.symmetric(vertical: 14.0, horizontal: paddingSm);
  static const treeSelectItemHeight = 48.0;
  static const treeSelectItemActiveColor = red;
  static const treeSelectItemDisabledColor = gray5;
  static const treeSelectItemSelectedSize = 16.0;

  // Uploader
  static const uploaderSize = 80.0;
  static const uploaderIconSize = 24.0;
  static const uploaderIconColor = gray4;
  static const uploaderTextColor = gray6;
  static const uploaderTextFontSize = fontSizeSm;
  static const uploaderUploadBackgroundColor = gray1;
  static const uploaderUploadActiveColor = activeColor;
  static const uploaderDeleteColor = white;
  static const uploaderDeleteIconSize = 14.0;
  static const uploaderDeleteBackgroundColor = Color.fromRGBO(0, 0, 0, 0.7);
  static const uploaderFileBackgroundColor = backgroundColor;
  static const uploaderFileIconSize = 20.0;
  static const uploaderFileIconColor = gray7;
  static const uploaderFileNamePadding =
      const EdgeInsets.symmetric(vertical: 0.0, horizontal: paddingBase);
  static const uploaderFileNameMarginTop = paddingXs;
  static const uploaderFileNameFontSize = fontSizeSm;
  static const uploaderFileNameTextColor = gray7;
  static final uploaderMaskBackgroundColor = gray8.withOpacity(.88);
  static const uploaderMaskIconSize = 22.0;
  static const uploaderMaskMessageFontSize = fontSizeSm;
  static const uploaderMaskMessageLineHeight = lineHeightXs;
  static const uploaderLoadingIconSize = 22.0;
  static const uploaderLoadingIconColor = white;
  static const uploaderDisabledOpacity = disabledOpacity;
}
