import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

void main() => runApp(const PilloApp());

class PilloApp extends StatelessWidget {
  const PilloApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pillo Poncho',
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
  bool esAguila = true;
  bool animando = false;
  int angulo = 0;
  String resultado = "";

  final Color colorFondo = const Color(0xFF302702);
  final Color colorBoton = const Color(0xFF501F0B);

  void lanzar() {
    if (animando) return;
    setState(() {
      esAguila = Random().nextBool();
      resultado = "";
      angulo = 0;
      animando = true;
    });
    animar();
  }

  void animar() {
    Timer(const Duration(milliseconds: 15), () {
      if (angulo < 720) {
        setState(() => angulo += 20);
        animar();
      } else {
        setState(() => animando = false);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => lanzar());
  }

  @override
  Widget build(BuildContext context) {
    // logica igual que tu python: factor = |cos(a)|
    double factor = cos(angulo * pi / 180).abs();
    
    // que imagen toca: cada 90 grados cambia
    bool mostrarAguila;
    if (angulo % 180 < 90) {
      mostrarAguila = esAguila;
    } else {
      mostrarAguila = !esAguila;
    }

    String asset = mostrarAguila ? 'assets/aguila.jpeg' : 'assets/sello.jpeg';

    return Scaffold(
      backgroundColor: colorFondo,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // canvas de 300
            Container(
              width: 300,
              height: 300,
              color: colorFondo,
              child: Center(
                child: Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()..scale(factor, 1.0),
                  child: Image.asset(asset, width: 250, height: 250, fit: BoxFit.contain),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(resultado, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic)),
            const SizedBox(height: 30),
            // boton redondo
            GestureDetector(
              onTap: lanzar,
              child: Container(
                width: 220,
                height: 60,
                decoration: BoxDecoration(
                  color: colorBoton,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.black, width: 3),
                ),
                child: const Center(
                  child: Text(
                    "Lanzar Volado",
                    style: TextStyle(fontFamily: 'Comic Sans MS', fontSize: 16, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic, color: Colors.white),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
