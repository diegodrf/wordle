import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordle/src/features/game/constants.dart';
import 'package:wordle/src/features/game/controller.dart';

import 'text_row.dart';

class GameBoard extends StatelessWidget {
  const GameBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<GameController>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        for (int index = 0; index < kMaxNumberOfAttempts; index++)
          Container(
            margin: const EdgeInsets.symmetric(vertical: 4.0),
            child: TextRow(text: controller.textAttempts[index]),
          )
      ],
    );
  }
}
