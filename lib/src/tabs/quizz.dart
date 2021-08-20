import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:supercharged/supercharged.dart';
import 'package:ui_challenge/src/widgets/no_quizz_available.dart';
import 'package:ui_challenge/src/widgets/quizz_category.dart';

class Quizz extends HookWidget {
  const Quizz({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final quizzSelected = useProvider(quizzSelectedProvider);

    final answer = useState<int?>(null);
    final isCorrect = useState<bool?>(null);

    if (quizzSelected.state == "Physics") {
      const titleStyle = TextStyle(color: Colors.black, fontSize: 20);

      const sentenceStyle = TextStyle(color: Colors.black45, fontSize: 15);

      final answerStyle = TextStyle(
        color: answer.value == null ? Colors.transparent : Colors.black,
        fontSize: 15,
      );

      final controller = useAnimationController(duration: const Duration(milliseconds: 500));
      final tween = Tween<double>(begin: 0, end: -15).animate(controller);

      useEffect((){
        if(answer.value != null){
          if (answer.value == 2) {
            isCorrect.value = true;
          } else {
            isCorrect.value = false;
          }
        }

        controller.repeat(reverse: true);

      },[answer.value]);

      return Scaffold(
        body: Padding(
          padding:
              const EdgeInsets.only(left: 30, right: 30, top: 30, bottom: 20),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  isCorrect.value == null
                      ? "Fill the gap..."
                      : isCorrect.value!
                          ? "The answer is correct!!"
                          : "The answer is incorrect!",
                  style: titleStyle,
                ),
              ),
              RichText(
                text: TextSpan(
                  text: pQuizz["choices"][2],
                  style: answerStyle,
                  children: [
                    TextSpan(text: pQuizz["sentence"], style: sentenceStyle),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Container(
                  height: 300,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: '42153C'.toColor(),
                      borderRadius: BorderRadius.circular(20)),
                  child: answer.value != null ? Transform.translate(
                    offset: Offset(useValueListenable(tween), 0),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 60,),
                      onPressed: (){
                        Navigator.of(context).maybePop();
                      },
                    ),
                  ) : const SizedBox(),
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [for (var i = 0; i < 4; i++) Choice(i, answer)],
                ),
              )
            ],
          ),
        ),
      );
    } else {
      return const NoQuizzAvailable();
    }
  }
}

class Choice extends StatelessWidget {
  final int i;
  final ValueNotifier<int?> answer;

  const Choice(this.i, this.answer, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color green = '86D2A2'.toColor();

    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: answer.value == null
            ? Colors.transparent
            : answer.value == i
                ? i == 2
                    ? green
                    : 'FFEEE9'.toColor()
                : Colors.transparent,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
            color: answer.value == null
                ? Colors.transparent
                : answer.value == i
                    ? Colors.transparent
                    : i == 2
                        ? green
                        : Colors.transparent,
            width: 2),
      ),
      child: TextButton(
        style: ButtonStyle(
          overlayColor: MaterialStateProperty.all<Color>(Colors.transparent),
        ),
        onPressed: () {
          answer.value ??= i;
        },
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: answer.value == null
                  ? const FaIcon(FontAwesomeIcons.circle, color: Colors.black45)
                  : answer.value == i
                      ? i == 2
                          ? const FaIcon(
                              FontAwesomeIcons.checkCircle,
                              color: Colors.white,
                            )
                          : FaIcon(
                              FontAwesomeIcons.timesCircle,
                              color: 'F58B58'.toColor(),
                            )
                      : const FaIcon(FontAwesomeIcons.circle,
                          color: Colors.black45),
            ),
            Text(
              pQuizz["choices"][i],
              style: TextStyle(
                color: answer.value == null
                    ? Colors.black
                    : answer.value == i
                        ? i == 2
                            ? Colors.white
                            : 'F58B58'.toColor()
                        : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// blue yellow brown purple white orange
// #1A32CD #FEBE43 #7E403E #42153C #FFEEE9 #F58B58

final Map<String, dynamic> pQuizz = {
  "sentence":
      " proved that a sphere has two thirds of the area and volume of the described cylinder.",
  "choices": ["Albert Einstein", "Isaac Newton", "Archimedes ", "Max Born"],
};
