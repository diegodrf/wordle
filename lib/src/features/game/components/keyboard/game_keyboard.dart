import 'package:flutter/material.dart';

import 'constants.dart';
import 'game_keyboard_button_row.dart';

class GameKeyBoard extends StatelessWidget {
  const GameKeyBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: const [
          GameKeyBoardButtonRow(values: kFirstRow),
          SizedBox(height: 4.0),
          GameKeyBoardButtonRow(values: kSecondRow),
          SizedBox(height: 4.0),
          GameKeyBoardButtonRow(values: kThirdRow),
        ],
      ),
    );
  }
}
