import 'package:flutter/material.dart';

class ThemeVars {
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
  // static const gradientRed= linear-gradient(to right, #ff6034, #ee0a24);
  // static const @gradientOrange= linear-gradient(to right, #ffd01e, #ff8917);

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
  // @base-font-family= -apple-system, BlinkMacSystemFont, 'Helvetica Neue',
  //   Helvetica, Segoe UI, Arial, Roboto, 'PingFang SC', 'miui', 'Hiragino Sans GB',
  //   'Microsoft Yahei', sans-serif;
  // @price-integer-font-family= Avenir-Heavy, PingFang SC, Helvetica Neue, Arial,
  //   sans-serif;

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

  // // ActionSheet
  // @action-sheet-max-height= 80%;
  // @action-sheet-header-height= 48px;
  // @action-sheet-header-font-size= @font-size-lg;
  // @action-sheet-description-color= @gray-6;
  // @action-sheet-description-font-size= @font-size-md;
  // @action-sheet-description-line-height= @line-height-md;
  // @action-sheet-item-background= @white;
  // @action-sheet-item-font-size= @font-size-lg;
  // @action-sheet-item-line-height= @line-height-lg;
  // @action-sheet-item-text-color= @text-color;
  // @action-sheet-item-disabled-text-color= @gray-5;
  // @action-sheet-subname-color= @gray-6;
  // @action-sheet-subname-font-size= @font-size-sm;
  // @action-sheet-subname-line-height= @line-height-sm;
  // @action-sheet-close-icon-size= 22px;
  // @action-sheet-close-icon-color= @gray-5;
  // @action-sheet-close-icon-active-color= @gray-6;
  // @action-sheet-close-icon-padding= 0 @padding-md;
  // @action-sheet-cancel-text-color= @gray-7;
  // @action-sheet-cancel-padding-top= @padding-xs;
  // @action-sheet-cancel-padding-color= @background-color;
  // @action-sheet-loading-icon-size= 22px;

  // // AddressEdit
  // @address-edit-padding= @padding-sm;
  // @address-edit-buttons-padding= @padding-xl @padding-base;
  // @address-edit-button-margin-bottom= @padding-sm;
  // @address-edit-detail-finish-color= @blue;
  // @address-edit-detail-finish-font-size= @font-size-sm;

  // // AddressList
  // @address-list-padding= @padding-sm @padding-sm 80px;
  // @address-list-disabled-text-color= @gray-6;
  // @address-list-disabled-text-padding= @padding-base * 5 0 @padding-md;
  // @address-list-disabled-text-font-size= @font-size-md;
  // @address-list-disabled-text-line-height= @line-height-md;
  // @address-list-add-button-z-index= 999;
  // @address-list-item-padding= @padding-sm;
  // @address-list-item-text-color= @text-color;
  // @address-list-item-disabled-text-color= @gray-5;
  // @address-list-item-font-size= 13px;
  // @address-list-item-line-height= @line-height-sm;
  // @address-list-item-radio-icon-color= @red;
  // @address-list-edit-icon-size= 20px;

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
  // static const badgeFontFamily= -apple-system-font, Helvetica Neue, Arial, sans-serif;

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

  // // Calendar
  // @calendar-background-color= @white;
  // @calendar-popup-height= 80%;
  // @calendar-header-box-shadow= 0 2px 10px rgba(125, 126, 128, 0.16);
  // @calendar-header-title-height= 44px;
  // @calendar-header-title-font-size= @font-size-lg;
  // @calendar-header-subtitle-font-size= @font-size-md;
  // @calendar-weekdays-height= 30px;
  // @calendar-weekdays-font-size= @font-size-sm;
  // @calendar-month-title-font-size= @font-size-md;
  // @calendar-month-mark-color= fade(@gray-2, 80%);
  // @calendar-month-mark-font-size= 160px;
  // @calendar-day-height= 64px;
  // @calendar-day-font-size= @font-size-lg;
  // @calendar-range-edge-color= @white;
  // @calendar-range-edge-background-color= @red;
  // @calendar-range-middle-color= @red;
  // @calendar-range-middle-background-opacity= 0.1;
  // @calendar-selected-day-size= 54px;
  // @calendar-selected-day-color= @white;
  // @calendar-info-font-size= @font-size-xs;
  // @calendar-info-line-height= @line-height-xs;
  // @calendar-selected-day-background-color= @red;
  // @calendar-day-disabled-color= @gray-5;
  // @calendar-confirm-button-height= 36px;
  // @calendar-confirm-button-margin= 7px 0;

  // // Card
  // @card-padding= @padding-xs @padding-md;
  // @card-font-size= @font-size-sm;
  // @card-text-color= @text-color;
  // @card-background-color= @background-color-light;
  // @card-thumb-size= 88px;
  // @card-thumb-border-radius= @border-radius-lg;
  // @card-title-line-height= 16px;
  // @card-desc-color= @gray-7;
  // @card-desc-line-height= @line-height-md;
  // @card-price-color= @gray-8;
  // @card-origin-price-color= @gray-6;
  // @card-num-color= @gray-6;
  // @card-origin-price-font-size= @font-size-xs;
  // @card-price-font-size= @font-size-sm;
  // @card-price-integer-font-size= @font-size-lg;
  // @card-price-font-family= @price-integer-font-family;

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

  // // Collapse
  // @collapse-item-transition-duration= @animation-duration-base;
  // @collapse-item-content-padding= @padding-sm @padding-md;
  // @collapse-item-content-font-size= @font-size-md;
  // @collapse-item-content-line-height= 1.5;
  // @collapse-item-content-text-color= @gray-6;
  // @collapse-item-content-background-color= @white;
  // @collapse-item-title-disabled-color= @gray-5;

  // // ContactCard
  // @contact-card-padding= @padding-md;
  // @contact-card-add-icon-size= 40px;
  // @contact-card-add-icon-color= @blue;
  // @contact-card-value-line-height= @line-height-md;

  // // ContactEdit
  // @contact-edit-padding= @padding-md;
  // @contact-edit-fields-radius= @border-radius-md;
  // @contact-edit-buttons-padding= @padding-xl 0;
  // @contact-edit-button-margin-bottom= @padding-sm;
  // @contact-edit-button-font-size= 16px;
  // @contact-edit-field-label-width= 4.1em;

  // // ContactList
  // @contact-list-edit-icon-size= 16px;
  // @contact-list-add-button-z-index= 999;
  // @contact-list-item-padding= @padding-md;

  // // CountDown
  // @count-down-text-color= @text-color;
  // @count-down-font-size= @font-size-md;
  // @count-down-line-height= @line-height-md;

  // // Coupon
  // @coupon-margin= 0 @padding-sm @padding-sm;
  // @coupon-content-height= 84px;
  // @coupon-content-padding= 14px 0;
  // @coupon-background-color= @white;
  // @coupon-active-background-color= @active-color;
  // @coupon-border-radius= @border-radius-lg;
  // @coupon-box-shadow= 0 0 4px rgba(0, 0, 0, 0.1);
  // @coupon-head-width= 96px;
  // @coupon-amount-color= @red;
  // @coupon-amount-font-size= 30px;
  // @coupon-currency-font-size= 40%;
  // @coupon-name-font-size= @font-size-md;
  // @coupon-disabled-text-color= @gray-6;
  // @coupon-description-padding= @padding-xs @padding-md;
  // @coupon-description-border-color= @border-color;

  // // CouponCell
  // @coupon-cell-selected-text-color= @text-color;

  // // CouponList
  // @coupon-list-background-color= @background-color;
  // @coupon-list-field-padding= 5px 0 5px @padding-md;
  // @coupon-list-exchange-button-height= 32px;
  // @coupon-list-close-button-height= 40px;
  // @coupon-list-empty-image-size= 200px;
  // @coupon-list-empty-tip-color= @gray-6;
  // @coupon-list-empty-tip-font-size= @font-size-md;
  // @coupon-list-empty-tip-line-height= @line-height-md;

  // // Dialog
  // @dialog-width= 320px;
  // @dialog-small-screen-width= 90%;
  // @dialog-font-size= @font-size-lg;
  // @dialog-transition= @animation-duration-base;
  // @dialog-border-radius= 16px;
  // @dialog-background-color= @white;
  // @dialog-header-font-weight= @font-weight-bold;
  // @dialog-header-line-height= 24px;
  // @dialog-header-padding-top= 26px;
  // @dialog-header-isolated-padding= @padding-lg 0;
  // @dialog-message-padding= @padding-lg;
  // @dialog-message-font-size= @font-size-md;
  // @dialog-message-line-height= @line-height-md;
  // @dialog-message-max-height= 60vh;
  // @dialog-has-title-message-text-color= @gray-7;
  // @dialog-has-title-message-padding-top= @padding-xs;
  // @dialog-button-height= 48px;
  // @dialog-round-button-height= 36px;
  // @dialog-confirm-button-text-color= @red;

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

  // // DropdownMenu
  // @dropdown-menu-height= 48px;
  // @dropdown-menu-background-color= @white;
  // @dropdown-menu-box-shadow= 0 2px 12px fade(@gray-7, 12);
  // @dropdown-menu-title-font-size= 15px;
  // @dropdown-menu-title-text-color= @text-color;
  // @dropdown-menu-title-active-text-color= @red;
  // @dropdown-menu-title-disabled-text-color= @gray-6;
  // @dropdown-menu-title-padding= 0 @padding-xs;
  // @dropdown-menu-title-line-height= @line-height-lg;
  // @dropdown-menu-option-active-color= @red;
  // @dropdown-menu-content-max-height= 80%;
  // @dropdown-item-z-index= 10;

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

  // // Field
  // @field-label-width= 6.2em;
  // @field-label-color= @gray-7;
  // @field-label-margin-right= @padding-sm;
  // @field-input-text-color= @text-color;
  // @field-input-error-text-color= @red;
  // @field-input-disabled-text-color= @gray-5;
  // @field-placeholder-text-color= @gray-5;
  // @field-icon-size= 16px;
  // @field-clear-icon-size= 16px;
  // @field-clear-icon-color= @gray-5;
  // @field-right-icon-color= @gray-6;
  // @field-error-message-color= @red;
  // @field-error-message-text-color= 12px;
  // @field-text-area-min-height= 60px;
  // @field-word-limit-color= @gray-7;
  // @field-word-limit-font-size= @font-size-sm;
  // @field-word-limit-line-height= 16px;
  // @field-disabled-text-color= @gray-5;

  // // GridItem
  // @grid-item-content-padding= @padding-md @padding-xs;
  // @grid-item-content-background-color= @white;
  // @grid-item-content-active-color= @active-color;
  // @grid-item-icon-size= 28px;
  // @grid-item-text-color= @gray-7;
  // @grid-item-text-font-size= @font-size-sm;

  // // ActionBar
  // @action-bar-background-color= @white;
  // @action-bar-height= 50px;
  // @action-bar-icon-width= 48px;
  // @action-bar-icon-height= 100%;
  // @action-bar-icon-color= @text-color;
  // @action-bar-icon-size= 18px;
  // @action-bar-icon-font-size= @font-size-xs;
  // @action-bar-icon-active-color= @active-color;
  // @action-bar-icon-text-color= @gray-7;
  // @action-bar-button-height= 40px;
  // @action-bar-button-warning-color= @gradient-orange;
  // @action-bar-button-danger-color= @gradient-red;

  // // IndexAnchor
  // @index-anchor-z-index= 1;
  // @index-anchor-padding= 0 @padding-md;
  // @index-anchor-text-color= @text-color;
  // @index-anchor-font-weight= @font-weight-bold;
  // @index-anchor-font-size= @font-size-md;
  // @index-anchor-line-height= 32px;
  // @index-anchor-background-color= transparent;
  // @index-anchor-sticky-text-color= @green;
  // @index-anchor-sticky-background-color= @white;

  // // IndexBar
  // @index-bar-sidebar-z-index= 2;
  // @index-bar-index-font-size= @font-size-xs;
  // @index-bar-index-line-height= @line-height-xs;
  // @index-bar-index-active-color= @green;

  // Image
  static const imagePlaceholderTextColor = gray6;
  static const imagePlaceholderFontSize = fontSizeMd;
  static const imagePlaceholderBackgroundColor = backgroundColor;
  static const imageLoadingIconSize = 32.0;
  static const imageLoadingIconColor = gray4;
  static const imageErrorIconSize = 32.0;
  static const imageErrorIconColor = gray4;

  // // ImagePreview
  // @image-preview-index-text-color= @white;
  // @image-preview-index-font-size= @font-size-md;
  // @image-preview-index-line-height= @line-height-md;
  // @image-preview-index-text-shadow= 0 1px 1px @gray-8;
  // @image-preview-overlay-background-color= rgba(0, 0, 0, 0.9);
  // @image-preview-close-icon-size= 22px;
  // @image-preview-close-icon-color= @gray-5;
  // @image-preview-close-icon-active-color= @gray-6;
  // @image-preview-close-icon-margin= @padding-md;
  // @image-preview-close-icon-z-index= 1;

  // // List
  // @list-icon-margin-right= 5px;
  // @list-text-color= @gray-6;
  // @list-text-font-size= @font-size-md;
  // @list-text-line-height= 50px;

  // // Loading
  static const loadingTextColor = gray6;
  static const loadingTextFontSize = fontSizeMd;
  static const loadingSpinnerColor = gray5;
  static const loadingSpinnerSize = 30.0;
  static const loadingSpinnerAnimationDuration =
      const Duration(milliseconds: 800);

  // // NavBar
  // @nav-bar-height= 46px;
  // @nav-bar-background-color= @white;
  // @nav-bar-arrow-size= 16px;
  // @nav-bar-icon-color= @blue;
  // @nav-bar-text-color= @blue;
  // @nav-bar-title-font-size= @font-size-lg;
  // @nav-bar-title-text-color= @text-color;
  // @nav-bar-z-index= 1;

  // // NoticeBar
  // @notice-bar-height= 40px;
  // @notice-bar-padding= 0 @padding-md;
  // @notice-bar-wrapable-padding= @padding-xs @padding-md;
  // @notice-bar-text-color= @orange-dark;
  // @notice-bar-font-size= @font-size-md;
  // @notice-bar-line-height= 24px;
  // @notice-bar-background-color= @orange-light;
  // @notice-bar-icon-size= 16px;
  // @notice-bar-icon-min-width= 24px;

  // // Notify
  // @notify-text-color= @white;
  // @notify-padding= @padding-xs @padding-md;
  // @notify-font-size= @font-size-md;
  // @notify-line-height= @line-height-md;
  // @notify-primary-background-color= @blue;
  // @notify-success-background-color= @green;
  // @notify-danger-background-color= @red;
  // @notify-warning-background-color= @orange;

  // // NumberKeyboard
  // @number-keyboard-background-color= @gray-2;
  // @number-keyboard-key-height= 48px;
  // @number-keyboard-key-font-size= 28px;
  // @number-keyboard-key-active-color= @gray-3;
  // @number-keyboard-delete-font-size= @font-size-lg;
  // @number-keyboard-title-color= @gray-7;
  // @number-keyboard-title-height= 34px;
  // @number-keyboard-title-font-size= @font-size-lg;
  // @number-keyboard-close-padding= 0 @padding-md;
  // @number-keyboard-close-color= @text-link-color;
  // @number-keyboard-close-font-size= @font-size-md;
  // @number-keyboard-button-text-color= @white;
  // @number-keyboard-button-background-color= @blue;
  // @number-keyboard-cursor-color= @text-color;
  // @number-keyboard-cursor-width= 1px;
  // @number-keyboard-cursor-height= 40%;
  // @number-keyboard-cursor-animation-duration= 1s;
  // @number-keyboard-z-index= 100;

  // Overlay
  static const overlayZIndex = 1;
  static const overlayBackgroundColor = Color.fromRGBO(0, 0, 0, .7);

  // // Pagination
  // @pagination-height= 40px;
  // @pagination-font-size= @font-size-md;
  // @pagination-item-width= 36px;
  // @pagination-item-default-color= @blue;
  // @pagination-item-disabled-color= @gray-7;
  // @pagination-item-disabled-background-color= @background-color;
  // @pagination-background-color= @white;
  // @pagination-desc-color= @gray-7;
  // @pagination-disabled-opacity= @disabled-opacity;

  // // PasswordInput
  // @password-input-height= 50px;
  // @password-input-margin= 0 @padding-md;
  // @password-input-font-size= 20px;
  // @password-input-border-radius= 6px;
  // @password-input-background-color= @white;
  // @password-input-info-color= @gray-6;
  // @password-input-info-font-size= @font-size-md;
  // @password-input-error-info-color= @red;
  // @password-input-dot-size= 10px;
  // @password-input-dot-color= @black;

  // // Picker
  // @picker-background-color= @white;
  // @picker-toolbar-height= 44px;
  // @picker-title-font-size= @font-size-lg;
  // @picker-title-line-height= @line-height-md;
  // @picker-action-padding= 0 @padding-md;
  // @picker-action-font-size= @font-size-md;
  // @picker-confirm-action-color= @text-link-color;
  // @picker-cancel-action-color= @gray-6;
  // @picker-option-font-size= @font-size-lg;
  // @picker-option-text-color= @black;
  // @picker-option-disabled-opacity= 0.3;
  // @picker-loading-icon-color= @blue;
  // @picker-loading-mask-color= rgba(255, 255, 255, 0.9);

  // // Popover
  // @popover-arrow-size= 6px;
  // @popover-border-radius= @border-radius-lg;
  // @popover-action-width= 128px;
  // @popover-action-height= 44px;
  // @popover-action-font-size= @font-size-md;
  // @popover-action-line-height= @line-height-md;
  // @popover-action-icon-size= 20px;
  // @popover-light-text-color= @text-color;
  // @popover-light-background-color= @white;
  // @popover-light-action-disabled-text-color= @gray-5;
  // @popover-dark-text-color= @white;
  // @popover-dark-background-color= #4a4a4a;
  // @popover-dark-action-disabled-text-color= @gray-6;

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

  // // PullRefresh
  // @pull-refresh-head-height= 50px;
  // @pull-refresh-head-font-size= @font-size-md;
  // @pull-refresh-head-text-color= @gray-6;

  // // Radio
  // @radio-size= 20px;
  // @radio-border-color= @gray-5;
  // @radio-transition-duration= @animation-duration-fast;
  // @radio-label-margin= @padding-xs;
  // @radio-label-color= @text-color;
  // @radio-checked-icon-color= @blue;
  // @radio-disabled-icon-color= @gray-5;
  // @radio-disabled-label-color= @gray-5;
  // @radio-disabled-background-color= @border-color;

  // // Rate
  // @rate-icon-size= 20px;
  // @rate-icon-gutter= @padding-base;
  // @rate-icon-void-color= @gray-5;
  // @rate-icon-full-color= @red;
  // @rate-icon-disabled-color= @gray-5;

  // // ShareSheet
  // @share-sheet-header-padding= @padding-sm @padding-md @padding-base;
  // @share-sheet-title-color= @text-color;
  // @share-sheet-title-font-size= @font-size-md;
  // @share-sheet-title-line-height= @line-height-md;
  // @share-sheet-description-color= @gray-6;
  // @share-sheet-description-font-size= @font-size-sm;
  // @share-sheet-description-line-height= 16px;
  // @share-sheet-icon-size= 48px;
  // @share-sheet-option-name-color= @gray-7;
  // @share-sheet-option-name-font-size= @font-size-sm;
  // @share-sheet-option-description-color= @gray-5;
  // @share-sheet-option-description-font-size= @font-size-sm;
  // @share-sheet-cancel-button-font-size= @font-size-lg;
  // @share-sheet-cancel-button-height= 48px;
  // @share-sheet-cancel-button-background= @white;

  // // Search
  // @search-padding= 10px @padding-sm;
  // @search-background-color= @white;
  // @search-content-background-color= @gray-1;
  // @search-input-height= 34px;
  // @search-label-padding= 0 5px;
  // @search-label-color= @text-color;
  // @search-label-font-size= @font-size-md;
  // @search-left-icon-color= @gray-6;
  // @search-action-padding= 0 @padding-xs;
  // @search-action-text-color= @text-color;
  // @search-action-font-size= @font-size-md;

  // // Sidebar
  // @sidebar-width= 80px;
  // @sidebar-font-size= @font-size-md;
  // @sidebar-line-height= @line-height-md;
  // @sidebar-text-color= @text-color;
  // @sidebar-disabled-text-color= @gray-5;
  // @sidebar-padding= 20px @padding-sm;
  // @sidebar-active-color= @active-color;
  // @sidebar-background-color= @background-color;
  // @sidebar-selected-font-weight= @font-weight-bold;
  // @sidebar-selected-text-color= @text-color;
  // @sidebar-selected-border-width= 4px;
  // @sidebar-selected-border-height= 16px;
  // @sidebar-selected-border-color= @red;
  // @sidebar-selected-background-color= @white;

  // // Skeleton
  static const skeletonRowHeight = 16.0;
  static const skeletonRowBackgroundColor = activeColor;
  static const skeletonRowMarginTop = paddingSm;
  static const skeletonTitleWidth = .4;
  static const skeletonAvatarSize = 32.0;
  static const skeletonAvatarBackgroundColor = activeColor;
  static const skeletonAnimationDuration = Duration(milliseconds: 1200);

  // // Slider
  // @slider-active-background-color= @blue;
  // @slider-inactive-background-color= @gray-3;
  // @slider-disabled-opacity= @disabled-opacity;
  // @slider-bar-height= 2px;
  // @slider-button-width= 24px;
  // @slider-button-height= 24px;
  // @slider-button-border-radius= 50%;
  // @slider-button-background-color= @white;
  // @slider-button-box-shadow= 0 1px 2px rgba(0, 0, 0, 0.5);

  // // Step
  // @step-text-color= @gray-6;
  // @step-active-color= @green;
  // @step-process-text-color= @text-color;
  // @step-font-size= @font-size-md;
  // @step-line-color= @border-color;
  // @step-finish-line-color= @green;
  // @step-finish-text-color= @text-color;
  // @step-icon-size= 12px;
  // @step-circle-size= 5px;
  // @step-circle-color= @gray-6;
  // @step-horizontal-title-font-size= @font-size-sm;

  // // Steps
  // @steps-background-color= @white;

  // // Sticky
  // @sticky-z-index= 99;

  // // Stepper
  // @stepper-active-color= #e8e8e8;
  // @stepper-background-color= @active-color;
  // @stepper-button-icon-color= @text-color;
  // @stepper-button-disabled-color= @background-color;
  // @stepper-button-disabled-icon-color= @gray-5;
  // @stepper-button-round-theme-color= @red;
  // @stepper-input-width= 32px;
  // @stepper-input-height= 28px;
  // @stepper-input-font-size= @font-size-md;
  // @stepper-input-line-height= normal;
  // @stepper-input-text-color= @text-color;
  // @stepper-input-disabled-text-color= @gray-5;
  // @stepper-input-disabled-background-color= @active-color;
  // @stepper-border-radius= @border-radius-md;

  // // SubmitBar
  // @submit-bar-height= 50px;
  // @submit-bar-z-index= 100;
  // @submit-bar-background-color= @white;
  // @submit-bar-button-width= 110px;
  // @submit-bar-price-color= @red;
  // @submit-bar-price-font-size= @font-size-md;
  // @submit-bar-currency-font-size= @font-size-md;
  // @submit-bar-text-color= @text-color;
  // @submit-bar-text-font-size= @font-size-md;
  // @submit-bar-tip-padding= @padding-xs @padding-sm;
  // @submit-bar-tip-font-size= @font-size-sm;
  // @submit-bar-tip-line-height= 1.5;
  // @submit-bar-tip-color= #f56723;
  // @submit-bar-tip-background-color= #fff7cc;
  // @submit-bar-tip-icon-size= 12px;
  // @submit-bar-button-height= 40px;
  // @submit-bar-padding= 0 @padding-md;
  // @submit-bar-price-integer-font-size= 20px;
  // @submit-bar-price-font-family= @price-integer-font-family;

  // // Swipe
  // @swipe-indicator-size= 6px;
  // @swipe-indicator-margin= @padding-sm;
  // @swipe-indicator-active-opacity= 1;
  // @swipe-indicator-inactive-opacity= 0.3;
  // @swipe-indicator-active-background-color= @blue;
  // @swipe-indicator-inactive-background-color= @border-color;

  // // Switch
  // @switch-size= 30px;
  // @switch-width= 2em;
  // @switch-height= 1em;
  // @switch-node-size= 1em;
  // @switch-node-background-color= @white;
  // @switch-node-box-shadow= 0 3px 1px 0 rgba(0, 0, 0, 0.05),
  //   0 2px 2px 0 rgba(0, 0, 0, 0.1), 0 3px 3px 0 rgba(0, 0, 0, 0.05);
  // @switch-background-color= @white;
  // @switch-on-background-color= @blue;
  // @switch-transition-duration= @animation-duration-base;
  // @switch-disabled-opacity= @disabled-opacity;
  // @switch-border= @border-width-base solid rgba(0, 0, 0, 0.1);

  // // Tabbar
  // @tabbar-height= 50px;
  // @tabbar-z-index= 1;
  // @tabbar-background-color= @white;

  // // TabbarItem
  // @tabbar-item-font-size= @font-size-sm;
  // @tabbar-item-text-color= @gray-7;
  // @tabbar-item-active-color= @blue;
  // @tabbar-item-active-background-color= @tabbar-background-color;
  // @tabbar-item-line-height= 1;
  // @tabbar-item-icon-size= 22px;
  // @tabbar-item-margin-bottom= 4px;

  // // Tab
  // @tab-text-color= @gray-7;
  // @tab-active-text-color= @text-color;
  // @tab-disabled-text-color= @gray-5;
  // @tab-font-size= @font-size-md;
  // @tab-line-height= @line-height-md;

  // // Tabs
  // @tabs-default-color= @red;
  // @tabs-line-height= 44px;
  // @tabs-card-height= 30px;
  // @tabs-nav-background-color= @white;
  // @tabs-bottom-bar-width= 40px;
  // @tabs-bottom-bar-height= 3px;
  // @tabs-bottom-bar-color= @tabs-default-color;

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

  // // TreeSelect
  // @tree-select-font-size= @font-size-md;
  // @tree-select-nav-background-color= @background-color;
  // @tree-select-content-background-color= @white;
  // @tree-select-nav-item-padding= 14px @padding-sm;
  // @tree-select-item-height= 48px;
  // @tree-select-item-active-color= @red;
  // @tree-select-item-disabled-color= @gray-5;
  // @tree-select-item-selected-size= 16px;

  // // Uploader
  // @uploader-size= 80px;
  // @uploader-icon-size= 24px;
  // @uploader-icon-color= @gray-4;
  // @uploader-text-color= @gray-6;
  // @uploader-text-font-size= @font-size-sm;
  // @uploader-upload-background-color= @gray-1;
  // @uploader-upload-active-color= @active-color;
  // @uploader-delete-color= @white;
  // @uploader-delete-icon-size= 14px;
  // @uploader-delete-background-color= rgba(0, 0, 0, 0.7);
  // @uploader-file-background-color= @background-color;
  // @uploader-file-icon-size= 20px;
  // @uploader-file-icon-color= @gray-7;
  // @uploader-file-name-padding= 0 @padding-base;
  // @uploader-file-name-margin-top= @padding-xs;
  // @uploader-file-name-font-size= @font-size-sm;
  // @uploader-file-name-text-color= @gray-7;
  // @uploader-mask-background-color= fade(@gray-8, 88%);
  // @uploader-mask-icon-size= 22px;
  // @uploader-mask-message-font-size= @font-size-sm;
  // @uploader-mask-message-line-height= @line-height-xs;
  // @uploader-loading-icon-size= 22px;
  // @uploader-loading-icon-color= @white;
  // @uploader-disabled-opacity= @disabled-opacity;
}
