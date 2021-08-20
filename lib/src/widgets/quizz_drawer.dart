import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ui_challenge/src/widgets/quizz_category.dart';

class QuizzDrawer extends HookWidget {
  const QuizzDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final quizzSelected = useProvider(quizzSelectedProvider);

    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const DrawerHeader(
              child: Text(
            'Quizz App',
            style: TextStyle(fontSize: 30),
          )),
          Container(
            color: Colors.grey[200],
              width: 500,
              child: TextButton(
                child: const Text('Home', style: TextStyle(color: Colors.black),),
                onPressed: () {
                  Navigator.of(context).popUntil((route) => route.isFirst);
                  if(quizzSelected.state != null) quizzSelected.state = null;
                },
              ))
        ],
      ),
    );
  }
}
