import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:wordle/src/features/game/constants.dart';
import 'package:wordle/src/features/game/controller.dart';
import 'package:wordle/src/features/game/enums/game_status_enum.dart';
import '../components/game_board.dart';
import '../components/keyboard/game_keyboard.dart';

class GameScreen extends StatefulWidget {
  static const route = 'game_screen';
  const GameScreen({Key? key}) : super(key: key);

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  Future<void> _showDialog(GameStatusEnum status) async {
    final _controller = context.read<GameController>();
    final size = MediaQuery.of(context).size;

    final title = status == GameStatusEnum.win ? 'WIN' : 'FAIL';
    final content = status == GameStatusEnum.win ? kSuccessText : kFailText;
    final icon = status == GameStatusEnum.win ? kSuccessIcon : kFailIcon;

    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text(
            title,
            textAlign: TextAlign.center,
          ),
          content: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: size.height * 0.5,
              maxWidth: size.width * 0.5,
            ),
            child: SizedBox(
              height: 300,
              width: 300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  icon,
                  Text(content),
                  const Divider(),
                  Text('The word is ${_controller.selectedWord}'),
                ],
              ),
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                _controller.resetGame();
                Navigator.pop(context);
              },
              child: const Text('Restart'),
            )
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    final controller = context.read<GameController>();

    controller.addListener(() {
      if (controller.gameStatus == GameStatusEnum.invalidWord) {
        final size = MediaQuery.of(context).size;
        final invalidWordSnackBar = SnackBar(
          content: const Text(kInvalidWordText),
          behavior: SnackBarBehavior.floating,
          duration: const Duration(milliseconds: 1000),
          margin: EdgeInsets.only(
            bottom: size.height * 0.5,
            left: 8.0,
            right: 8.0,
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(invalidWordSnackBar);
      }
      if (controller.gameStatus == GameStatusEnum.win ||
          controller.gameStatus == GameStatusEnum.loose) {
        Vibrate.vibrate();

        _showDialog(controller.gameStatus);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Wordle'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.only(
            right: 8.0,
            left: 8.0,
            bottom: 32.0,
            top: 8.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              GameBoard(),
              GameKeyBoard(),
            ],
          ),
        ),
      ),
    );
  }
}
