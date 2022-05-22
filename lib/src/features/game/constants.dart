import 'package:flutter/material.dart';

const kTextMaxLength = 5;
const kMaxNumberOfAttempts = 6;

const kBackgroundColorDefault = Colors.white;
const kBackgroundColorSuccess = Colors.green;
const kBackgroundColorFail = Colors.redAccent;
const kBackgroundColorWarning = Color.fromARGB(255, 240, 240, 0);

const kSuccessIcon = Icon(
  Icons.done,
  size: 80,
  color: kBackgroundColorSuccess,
);

const kFailIcon = Icon(
  Icons.close,
  size: 80,
  color: kBackgroundColorFail,
);

const kSuccessText = 'You discovered the word!';
const kFailText =
    'Sorry! You used all your attempts, but it wasn\'t enough to discover the word.';
const kInvalidWordText = 'Invalid Word!';
