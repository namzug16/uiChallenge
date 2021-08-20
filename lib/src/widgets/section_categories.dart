import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:supercharged/supercharged.dart';
import 'package:ui_challenge/src/tabs/selection_quizz.dart';
import 'package:ui_challenge/src/widgets/quizz_category.dart';


class SectionCategories extends HookWidget {
  final int i;

  const SectionCategories(this.i, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final controller = useAnimationController(duration: const Duration(seconds: 1));
    final tween = Tween<double>(begin: 60, end: 100).animate(controller);

    useEffect((){
      if(sections[i] != "Science"){
        controller.repeat(reverse: true);
      }
    },[]);

    useEffect((){
      if(sections[i] != "Science"){
        controller.repeat(reverse: true);
      }else{
        controller.stop();
      }
    },[i]);

    if (sections[i] == "Science") {
      return Expanded(
        child: ListView.builder(
          padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
          itemCount: _scienceCategories.length,
          itemBuilder: (_, i) {
            return QuizzCategory(_scienceCategories[i]);
          },
        ),
      );
    } else {
      return Expanded(
        child: Stack(
          children: [
            Positioned(
              top: useValueListenable(tween),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: FaIcon(
                    FontAwesomeIcons.question,
                    size: 150,
                    color: 'F58B58'.toColor(),
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: double.infinity,
              height: 80,
              child: Center(child: Text("No categories available")),
            )
          ],
        ),
      );
    }
  }
}

const List<String> _scienceCategories = [
  "Chemistry",
  "Biology",
  "Physics",
];
