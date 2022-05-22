import 'package:flutter/material.dart';
import 'package:wordle/src/features/game/constants.dart';
import 'package:wordle/src/features/game/enums/letter_status_enum.dart';
import 'package:wordle/src/features/game/models/letter.dart';

class LetterBox extends StatelessWidget {
  final Letter letter;
  const LetterBox({Key? key, required this.letter}) : super(key: key);

  Color _setColor() {
    switch (letter.status) {
      case LetterStatusEnum.unknown:
        return kBackgroundColorDefault;
      case LetterStatusEnum.exactPostion:
        return kBackgroundColorSuccess;
      case LetterStatusEnum.nonExists:
        return kBackgroundColorFail;
      case LetterStatusEnum.wrongPosition:
        return kBackgroundColorWarning;
    }
  }

  @override
  Widget build(BuildContext context) {
    return LimitedBox(
      maxHeight: 64.0,
      maxWidth: 56.0,
      child: Container(
        height: 64.0,
        width: 56.0,
        decoration: BoxDecoration(
          color: _setColor(),
          border: Border.all(width: 2.0),
          boxShadow: const [
            BoxShadow(
              offset: Offset(2.0, 2.0),
              blurRadius: 4.0,
              color: Colors.black54,
            )
          ],
        ),
        child: Center(
          child: Text(
            letter.value.toUpperCase(),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
