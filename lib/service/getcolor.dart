import 'package:flutter/material.dart';

Color color(context, Color dark, Color light) =>
    Theme.of(context).brightness == Brightness.light ? light : dark;
