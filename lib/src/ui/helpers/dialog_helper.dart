import 'package:flutter/material.dart';

dialogButton({required BuildContext context, required Widget child}) =>
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (_) => Column(
              children: [
                Container(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.close))),
                const Divider(),
                const SizedBox(height: 10),
                child,
              ],
            ));
