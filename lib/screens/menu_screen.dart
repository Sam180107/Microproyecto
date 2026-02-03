import 'package:flutter/material.dart';
import 'game_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:microproyecto/score_panel.dart'; 

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  final TextEditingController _nicknameController = TextEditingController();

  final Color _backgroundColor = const Color(0xFF0F172A);
  final Color _accentCeleste = const Color(0xFF00E5FF);
  final Color _accentAmarillo = const Color(0xFFFFD700);
  final Color _cardMorado = const Color(0xFF4A148C);

  void _iniciarJuego() {
    if (_nicknameController.text.trim().isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => GameScreen(nickname: _nicknameController.text.trim()),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Escribe tu nickname para jugar')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      // CORRECCIÓN CLAVE: El body AHORA es un Stack
      body: Stack(
        children: [
          // --- HIJO 1: EL FONDO Y MENÚ (Tu Container gigante) ---
          Container(
            height: double.infinity, // Asegura que ocupe todo el fondo
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  const Color(0xFF1A237E),
                  _backgroundColor,
                ],
              ),
            ),
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.grid_view_rounded, size: 111, color: _accentCeleste),
                      const SizedBox(height: 20),
                      Text(
                        'MEMORY',
                        style: GoogleFonts.nabla(
                          fontSize: 50,
                          fontWeight: FontWeight.w900,
                          color: _accentAmarillo,
                          letterSpacing: 2.0,
                          shadows: [Shadow(blurRadius: 10, color: _accentAmarillo.withOpacity(0.5), offset: const Offset(0, 0))],
                        ),
                      ),
                      Text(
                        'MASTER',
                        style: GoogleFonts.orbitron(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: _accentCeleste,
                          letterSpacing: 3.0,
                        ),
                      ),
                      const SizedBox(height: 60),
                      ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 250),
                        child: TextField(
                          controller: _nicknameController,
                          style: const TextStyle(color: Colors.white, fontSize: 18),
                          cursorColor: _accentCeleste,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.05),
                            hintText: 'Escribe tu nickname',
                            hintStyle: TextStyle(color: Colors.white.withOpacity(0.4)),
                            prefixIcon: Icon(Icons.person_outline, color: _accentCeleste),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: _accentCeleste.withOpacity(0.3), width: 1),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: _accentCeleste, width: 2),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                      SizedBox(
                        width: 200,
                        height: 55,
                        child: ElevatedButton(
                          onPressed: _iniciarJuego,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _accentCeleste,
                            foregroundColor: Colors.black,
                            elevation: 10,
                            shadowColor: _accentCeleste.withOpacity(0.5),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                          ),
                          child: Text(
                            'INICIAR JUEGO',
                            style: GoogleFonts.orbitron(fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 1.0),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'By: Miguel Figueroa-Samir Nassar',
                        style: TextStyle(color: Colors.white.withOpacity(0.2), fontSize: 12),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ), // <--- AQUÍ TERMINA EL CONTAINER (HIJO 1)

          // --- HIJO 2: EL PANEL FLOTANTE ---
          Positioned(
            top: 50,
            left: 30,
            child: TopScorersPanel(),
          ),
          
        ], // <--- AQUÍ CIERRA LA LISTA DE HIJOS (children)
      ), // <--- AQUÍ CIERRA EL STACK
    ); // <--- AQUÍ CIERRA EL SCAFFOLD
  }
}