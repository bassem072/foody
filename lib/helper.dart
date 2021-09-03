import 'package:flutter/material.dart';
import 'package:foody/providers/language_provider.dart';
import 'package:provider/provider.dart';

String toText(String text, BuildContext context) {
  return '${Provider.of<LanguageProvider>(context, listen: true).getText(text)}';
}

List<String> toObject(String text, BuildContext context) {
  return Provider.of<LanguageProvider>(context, listen: true).getText(text);
}
