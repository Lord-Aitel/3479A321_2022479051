import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:logger/logger.dart';



class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }
  final Logger logger = Logger();


  void _decrementCounter() {
  setState(() {
    _counter--;
  });
}
void _resetCounter() {
  setState(() {
    _counter = 0;
  });
}



  @override
  Widget build(BuildContext context) {
    logger.i("Logger is working!");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SvgPicture.asset(
              'assets/icons/icono1.svg',
              width: 100,
              height: 100,              
            ),
            const Text(
              'Has presionado el botón esta cantidad de veces:',
            ),            
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      persistentFooterButtons: [
        ElevatedButton.icon(
          onPressed: _decrementCounter,
          icon: const Icon(Icons.remove),
          label: const Text('Restar'),
        ),
        ElevatedButton.icon(
          onPressed: _incrementCounter,
          icon: const Icon(Icons.add),
          label: const Text('Sumar'),
        ),
        ElevatedButton.icon(
          onPressed: _resetCounter,
          icon: const Icon(Icons.refresh),
          label: const Text('Reiniciar'),
        ),
      ],
 // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}