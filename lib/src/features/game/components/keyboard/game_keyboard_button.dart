import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:wordle/src/features/game/components/keyboard/constants.dart';
import 'package:wordle/src/features/game/controller.dart';

import '../../constants.dart';
import '../../enums/letter_status_enum.dart';

class GameKeyBoardButton extends StatelessWidget {
  const GameKeyBoardButton({Key? key, required this.value}) : super(key: key);
  final String value;
  final normalSize = 1;
  final largeSize = 2;

  bool isEspecialKey() {
    final specialKeys = [
      kEraseKey,
      kEnterKey,
    ];
    return specialKeys.contains(value);
  }

  Color _setColor(GameController controller, String value) {
    if (isEspecialKey()) {
      switch (value) {
        case kEnterKey:
          return kEnterKeyColor;
        case kEraseKey:
          return kEraseKeyColor;
      }
    }
    final letterStatus = controller.verifyIfLetterWasSubmitted(value);
    switch (letterStatus) {
      case LetterStatusEnum.exactPostion:
        return kBackgroundColorSuccess;
      case LetterStatusEnum.nonExists:
        return kBackgroundColorFail;
      case LetterStatusEnum.wrongPosition:
        return kBackgroundColorWarning;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    // This call reset keyboard;
    context.watch<GameController>();
    final controller = context.read<GameController>();
    final backgroundColor = _setColor(controller, value);
    final letterColor = backgroundColor == kBackgroundColorWarning
        ? Colors.black
        : Colors.white;

    return Expanded(
      flex: isEspecialKey() ? largeSize : normalSize,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 2.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            enableFeedback: true,
            maximumSize: const Size(64, 72),
            primary: _setColor(controller, value),
            padding: const EdgeInsets.symmetric(horizontal: 0.0),
          ),
          onPressed: () async {
            if (await Vibrate.canVibrate) {
              Vibrate.feedback(FeedbackType.success);
            }

            switch (value) {
              case kEraseKey:
                controller.removeLetter();
                break;
              case kEnterKey:
                controller.submitAttempt();
                break;
              default:
                controller.addLetter(value);
                break;
            }
          },
          child: Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: letterColor,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
