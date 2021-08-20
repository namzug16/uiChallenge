import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:supercharged/supercharged.dart';
import 'package:ui_challenge/src/tabs/quizz.dart';
import 'package:ui_challenge/src/widgets/quizz_appbar.dart';
import 'package:ui_challenge/src/widgets/quizz_category.dart';
import 'package:ui_challenge/src/widgets/quizz_drawer.dart';
import 'package:ui_challenge/src/widgets/section_button.dart';
import 'package:ui_challenge/src/widgets/section_categories.dart';

class SelectionQuizz extends HookWidget {
  const SelectionQuizz({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sectionSelected = useState<int>(1);
    final categories = useState<String>('Popular');
    final quizzSelected = useProvider(quizzSelectedProvider);

    return Scaffold(
      appBar: QuizzAppBar(AppBar()),
      endDrawer: const QuizzDrawer(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 13),
            child: SizedBox(
              height: 70,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                itemCount: sections.length,
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.all(10),
                itemBuilder: (context, i) {
                  return SectionButton(sections[i], i, sectionSelected);
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SizedBox(
              height: 120,
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  DefaultTextStyle(
                    style: const TextStyle(fontSize: 40, color: Colors.black),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(categories.value),
                        const Text('categories')
                      ],
                    ),
                  ),
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: TextButton(
                        child: const Icon(
                          Icons.settings_input_composite_rounded,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          if (categories.value == "Popular") {
                            categories.value = "All";
                          } else {
                            categories.value = "Popular";
                          }
                        }),
                  ),
                ],
              ),
            ),
          ),
          SectionCategories(sectionSelected.value),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
              height: 60,
              width: MediaQuery.of(context).size.width,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              decoration: BoxDecoration(
                color: quizzSelected.state != null
                    ? '86D2A2'.toColor()
                    : Colors.grey[200],
                borderRadius: BorderRadius.circular(15),
              ),
              child: TextButton(
                child: Text(
                  "Let's Start",
                  style: TextStyle(
                      color: quizzSelected.state != null
                          ? Colors.white
                          : Colors.black),
                ),
                onPressed: () {
                  if (quizzSelected.state != null) {
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) => Quizz()));
                  }
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}

const List<String> sections = ["Sport", "Science", "Art", "Design"];


