import 'package:flutter/material.dart';
import 'dart:async';
import '../models/card_models.dart';

class GameScreen extends StatefulWidget {
  final String nickname;
  const GameScreen({super.key, required this.nickname});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  List<CardModel> _cards = [];
  final List<int> _selectedIndices = [];
  int _intentos = 0;
  Timer? _timer;
  int _segundos = 0;
  bool _juegoIniciado = false;
  
  final List<Color> _paleta = [
    const Color(0xFF1A237E), const Color(0xFF4A148C),
    const Color(0xFF004D40), const Color(0xFF01579B),
    const Color(0xFF311B92), const Color(0xFF006064),
  ];

  @override
  void initState() {
    super.initState();
    _generarTablero();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _generarTablero() {
    List<String> emojis = ['🍎','🍌','🍇','🍊','🍓','🍒','🥝','🍋','🍍','🥥','🍉','🍑','🥑','🌽','🥦','🥨','🍕','🍔'];
    List<String> baraja = [...emojis, ...emojis]..shuffle();
    _cards = List.generate(baraja.length, (i) {
      return CardModel(
        id: i, 
        content: baraja[i],
        color: _paleta[i % _paleta.length],
      );
    });
    _segundos = 0;
    _intentos = 0;
    _juegoIniciado = false;
    _timer?.cancel();
  }

  void _iniciarCronometro() {
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (mounted) setState(() => _segundos++);
    });
  }

  void _voltearCarta(int index) {
    if (_selectedIndices.length >= 2 || _cards[index].isMatched || _cards[index].isFlipped) return;
    if (!_juegoIniciado) { _juegoIniciado = true; _iniciarCronometro(); }
    setState(() {
      _cards[index].isFlipped = true;
      _selectedIndices.add(index);
    });
    if (_selectedIndices.length == 2) {
      _intentos++;
      _comprobarPareja();
    }
  }

  void _comprobarPareja() {
    int i1 = _selectedIndices[0], i2 = _selectedIndices[1];
    if (_cards[i1].content == _cards[i2].content) {
      setState(() {
        _cards[i1].isMatched = _cards[i2].isMatched = true;
        _selectedIndices.clear();
      });
      _verificarVictoria();
    } else {
      Future.delayed(const Duration(milliseconds: 600), () {
        if (mounted) {
          setState(() {
            _cards[i1].isFlipped = _cards[i2].isFlipped = false;
            _selectedIndices.clear();
          });
        }
      });
    }
  }

  void _verificarVictoria() {
    if (_cards.every((c) => c.isMatched)) {
      _timer?.cancel();
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (ctx) => AlertDialog(
          backgroundColor: const Color(0xFF1E293B),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Text("¡VICTORIA! 🎉", style: TextStyle(color: Colors.amberAccent)),
          content: Text("¡Increíble ${widget.nickname}!\nLo lograste en $_segundos segundos.", style: const TextStyle(color: Colors.white)),
          actions: [
            Center(
              child: ElevatedButton(
                onPressed: () { Navigator.pop(ctx); setState(() => _generarTablero()); },
                child: const Text("Jugar de nuevo"),
              ),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Cálculo dinámico para que las cartas intenten caber en el alto de la pantalla
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    // Ajustamos la proporción dinámicamente
    final double aspect = (screenWidth / 6) / (screenHeight / 8);

    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 10),
            Text(
              widget.nickname.toUpperCase(),
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w900,
                color: Colors.amberAccent,
                letterSpacing: 4,
                shadows: [
                  Shadow(blurRadius: 10, color: Colors.black.withOpacity(0.8), offset: const Offset(4, 4)),
                ],
              ),
            ),
            const Text("MASTER MEMORY PRO", style: TextStyle(color: Colors.cyanAccent, fontSize: 10, letterSpacing: 6)),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _infoBox("INTENTOS", "$_intentos", Colors.orangeAccent),
                _infoBox("TIEMPO", "${_segundos}s", Colors.greenAccent),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: GridView.builder(
                  itemCount: _cards.length,
                  // PERMITIMOS EL SCROLL CON LA RUEDITA
                  physics: const BouncingScrollPhysics(), 
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 6,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    // Usamos el cálculo de aspecto para forzar a que quepan
                    childAspectRatio: aspect > 1.4 ? aspect : 1.4, 
                  ),
                  itemBuilder: (context, index) {
                    final isVisible = _cards[index].isFlipped || _cards[index].isMatched;
                    return GestureDetector(
                      onTap: () => _voltearCarta(index),
                      child: Container(
                        decoration: BoxDecoration(
                          color: isVisible ? Colors.white : (_cards[index].color ?? Colors.blueGrey),
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 4)
                          ],
                        ),
                        child: Center(
                          child: isVisible 
                            ? Text(_cards[index].content, style: const TextStyle(fontSize: 20)) 
                            : const Icon(Icons.psychology, color: Colors.white30, size: 30),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoBox(String label, String value, Color col) {
    return Column(
      children: [
        Text(label, style: const TextStyle(color: Colors.white54, fontSize: 9, fontWeight: FontWeight.bold)),
        Text(value, style: TextStyle(color: col, fontSize: 18, fontWeight: FontWeight.w900)),
      ],
    );
  }
}