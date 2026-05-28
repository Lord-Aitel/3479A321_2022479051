import 'package:flutter/material.dart';

class MineCell extends StatelessWidget {
  final bool hasMine;
  final bool isRevealed;
  const MineCell({super.key, required this.hasMine, required this.isRevealed});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black54),
        color: Colors.grey[300],
      ),
      child: Center(
        child: isRevealed
            ? (hasMine
                ? Image.asset('assets/images/mine.png', width: 30, height: 30)
                : const Icon(Icons.check, size: 30, color: Colors.green))
            : const SizedBox.shrink(), // celda vacía al inicio
      ),
    );
  }
}
