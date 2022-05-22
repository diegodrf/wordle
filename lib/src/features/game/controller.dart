import 'dart:collection';

import 'package:flutter/foundation.dart';

import 'package:wordle/src/features/game/constants.dart';
import 'package:wordle/src/features/game/enums/game_status_enum.dart';
import 'package:wordle/src/features/game/enums/letter_status_enum.dart';
import 'package:wordle/src/features/game/models/letter.dart';
import 'package:wordle/src/features/game/word_repository.dart';

class GameController with ChangeNotifier {
  GameController() {
    _wordRepository = WordRepository();
    _selectedWord = _wordRepository.getRandomWord();
    _textAttempts = _generateAttemptsGrid();
  }

  void resetGame() {
    _selectedWord = _wordRepository.getRandomWord();
    _attemptColIndex = 0;
    _attemptRowIndex = 0;
    _gameStatus = GameStatusEnum.running;
    _textAttempts = _generateAttemptsGrid();
    notifyListeners();
  }

  late List<List<Letter>> _textAttempts;
  List<List<Letter>> get textAttempts => UnmodifiableListView(_textAttempts);

  int _attemptRowIndex = 0;
  int _attemptColIndex = 0;
  late final WordRepository _wordRepository;
  late String _selectedWord;
  String get selectedWord => _selectedWord;

  GameStatusEnum _gameStatus = GameStatusEnum.running;
  GameStatusEnum get gameStatus => _gameStatus;

  List<List<Letter>> _generateAttemptsGrid() {
    return List<List<Letter>>.generate(
      kMaxNumberOfAttempts,
      (index) => List<Letter>.generate(
        kTextMaxLength,
        (index2) => Letter(value: ''),
      ),
    );
  }

  String textAttemptAsString(int rowIndex) {
    return _textAttempts[rowIndex].map((e) => e.value).join();
  }

  void addLetter(String letter) {
    if (textAttemptAsString(_attemptRowIndex).length < kTextMaxLength) {
      _textAttempts[_attemptRowIndex][_attemptColIndex] = Letter(value: letter);
      _attemptColIndex++;
      notifyListeners();
    }
  }

  void removeLetter() {
    final currentString = textAttemptAsString(_attemptRowIndex);
    if (currentString.isNotEmpty) {
      _attemptColIndex--;
      for (int i = _attemptColIndex; i < kTextMaxLength; i++) {
        _textAttempts[_attemptRowIndex][i] = Letter(value: '');
      }
      notifyListeners();
    }
  }

  bool verifyIfIsAValidWord(String word) {
    final isValid = _wordRepository.isValidWord(word);
    if (!isValid) {
      _gameStatus = GameStatusEnum.invalidWord;
      notifyListeners();
      _gameStatus = GameStatusEnum.running;
    }
    return isValid;
  }

  void submitAttempt() {
    if (_attemptRowIndex < kMaxNumberOfAttempts) {
      final currentString = textAttemptAsString(_attemptRowIndex);
      final textLengthValidation = currentString.length == kTextMaxLength;
      final attemptIndexValidation = _attemptRowIndex < kMaxNumberOfAttempts;
      if (textLengthValidation && attemptIndexValidation) {
        if (textAttemptAsString(_attemptRowIndex) == _selectedWord) {
          _gameStatus = GameStatusEnum.win;
        } else if (_attemptRowIndex == kMaxNumberOfAttempts - 1 &&
            textLengthValidation) {
          _gameStatus = GameStatusEnum.loose;
        } else {
          if (!verifyIfIsAValidWord(currentString)) {
            return;
          }
        }
        _verifyLetterPositions();
        _attemptRowIndex++;
        _attemptColIndex = 0;
        notifyListeners();
      }
    }
  }

  void _verifyLetterPositions() {
    final slicedAttempt = _textAttempts[_attemptRowIndex];
    final slicedSelectedWord = _selectedWord.split('');
    for (int index = 0; index < slicedAttempt.length; index++) {
      if (!slicedSelectedWord.contains(slicedAttempt[index].value)) {
        slicedAttempt[index].status = LetterStatusEnum.nonExists;
      }
      if (slicedSelectedWord.contains(slicedAttempt[index].value)) {
        slicedAttempt[index].status = LetterStatusEnum.wrongPosition;
      }
      if (slicedAttempt[index].value == slicedSelectedWord[index]) {
        slicedAttempt[index].status = LetterStatusEnum.exactPostion;
      }
    }
  }

  LetterStatusEnum verifyIfLetterWasSubmitted(String letter) {
    final Set<LetterStatusEnum> letterStatus = {};
    for (final row in _textAttempts) {
      row.where((element) {
        return element.value == letter;
      }).forEach((element) {
        letterStatus.add(element.status);
      });
    }

    if (letterStatus.contains(LetterStatusEnum.exactPostion)) {
      return LetterStatusEnum.exactPostion;
    }
    if (letterStatus.contains(LetterStatusEnum.wrongPosition)) {
      return LetterStatusEnum.wrongPosition;
    }
    if (letterStatus.contains(LetterStatusEnum.nonExists)) {
      return LetterStatusEnum.nonExists;
    }
    return LetterStatusEnum.unknown;
  }
}
