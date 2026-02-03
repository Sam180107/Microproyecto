import 'package:flutter/material.dart';

class CardModel {
  final int id;
  final String content;
  bool isFlipped;
  bool isMatched;
  Color? color; // Para que cada carta tenga su color propio

  CardModel({
    required this.id,
    required this.content,
    this.isFlipped = false,
    this.isMatched = false,
    this.color,
  });
}