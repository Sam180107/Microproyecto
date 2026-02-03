import 'package:shared_preferences/shared_preferences.dart';
import 'score.dart';

class ScoreService {
  static const String _key = 'top_scores';

  // Guardar nueva puntuación
  static Future<void> addScore(ScoreEntry newScore) async {
    final prefs = await SharedPreferences.getInstance();
    final String? scoresString = prefs.getString(_key);
    
    // 1. Recuperar lista actual
    List<ScoreEntry> scores = scoresString != null 
        ? ScoreEntry.decode(scoresString) 
        : [];

    // 2. Agregar nueva puntuación
    scores.add(newScore);

    // 3. ORDENAR (Algoritmo: Menos intentos es mejor. Si empatan, menos tiempo es mejor)
    scores.sort((a, b) {
      int cmp = a.attempts.compareTo(b.attempts);
      if (cmp != 0) return cmp;
      return a.timeSeconds.compareTo(b.timeSeconds);
    });

    // 4. Mantener solo el Top 10 (opcional)
    if (scores.length > 10) {
      scores = scores.sublist(0, 10);
    }

    // 5. Guardar
    await prefs.setString(_key, ScoreEntry.encode(scores));
  }

  // Leer puntuaciones
  static Future<List<ScoreEntry>> getTopScores() async {
    final prefs = await SharedPreferences.getInstance();
    final String? scoresString = prefs.getString(_key);
    if (scoresString == null) return [];
    return ScoreEntry.decode(scoresString);
  }
}