import 'package:flutter/material.dart';
import 'screens/menu_screen.dart'; 
// Borramos la línea de game_screen.dart que estaba aquí

void main() => runApp(const MemoryGameApp());

class MemoryGameApp extends StatelessWidget {
  const MemoryGameApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, 
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue), 
        useMaterial3: true
      ),
      // El Menú se encarga de importar y llamar al Juego, por eso el Main ya no lo necesita.
      home: const MenuScreen(), 
    );
  }
}