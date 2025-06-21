import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; 
import '../provider/app_data.dart'; 

class PreferenciasPage extends StatefulWidget {
  const PreferenciasPage({super.key});

  @override
  State<PreferenciasPage> createState() => _PreferenciasPageState();
}

class _PreferenciasPageState extends State<PreferenciasPage> {


  @override
  Widget build(BuildContext context) {

    final appData = context.watch<AppData>();

    return Scaffold(
      appBar: AppBar(title: const Text('Preferencias')),
      body: Center(
        child: SwitchListTile(
          title: const Text('Habilitar reinicio del contador'),
          value: appData.canReset,
          onChanged: (value) {

            appData.setCanReset(value);
          },
        ),
      ),
    );
  }
}