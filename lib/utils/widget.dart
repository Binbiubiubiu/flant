import 'package:flutter/material.dart';

void nextTick(void Function(Duration timestamp) callback) {
  WidgetsBinding.instance?.addPostFrameCallback(callback);
}
