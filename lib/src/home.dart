import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:supercharged/supercharged.dart';
import 'package:ui_challenge/src/tabs/selection_quizz.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const style = TextStyle(
      fontSize: 60,
      fontWeight: FontWeight.bold,
    );

    const styleTextButton = TextStyle(
      fontSize: 20,
      color: Colors.white,
    );

    // #86D2A2 green
    // blue yellow brown purple white orange
    // #1A32CD #FEBE43 #7E403E #42153C #FFEEE9 #F58B58

    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Text(
                    "Quizz",
                    style: style,
                  ),
                  Text("App", style: style),
                ],
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const SelectionQuizz()));
              },
              child: const Text(
                "Start",
                style: styleTextButton,
              ),
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>('86D2A2'.toColor()),
                minimumSize:
                    MaterialStateProperty.all<Size>(const Size(150, 50)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
