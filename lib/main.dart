import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Volado(),
  ));
}

class Volado extends StatefulWidget {
  const Volado({super.key});
  @override
  State<Volado> createState() => _VoladoState();
}

class _VoladoState extends State<Volado> with SingleTickerProviderStateMixin {
  late AnimationController c;
  bool esAguila = true;

  @override
  void initState() {
    super.initState();
    c = AnimationController(vsync: this, duration: const Duration(milliseconds: 700));
  }

  void lanzar() {
    setState(() => esAguila = Random().nextBool());
    c.forward(from: 0);
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
              animation: c,
              builder: (context, child) {
                double f = cos(c.value * 4 * pi).abs();
                return Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()..scale(f, 1.0),
                  child: Container(
                    width: 200, height: 200,
                    decoration: const BoxDecoration(color: Colors.amber, shape: BoxShape.circle),
                    child: Center(child: Text(esAguila ? "AGUILA" : "SELLO", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold))),
                  ),
                );
              },
            ),
            const SizedBox(height: 60),
            ElevatedButton(
              onPressed: lanzar,
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF551B05)),
              child: const Text("Lanzar Volado"),
            )
          ],
        ),
      ),
    );
  }
}
