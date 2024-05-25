import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

SpeedDialChild speedDialWidget(IconData iconData, txt, Function() action) =>
    SpeedDialChild(
      child: Icon(iconData),
      label: txt,
      onTap: action,
    );
