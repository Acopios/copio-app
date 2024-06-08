import 'package:flutter/material.dart';

alert(BuildContext context, Widget child,
        {Function()? action1, Function()? action2}) =>
    showDialog(
        context: context,
        builder: (_) => AlertDialog.adaptive(
              content: Column(    mainAxisSize: MainAxisSize.min,
                children: [child],
              ),
              actions: [
                Visibility(
                    visible: action2 != null,
                    child: TextButton(
                        onPressed: action2, child: const Text("Cerrar"))),
                Visibility(
                    visible: action1 != null,
                    child: TextButton(
                        onPressed: action1, child: const Text("OK"))),
              ],
            ));


