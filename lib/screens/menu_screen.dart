import 'package:flutter/material.dart';
import 'game_screen.dart';

class MenuScreen extends StatefulWidget{
  const MenuScreen({super.key});
  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen>{
  final TextEditingController _nicknameController = TextEditingController();  
  void _iniciarJuego(){
    if(_nicknameController.text.trim().isNotEmpty){ 
      Navigator.push(context,MaterialPageRoute(builder:(context)=>GameScreen(),),);
    }else{
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Escribe tu nickname para guardar tu puntuacion')));
    }
  }


 @override
  Widget build(BuildContext context) {
    return Scaffold( // 5. Lienzo básico de la pantalla
      body: Center( // 6. Centra todo el contenido
        child: Padding(
          padding: const EdgeInsets.all(24.0), // Margen interno
          child: Column( // 7. Organiza elementos uno debajo de otro
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Título del juego con estilo destacado
              const Text(
                'MEMORIA UNIMET',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 40), // Espaciador (como un margin-bottom)
              
              // Cuadro de entrada de texto
            ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 300, // Aquí sí existe la propiedad maxWidth
              ),
              child: TextField(
                controller: _nicknameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Ingresa tu Nickname',
                  prefixIcon: Icon(Icons.person),
                ),
              ),
            ),
              const SizedBox(height: 30),
              
              // Botón de acción
              ElevatedButton(
                onPressed: _iniciarJuego, // Al presionar, ejecuta la función de arriba
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                ),
                child: const Text('¡A Jugar!'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}