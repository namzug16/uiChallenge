import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:supercharged/supercharged.dart';



final quizzSelectedProvider = StateProvider<String?>((ref) => null);

class QuizzCategory extends HookWidget {
  final String category;

  const QuizzCategory(this.category, {Key? key}) : super(key: key);

  final double sideSize = 80;

  @override
  Widget build(BuildContext context) {
    final quizzSelected = useProvider(quizzSelectedProvider);

    final controller =
    useAnimationController(duration: const Duration(milliseconds: 300));
    final tweenHeight =
    Tween<double>(begin: sideSize, end: 100).animate(controller);
    final tweenWidth =
    Tween<double>(begin: sideSize, end: 500).animate(controller);
    final tweenPadding = Tween<double>(begin: 8, end: 0).animate(controller);


    useEffect((){
      if(quizzSelected.state != category && quizzSelected.state != null){
        controller.reverse();
      }
      if(tweenHeight.value > sideSize && quizzSelected.state == null){
        controller.reverse();
      }
    },[quizzSelected.state]);

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Container(
        height: 100,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          border: quizzSelected.state == category ? null : Border.all(color: Colors.black12),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: TextButton(
          style: ButtonStyle(
              padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                  const EdgeInsets.all(0)),
              overlayColor: MaterialStateProperty.all<Color>(Colors.transparent)
          ),
          onPressed: () {
            if (quizzSelected.state != category) {
              quizzSelected.state = category;
              controller.forward();
            } else if (quizzSelected.state == category) {
              quizzSelected.state = null;
              controller.reverse();
            }
          },
          child: Stack(
            children: [
              Positioned(
                left: useValueListenable(tweenPadding),
                top: useValueListenable(tweenPadding),
                child: Container(
                  width: useValueListenable(tweenWidth),
                  height: useValueListenable(tweenHeight),
                  decoration: BoxDecoration(
                      color: _categoryData[category]!["color"]!.toColor(),
                      borderRadius: BorderRadius.circular(20)),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        width: sideSize,
                        height: sideSize,
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(15))),
                  ),
                  Expanded(
                    child: Text(category,
                        style: TextStyle(
                            color: quizzSelected.state == category
                                ? Colors.white
                                : Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: sideSize,
                      height: sideSize,
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          color: quizzSelected.state == category
                              ? Colors.black12
                              : Colors.grey[200],
                          borderRadius: BorderRadius.circular(15)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            _categoryData[category]!["quizzes"].toString(),
                            style: TextStyle(
                                color: quizzSelected.state == category
                                    ? Colors.white
                                    : Colors.black,
                                fontSize: 25),
                          ),
                          Text(
                            'quizzes',
                            style: TextStyle(
                                color: quizzSelected.state == category
                                    ? Colors.white
                                    : Colors.black,
                                fontSize: 10),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

const Map<String, Map<String, String>> _categoryData = {
  "Chemistry": {"quizzes": "20", "color": "7E403E"},
  "Biology": {"quizzes": "9", "color": "FEBE43"},
  "Physics": {"quizzes": "11", "color": "1A32CD"},
};
