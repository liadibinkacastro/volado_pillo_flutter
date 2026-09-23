import 'dart:math';
import 'package:flutter/material.dart';

void main() => runApp(const VoladoApp());

class VoladoApp extends StatelessWidget {
  const VoladoApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const VoladoPage(),
    );
  }
}

class VoladoPage extends StatefulWidget {
  const VoladoPage({super.key});
  @override
  State<VoladoPage> createState() => _VoladoPageState();
}

class _VoladoPageState extends State<VoladoPage> {
  String moneda = 'assets/aguila';
  final random = Random();

  void lanzar() {
    setState(() {
      bool esAguila = random.nextBool();
      moneda = esAguila ? 'assets/aguila' : 'assets/sello';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // TU ICONO DEL CENTRO
            Image.asset('assets/icono', width: 200, height: 200),
            const SizedBox(height: 20),
            // LA MONEDA
            Image.asset(moneda, width: 250, height: 250),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: lanzar,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
              child: const Text('¡VOLADO!', style: TextStyle(fontSize: 22, color: Colors.black)),
            )
          ],
        ),
      ),
    );
  }
}
