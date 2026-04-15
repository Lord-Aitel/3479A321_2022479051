import 'package:flutter/material.dart';

class MineCell extends StatelessWidget {
  final bool hasMine;
  const MineCell({super.key, required this.hasMine});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.secondary,
        border: Border.all(color: theme.colorScheme.outline, width: 1.5),
      ),
      child: Center(
        child: hasMine
            ? const Icon(Icons.warning, color: Colors.red)
            : const Icon(Icons.check, color: Colors.green),
      ),
    );
  }
}
