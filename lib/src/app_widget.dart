import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordle/src/features/game/controller.dart';
import 'package:wordle/src/features/game/screens/game_screen.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GameController(),
      child: MaterialApp(
        theme: ThemeData(useMaterial3: false),
        debugShowCheckedModeBanner: false,
        initialRoute: GameScreen.route,
        routes: {
          GameScreen.route: (_) => const GameScreen(),
        },
      ),
    );
  }
}
