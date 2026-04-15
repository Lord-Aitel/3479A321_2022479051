import 'package:flutter/material.dart';

class MineCell extends StatelessWidget {
  final bool hasMine;
  const MineCell({super.key, required this.hasMine});

  @override
  Widget build(BuildContext context) {
    //final theme = Theme.of(context);

        return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        // Icono nativo de Flutter
        Icon(Icons.timer, size: 30, color: Colors.black54),
        SizedBox(width: 8),
        //Icon(Icons.add_circle_outline, size: 30, color: Colors.black54),
        // Icono desde assets
        //Image.asset('assets/icons/deadline.png', width: 30, height: 30),
      ],
    );
  }
}
