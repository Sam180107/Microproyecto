class CardModel {
  final int id;         // Un número único para cada carta (0, 1, 2...)
  final String content;  // El emoji o símbolo que tiene la carta (ej. '🍎')
  bool isFlipped;       // Nos dice si la carta se está mostrando (volteada)
  bool isMatched;       // Nos dice si ya encontramos su pareja y debe quedarse fija

  // Este es el constructor para crear cada carta
  CardModel({
    required this.id,
    required this.content,
    this.isFlipped = false, // Al empezar, todas están tapadas
    this.isMatched = false, // Al empezar, ninguna tiene pareja
  });
}