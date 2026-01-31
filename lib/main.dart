import 'package:flutter/material.dart';
import 'package:microproyecto/screens/menu_screen.dart';
import 'screens/game_screen.dart'; 

void main() {
  runApp(const MemoryGameApp());
}

class MemoryGameApp extends StatelessWidget {
  const MemoryGameApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Juego de Memoria UNIMET',
      debugShowCheckedModeBanner: false, 
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      // Definimos la pantalla de inicio
      home: const MenuScreen(), 
    );
  }
}