import 'dart:async';

import 'package:flutter/material.dart';

class FlutterBlocLocalizations {
  static FlutterBlocLocalizations of(BuildContext context) {
    final localizations = Localizations.of<FlutterBlocLocalizations>(
      context,
      FlutterBlocLocalizations,
    );

    if (localizations == null) {
      throw StateError(
        'FlutterBlocLocalizations.of(context) returned null.\n'
        'No FlutterBlocLocalizations ancestor could be found in the widget '
        'tree for context $context.\n'
        'Try passing FlutterBlocLocalizations.delegate to the top-level '
        'widget.',
      );
    }

    return localizations;
  }

  String get appTitle => 'Flutter Todos';
}

class FlutterBlocLocalizationsDelegate
    extends LocalizationsDelegate<FlutterBlocLocalizations> {
  @override
  Future<FlutterBlocLocalizations> load(Locale locale) =>
      Future(() => FlutterBlocLocalizations());

  @override
  bool shouldReload(FlutterBlocLocalizationsDelegate old) => false;

  @override
  bool isSupported(Locale locale) =>
      locale.languageCode.toLowerCase().contains('en');
}
