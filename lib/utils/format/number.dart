import 'dart:math' as math;

import 'package:flutter/material.dart';

num range(num number, num min, num max) {
  return math.min(math.max(number, min), max);
}

String trimExtraChar(String value, String char, RegExp regExp) {
  final int index = value.indexOf(char);

  if (index == -1) {
    return value;
  }

  if (char == '-' && index != 0) {
    return value.substring(0, index);
  }

  return value.substring(0, index + 1) +
      value.substring(index).replaceAll(regExp, '');
}

String formatNumber(
  String value, {
  bool allowDot = true,
  bool allowMinus = true,
}) {
  if (allowDot) {
    value = trimExtraChar(value, '.', RegExp(r'\.'));
  } else {
    value = value.split('.')[0];
  }

  if (allowMinus) {
    value = trimExtraChar(value, '-', RegExp(r'-'));
  } else {
    value = value.replaceAll(RegExp(r'-'), '');
  }
  final RegExp regExp = allowDot ? RegExp(r'[^-0-9.]') : RegExp(r'[^-0-9]');

  return value.replaceAll(regExp, '');
}

TextEditingValue Function(TextEditingValue, TextEditingValue) customFormat(
  String Function(String) formatFunction,
) {
  return (
    TextEditingValue oldValue,
    TextEditingValue value,
  ) {
    final int selectionStartIndex = value.selection.start;
    final int selectionEndIndex = value.selection.end;
    String manipulatedText;
    TextSelection? manipulatedSelection;
    if (selectionStartIndex < 0 || selectionEndIndex < 0) {
      manipulatedText = formatFunction(value.text);
    } else {
      final String beforeSelection =
          formatFunction(value.text.substring(0, selectionStartIndex));
      final String inSelection = formatFunction(
          value.text.substring(selectionStartIndex, selectionEndIndex));
      final String afterSelection =
          formatFunction(value.text.substring(selectionEndIndex));
      manipulatedText = beforeSelection + inSelection + afterSelection;
      if (value.selection.baseOffset > value.selection.extentOffset) {
        manipulatedSelection = value.selection.copyWith(
          baseOffset: beforeSelection.length + inSelection.length,
          extentOffset: beforeSelection.length,
        );
      } else {
        manipulatedSelection = value.selection.copyWith(
          baseOffset: beforeSelection.length,
          extentOffset: beforeSelection.length + inSelection.length,
        );
      }
    }
    return TextEditingValue(
      text: manipulatedText,
      selection:
          manipulatedSelection ?? const TextSelection.collapsed(offset: -1),
      composing:
          manipulatedText == value.text ? value.composing : TextRange.empty,
    );
  };
}
