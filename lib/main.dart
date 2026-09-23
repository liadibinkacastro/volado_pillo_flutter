import 'dart:math';
import 'package:flutter/material.dart';

void main() => runApp(const PilloPonchoApp());

class PilloPonchoApp extends StatelessWidget {
  const PilloPonchoApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: VoladoScreen(),
    );
  }
}

class VoladoScreen extends StatefulWidget {
  const VoladoScreen({super.key});
  @override
  State<VoladoScreen> createState() => _VoladoScreenState();
}

class _VoladoScreenState extends State<VoladoScreen> with SingleTickerProviderStateMixin {
  static const Color colorFondo = Color(0xFF302702);
  static const Color colorBoton = Color(0xFF501F0B);

  late AnimationController _ctrl;
  bool esAguila = true;
  double angulo = 720; // para que no anime al inicio
  bool animando = false;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 800));
    _ctrl.addListener(() {
      setState(() {
        angulo = _ctrl.value * 720;
      });
    });
    // lanzar inicial como en tu codigo
    WidgetsBinding.instance.addPostFrameCallback((_) => lanzar());
  }

  void lanzar() {
    if (animando) return;
    animando = true;
    esAguila = Random().nextBool();
    _ctrl.forward(from: 0).then((_) => animando = false);
  }

  @override
  Widget build(BuildContext context) {
    // logica igual a la tuya: cos para aplastar
    double factor = cos(angulo * pi / 180).abs();
    bool mostrarAguila = (angulo % 180 < 90) ? esAguila : !esAguila;
    String asset = mostrarAguila ? 'assets/aguila.png' : 'assets/sello.png';

    return Scaffold(
      backgroundColor: colorFondo,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Tu canvas de 300x300
            SizedBox(
              width: 300,
              height: 300,
              child: Center(
                child: Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()..scale(max(0.1, factor), 1.0, 1.0),
                  child: Image.asset(asset, width: 250, height: 250, fit: BoxFit.contain),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Tu label (aunque en tu codigo lo dejaste vacio)
            const SizedBox(height: 20),
            // Tu boton redondo igualito
            GestureDetector(
              onTap: lanzar,
              child: Container(
                width: 220,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.black, // borde negro
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.all(3), // grosor del borde
                child: Container(
                  decoration: BoxDecoration(
                    color: colorBoton,
                    borderRadius: BorderRadius.circular(17),
                  ),
                  child: const Center(
                    child: Text(
                      "Lanzar Volado",
                      style: TextStyle(
                        fontFamily: 'ComicSans', // Flutter usa la que encuentre, queda igual
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
