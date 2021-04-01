// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static m0(year, month) => "${year}/${month}";

  static m1(maxRange) => "Choose no more than ${maxRange} days";

  static m2(count) => "You have ${count} coupons";

  static m3(condition) => "At least ${condition}";

  static m4(discount) => "${discount}% off";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "AddressEditDetail_label" : MessageLookupByLibrary.simpleMessage("Address"),
    "AddressEditDetail_placeholder" : MessageLookupByLibrary.simpleMessage("Address"),
    "AddressEdit_addressEmpty" : MessageLookupByLibrary.simpleMessage("Address can not be empty"),
    "AddressEdit_area" : MessageLookupByLibrary.simpleMessage("Area"),
    "AddressEdit_areaEmpty" : MessageLookupByLibrary.simpleMessage("Please select a receiving area"),
    "AddressEdit_areaPlaceholder" : MessageLookupByLibrary.simpleMessage("Area"),
    "AddressEdit_defaultAddress" : MessageLookupByLibrary.simpleMessage("Set as the default address"),
    "AddressEdit_namePlaceholder" : MessageLookupByLibrary.simpleMessage("Name"),
    "AddressEdit_postal" : MessageLookupByLibrary.simpleMessage("Postal"),
    "AddressEdit_postalEmpty" : MessageLookupByLibrary.simpleMessage("Wrong postal code"),
    "AddressEdit_telPlaceholder" : MessageLookupByLibrary.simpleMessage("Phone"),
    "AddressList_add" : MessageLookupByLibrary.simpleMessage("Add new address"),
    "Calendar_end" : MessageLookupByLibrary.simpleMessage("End"),
    "Calendar_monthTitle" : m0,
    "Calendar_rangePrompt" : m1,
    "Calendar_start" : MessageLookupByLibrary.simpleMessage("Start"),
    "Calendar_startEnd" : MessageLookupByLibrary.simpleMessage("Start/End"),
    "Calendar_title" : MessageLookupByLibrary.simpleMessage("Calendar"),
    "Calendar_weekdays_Fri" : MessageLookupByLibrary.simpleMessage("Fri"),
    "Calendar_weekdays_Mon" : MessageLookupByLibrary.simpleMessage("Mon"),
    "Calendar_weekdays_Sat" : MessageLookupByLibrary.simpleMessage("Sat"),
    "Calendar_weekdays_Sun" : MessageLookupByLibrary.simpleMessage("Sun"),
    "Calendar_weekdays_Thu" : MessageLookupByLibrary.simpleMessage("Thu"),
    "Calendar_weekdays_Tue" : MessageLookupByLibrary.simpleMessage("Tue"),
    "Calendar_weekdays_Wed" : MessageLookupByLibrary.simpleMessage("Wed"),
    "Cascader_select" : MessageLookupByLibrary.simpleMessage("Select"),
    "ContactCard_addText" : MessageLookupByLibrary.simpleMessage("Add contact info"),
    "ContactList_addText" : MessageLookupByLibrary.simpleMessage("Add new contact"),
    "CouponCell_count" : m2,
    "CouponCell_tips" : MessageLookupByLibrary.simpleMessage("No coupons"),
    "CouponCell_title" : MessageLookupByLibrary.simpleMessage("Coupon"),
    "CouponList_close" : MessageLookupByLibrary.simpleMessage("Close"),
    "CouponList_disabled" : MessageLookupByLibrary.simpleMessage("Unavailable"),
    "CouponList_empty" : MessageLookupByLibrary.simpleMessage("No coupons"),
    "CouponList_enable" : MessageLookupByLibrary.simpleMessage("Available"),
    "CouponList_exchange" : MessageLookupByLibrary.simpleMessage("Exchange"),
    "CouponList_placeholder" : MessageLookupByLibrary.simpleMessage("Coupon code"),
    "Coupon_condition" : m3,
    "Coupon_discount" : m4,
    "Coupon_unlimited" : MessageLookupByLibrary.simpleMessage("Unlimited"),
    "Pagination_next" : MessageLookupByLibrary.simpleMessage("Next"),
    "Pagination_prev" : MessageLookupByLibrary.simpleMessage("Previous"),
    "PullRefresh_loosing" : MessageLookupByLibrary.simpleMessage("Loose to refresh..."),
    "PullRefresh_pulling" : MessageLookupByLibrary.simpleMessage("Pull to refresh..."),
    "SubmitBar_label" : MessageLookupByLibrary.simpleMessage("Total："),
    "cancel" : MessageLookupByLibrary.simpleMessage("Cancel"),
    "complete" : MessageLookupByLibrary.simpleMessage("Complete"),
    "confirm" : MessageLookupByLibrary.simpleMessage("Confirm"),
    "confirmDelete" : MessageLookupByLibrary.simpleMessage("Are you sure you want to delete?"),
    "delete" : MessageLookupByLibrary.simpleMessage("Delete"),
    "loading" : MessageLookupByLibrary.simpleMessage("Loading..."),
    "name" : MessageLookupByLibrary.simpleMessage("Name"),
    "nameEmpty" : MessageLookupByLibrary.simpleMessage("Please fill in the name"),
    "nameInvalid" : MessageLookupByLibrary.simpleMessage("Malformed name"),
    "save" : MessageLookupByLibrary.simpleMessage("Save"),
    "tel" : MessageLookupByLibrary.simpleMessage("Phone"),
    "telEmpty" : MessageLookupByLibrary.simpleMessage("Please fill in the tel"),
    "telInvalid" : MessageLookupByLibrary.simpleMessage("Malformed phone number")
  };
}
