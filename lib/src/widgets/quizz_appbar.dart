import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ui_challenge/src/widgets/quizz_category.dart';

class QuizzAppBar extends HookWidget implements PreferredSizeWidget{

  final AppBar appBar;
  const QuizzAppBar(this.appBar,{Key? key,})
      : super(key: key);


  @override
  Widget build(BuildContext context) {

    final quizzSelected = useProvider(quizzSelectedProvider);

    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios,
          color: Colors.black,
        ),
        onPressed: () {
          Navigator.of(context).maybePop();
          if(quizzSelected.state != null){
            quizzSelected.state = null;
          }
        },
      ),
      actions: [
        IconButton(
          icon: const Icon(
            Icons.menu_rounded,
            color: Colors.black,
          ),
          onPressed: (){
            Scaffold.of(context).openEndDrawer();
          },
        )
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appBar.preferredSize.height);
}
