import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'score.dart';
import 'score_guardado.dart';

class TopScorersPanel extends StatelessWidget {
  final Color _accentCeleste = const Color(0xFF00E5FF);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250, // Ancho fijo para el panel lateral
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.5), // Fondo semitransparente
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.cyanAccent.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min, // Que no ocupe todo el alto si no hay datos
        children: [
          Text(
            "TOP SCORERS",
            style: GoogleFonts.orbitron(
              color: _accentCeleste, 
              fontSize: 20, 
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          // Carga asíncrona de datos
          FutureBuilder<List<ScoreEntry>>(
            future: ScoreService.getTopScores(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return CircularProgressIndicator();
              final scores = snapshot.data!;
              
              if (scores.isEmpty) return Text("Sin records aún", style: TextStyle(color: Colors.white70));

              return Column(
                children: scores.asMap().entries.map((entry) {
                  int idx = entry.key + 1;
                  ScoreEntry s = entry.value;
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("$idx. ${s.nickname}", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text("${s.attempts} intentos", style: TextStyle(color: Colors.cyanAccent, fontSize: 10)),
                            Text("${s.timeSeconds}s", style: TextStyle(color: Colors.grey, fontSize: 10)),
                          ],
                        )
                      ],
                    ),
                  );
                }).toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}