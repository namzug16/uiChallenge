import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:supercharged/supercharged.dart';
import 'package:ui_challenge/src/widgets/quizz_category.dart';

class SectionButton extends HookWidget {
  final String title;
  final int i;
  final ValueNotifier<int> selection;

  const SectionButton(this.title, this.i, this.selection, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final style = TextStyle(
      color: i == selection.value ? Colors.white : Colors.black,
      fontSize: 15,
    );

    final quizzSelected = useProvider(quizzSelectedProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Container(
        width: 100,
        decoration: BoxDecoration(
          color: i == selection.value ? '86D2A2'.toColor() : Colors.grey[200],
          borderRadius: BorderRadius.circular(15.0),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: TextButton(
          child: Text(
            title,
            style: style,
          ),
          onPressed: () {
            if (!(i == selection.value)) {
              selection.value = i;
              if(quizzSelected.state != null){
                quizzSelected.state = null;
              }
            }
          },
        ),
      ),
    );
  }
}