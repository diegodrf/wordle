import 'package:wordle/src/features/game/enums/letter_status_enum.dart';

class Letter {
  final String value;
  LetterStatusEnum status;
  Letter({
    required this.value,
    this.status = LetterStatusEnum.unknown,
  });
}
