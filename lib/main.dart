import 'dart:math';
import 'package:flutter/material.dart';

void main() => runApp(const MiApp());

class MiApp extends StatelessWidget {
  const MiApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Volado(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Volado extends StatefulWidget {
  @override
  State<Volado> createState() => _VoladoState();
}

class _VoladoState extends State<Volado> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool esAguila = true;
  bool estaGirando = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    lanzar(); // tira al iniciar como en tu Python
  }

  void lanzar() {
    if (estaGirando) return;
    setState(() {
      esAguila = Random().nextBool(); // True = águila, False = sello
      estaGirando = true;
    });
    _controller.forward(from: 0).then((_) {
      setState(() => estaGirando = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF302702),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                double angulo = _controller.value * 4 * pi; // 720 grados = 2 vueltas
                double factor = cos(angulo).abs();
                // efecto de que se hace flaquita al girar
                return Transform(
                  transform: Matrix4.identity()..scale(factor, 1.0),
                  alignment: Alignment.center,
                  child: Image.asset(
                    esAguila ? 'assets/aguila.png' : 'assets/sello.png',
                    width: 250, height: 250,
                  ),
                );
              },
            ),
            const SizedBox(height: 60),
            ElevatedButton(
              onPressed: lanzar,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF551B05),
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
              child: const Text("Lanzar Volado", 
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic)),
            ),
          ],
        ),
      ),
    );
  }
}
