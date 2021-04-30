// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class FlanS {
  FlanS();

  static FlanS? _current;

  static FlanS get current {
    assert(_current != null,
        'No instance of FlanS was loaded. Try to initialize the FlanS delegate before accessing FlanS.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<FlanS> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = FlanS();
      FlanS._current = instance;

      return instance;
    });
  }

  static FlanS of(BuildContext context) {
    final instance = FlanS.maybeOf(context);
    assert(instance != null,
        'No instance of FlanS present in the widget tree. Did you add FlanS.delegate in localizationsDelegates?');
    return instance!;
  }

  static FlanS? maybeOf(BuildContext context) {
    return Localizations.of<FlanS>(context, FlanS);
  }

  /// `Name`
  String get name {
    return Intl.message(
      'Name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `Phone`
  String get tel {
    return Intl.message(
      'Phone',
      name: 'tel',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get confirm {
    return Intl.message(
      'Confirm',
      name: 'confirm',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message(
      'Delete',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `Complete`
  String get complete {
    return Intl.message(
      'Complete',
      name: 'complete',
      desc: '',
      args: [],
    );
  }

  /// `Loading...`
  String get loading {
    return Intl.message(
      'Loading...',
      name: 'loading',
      desc: '',
      args: [],
    );
  }

  /// `Please fill in the tel`
  String get telEmpty {
    return Intl.message(
      'Please fill in the tel',
      name: 'telEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Please fill in the name`
  String get nameEmpty {
    return Intl.message(
      'Please fill in the name',
      name: 'nameEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Malformed name`
  String get nameInvalid {
    return Intl.message(
      'Malformed name',
      name: 'nameInvalid',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete?`
  String get confirmDelete {
    return Intl.message(
      'Are you sure you want to delete?',
      name: 'confirmDelete',
      desc: '',
      args: [],
    );
  }

  /// `Malformed phone number`
  String get telInvalid {
    return Intl.message(
      'Malformed phone number',
      name: 'telInvalid',
      desc: '',
      args: [],
    );
  }

  /// `End`
  String get Calendar_end {
    return Intl.message(
      'End',
      name: 'Calendar_end',
      desc: '',
      args: [],
    );
  }

  /// `Start`
  String get Calendar_start {
    return Intl.message(
      'Start',
      name: 'Calendar_start',
      desc: '',
      args: [],
    );
  }

  /// `Calendar`
  String get Calendar_title {
    return Intl.message(
      'Calendar',
      name: 'Calendar_title',
      desc: '',
      args: [],
    );
  }

  /// `Start/End`
  String get Calendar_startEnd {
    return Intl.message(
      'Start/End',
      name: 'Calendar_startEnd',
      desc: '',
      args: [],
    );
  }

  /// `Sun`
  String get Calendar_weekdays_Sun {
    return Intl.message(
      'Sun',
      name: 'Calendar_weekdays_Sun',
      desc: '',
      args: [],
    );
  }

  /// `Mon`
  String get Calendar_weekdays_Mon {
    return Intl.message(
      'Mon',
      name: 'Calendar_weekdays_Mon',
      desc: '',
      args: [],
    );
  }

  /// `Tue`
  String get Calendar_weekdays_Tue {
    return Intl.message(
      'Tue',
      name: 'Calendar_weekdays_Tue',
      desc: '',
      args: [],
    );
  }

  /// `Wed`
  String get Calendar_weekdays_Wed {
    return Intl.message(
      'Wed',
      name: 'Calendar_weekdays_Wed',
      desc: '',
      args: [],
    );
  }

  /// `Thu`
  String get Calendar_weekdays_Thu {
    return Intl.message(
      'Thu',
      name: 'Calendar_weekdays_Thu',
      desc: '',
      args: [],
    );
  }

  /// `Fri`
  String get Calendar_weekdays_Fri {
    return Intl.message(
      'Fri',
      name: 'Calendar_weekdays_Fri',
      desc: '',
      args: [],
    );
  }

  /// `Sat`
  String get Calendar_weekdays_Sat {
    return Intl.message(
      'Sat',
      name: 'Calendar_weekdays_Sat',
      desc: '',
      args: [],
    );
  }

  /// `{year}/{month}`
  String Calendar_monthTitle(Object year, Object month) {
    return Intl.message(
      '$year/$month',
      name: 'Calendar_monthTitle',
      desc: '',
      args: [year, month],
    );
  }

  /// `Choose no more than {maxRange} days`
  String Calendar_rangePrompt(Object maxRange) {
    return Intl.message(
      'Choose no more than $maxRange days',
      name: 'Calendar_rangePrompt',
      desc: '',
      args: [maxRange],
    );
  }

  /// `Select`
  String get Cascader_select {
    return Intl.message(
      'Select',
      name: 'Cascader_select',
      desc: '',
      args: [],
    );
  }

  /// `Add contact info`
  String get ContactCard_addText {
    return Intl.message(
      'Add contact info',
      name: 'ContactCard_addText',
      desc: '',
      args: [],
    );
  }

  /// `Add new contact`
  String get ContactList_addText {
    return Intl.message(
      'Add new contact',
      name: 'ContactList_addText',
      desc: '',
      args: [],
    );
  }

  /// `Previous`
  String get Pagination_prev {
    return Intl.message(
      'Previous',
      name: 'Pagination_prev',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get Pagination_next {
    return Intl.message(
      'Next',
      name: 'Pagination_next',
      desc: '',
      args: [],
    );
  }

  /// `Pull to refresh...`
  String get PullRefresh_pulling {
    return Intl.message(
      'Pull to refresh...',
      name: 'PullRefresh_pulling',
      desc: '',
      args: [],
    );
  }

  /// `Loose to refresh...`
  String get PullRefresh_loosing {
    return Intl.message(
      'Loose to refresh...',
      name: 'PullRefresh_loosing',
      desc: '',
      args: [],
    );
  }

  /// `Total：`
  String get SubmitBar_label {
    return Intl.message(
      'Total：',
      name: 'SubmitBar_label',
      desc: '',
      args: [],
    );
  }

  /// `Unlimited`
  String get Coupon_unlimited {
    return Intl.message(
      'Unlimited',
      name: 'Coupon_unlimited',
      desc: '',
      args: [],
    );
  }

  /// `{discount}% off`
  String Coupon_discount(Object discount) {
    return Intl.message(
      '$discount% off',
      name: 'Coupon_discount',
      desc: '',
      args: [discount],
    );
  }

  /// `At least {condition}`
  String Coupon_condition(Object condition) {
    return Intl.message(
      'At least $condition',
      name: 'Coupon_condition',
      desc: '',
      args: [condition],
    );
  }

  /// `Coupon`
  String get CouponCell_title {
    return Intl.message(
      'Coupon',
      name: 'CouponCell_title',
      desc: '',
      args: [],
    );
  }

  /// `No coupons`
  String get CouponCell_tips {
    return Intl.message(
      'No coupons',
      name: 'CouponCell_tips',
      desc: '',
      args: [],
    );
  }

  /// `You have {count} coupons`
  String CouponCell_count(Object count) {
    return Intl.message(
      'You have $count coupons',
      name: 'CouponCell_count',
      desc: '',
      args: [count],
    );
  }

  /// `No coupons`
  String get CouponList_empty {
    return Intl.message(
      'No coupons',
      name: 'CouponList_empty',
      desc: '',
      args: [],
    );
  }

  /// `Exchange`
  String get CouponList_exchange {
    return Intl.message(
      'Exchange',
      name: 'CouponList_exchange',
      desc: '',
      args: [],
    );
  }

  /// `Close`
  String get CouponList_close {
    return Intl.message(
      'Close',
      name: 'CouponList_close',
      desc: '',
      args: [],
    );
  }

  /// `Available`
  String get CouponList_enable {
    return Intl.message(
      'Available',
      name: 'CouponList_enable',
      desc: '',
      args: [],
    );
  }

  /// `Unavailable`
  String get CouponList_disabled {
    return Intl.message(
      'Unavailable',
      name: 'CouponList_disabled',
      desc: '',
      args: [],
    );
  }

  /// `Coupon code`
  String get CouponList_placeholder {
    return Intl.message(
      'Coupon code',
      name: 'CouponList_placeholder',
      desc: '',
      args: [],
    );
  }

  /// `Area`
  String get AddressEdit_area {
    return Intl.message(
      'Area',
      name: 'AddressEdit_area',
      desc: '',
      args: [],
    );
  }

  /// `Please select a receiving area`
  String get AddressEdit_areaEmpty {
    return Intl.message(
      'Please select a receiving area',
      name: 'AddressEdit_areaEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Postal`
  String get AddressEdit_postal {
    return Intl.message(
      'Postal',
      name: 'AddressEdit_postal',
      desc: '',
      args: [],
    );
  }

  /// `Address can not be empty`
  String get AddressEdit_addressEmpty {
    return Intl.message(
      'Address can not be empty',
      name: 'AddressEdit_addressEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Wrong postal code`
  String get AddressEdit_postalEmpty {
    return Intl.message(
      'Wrong postal code',
      name: 'AddressEdit_postalEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Set as the default address`
  String get AddressEdit_defaultAddress {
    return Intl.message(
      'Set as the default address',
      name: 'AddressEdit_defaultAddress',
      desc: '',
      args: [],
    );
  }

  /// `Phone`
  String get AddressEdit_telPlaceholder {
    return Intl.message(
      'Phone',
      name: 'AddressEdit_telPlaceholder',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get AddressEdit_namePlaceholder {
    return Intl.message(
      'Name',
      name: 'AddressEdit_namePlaceholder',
      desc: '',
      args: [],
    );
  }

  /// `Area`
  String get AddressEdit_areaPlaceholder {
    return Intl.message(
      'Area',
      name: 'AddressEdit_areaPlaceholder',
      desc: '',
      args: [],
    );
  }

  /// `Address`
  String get AddressEditDetail_label {
    return Intl.message(
      'Address',
      name: 'AddressEditDetail_label',
      desc: '',
      args: [],
    );
  }

  /// `Address`
  String get AddressEditDetail_placeholder {
    return Intl.message(
      'Address',
      name: 'AddressEditDetail_placeholder',
      desc: '',
      args: [],
    );
  }

  /// `Add new address`
  String get AddressList_add {
    return Intl.message(
      'Add new address',
      name: 'AddressList_add',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<FlanS> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'zh'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<FlanS> load(Locale locale) => FlanS.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
