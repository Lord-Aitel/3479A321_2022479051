import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

class SensorTestScreen extends StatefulWidget {
  const SensorTestScreen({super.key});

  @override
  State<SensorTestScreen> createState() => _SensorTestScreenState();
}

class _SensorTestScreenState extends State<SensorTestScreen> {
  double x = 0, y = 0, z = 0;

  @override
  void initState() {
    super.initState();
    accelerometerEventStream().listen((event) {
      setState(() {
        x = event.x;
        y = event.y;
        z = event.z;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Prueba de Acelerómetro')),
      body: Center(
        child: Text(
          'x: ${x.toStringAsFixed(2)}\n'
          'y: ${y.toStringAsFixed(2)}\n'
          'z: ${z.toStringAsFixed(2)}',
          style: const TextStyle(fontSize: 24),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
