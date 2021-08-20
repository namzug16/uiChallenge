import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:supercharged/supercharged.dart';
import 'package:ui_challenge/src/widgets/quizz_appbar.dart';
import 'package:ui_challenge/src/widgets/quizz_drawer.dart';

class NoQuizzAvailable extends HookWidget {
  const NoQuizzAvailable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller =
        useAnimationController(duration: const Duration(milliseconds: 800));
    final tween = Tween<double>(begin: 0, end: 50).animate(controller);

    useEffect(() {
      controller.repeat(reverse: true);
    }, []);

    return Scaffold(
      appBar: QuizzAppBar(AppBar()),
      endDrawer: const QuizzDrawer(),
      body: Column(
        children: [
          const Expanded(
            flex: 1,
            child: Center(
              child: Text(
                "No Quizz available",
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Transform.translate(
                offset: Offset( 0,useValueListenable(tween)),
                child: FaIcon(
                  FontAwesomeIcons.question,
                  size: 250,
                  color: 'F58B58'.toColor(),
                )),
          ),
        ],
      ),
    );
  }
}
