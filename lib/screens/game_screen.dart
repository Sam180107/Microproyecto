import 'package:flutter/material.dart';
import '../models/card_models.dart'; // Importa tu modelo

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  List<CardModel> _cards = [];
  List<int> _selectedIndices = []; 
  int _intentos = 0; 

  @override
  void initState() {
    super.initState();
    _generarTablero();
  }

  void _generarTablero() {
    List<String> iconos = [
      '🍎','🍌','🍇','🍊','🍓','🍒','🥝','🍋','🍍','🥥',
      '🍉','🍑','🥑','🌽','🥦','🥨','🍕','🍔'
    ];
    
    List<String> baraja = [...iconos, ...iconos];
    baraja.shuffle(); 

    _cards = List.generate(baraja.length, (index) => CardModel(
      id: index, 
      content: baraja[index]
    ));
  }

  void _voltearCarta(int index) {
    if (_selectedIndices.length >= 2 || _cards[index].isMatched || _cards[index].isFlipped) return;

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
    int i1 = _selectedIndices[0];
    int i2 = _selectedIndices[1];

    if (_cards[i1].content == _cards[i2].content) {
      setState(() {
        _cards[i1].isMatched = true;
        _cards[i2].isMatched = true;
        _selectedIndices.clear();
      });
    } else {
      Future.delayed(const Duration(seconds: 1), () {
        if (mounted) {
          setState(() {
            _cards[i1].isFlipped = false;
            _cards[i2].isFlipped = false;
            _selectedIndices.clear();
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Memoria UNIMET 6x6"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text("Intentos: $_intentos", style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 6, 
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: _cards.length,
              itemBuilder: (context, index) {
                bool mostrar = _cards[index].isFlipped || _cards[index].isMatched;
                return GestureDetector(
                  onTap: () => _voltearCarta(index),
                  child: Container(
                    decoration: BoxDecoration(
                      color: mostrar ? Colors.white : Colors.blueAccent,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.blue.shade900),
                    ),
                    child: Center(
                      child: Text(
                        mostrar ? _cards[index].content : "?",
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}