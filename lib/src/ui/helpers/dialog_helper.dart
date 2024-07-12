import 'package:flutter/material.dart';

dialogButton({
  required BuildContext context,
  required Widget child,
  required bool isScrollControlled,
}) =>
    showModalBottomSheet(
      context: context,
      isScrollControlled: isScrollControlled,
      builder: (_) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              alignment: Alignment.centerRight,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.close),
              ),
            ),
            const Divider(),
            const SizedBox(height: 10),
            child,
          ],
        ),
      ),
    );
