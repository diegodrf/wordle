import 'package:flutter/material.dart';

import 'game_keyboard_button.dart';

class GameKeyBoardButtonRow extends StatelessWidget {
  const GameKeyBoardButtonRow({Key? key, required this.values})
      : super(key: key);
  final List<String> values;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        for (final letter in values) GameKeyBoardButton(value: letter)
      ],
    );
  }
}
