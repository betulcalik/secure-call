import 'package:flutter/material.dart';

class OutlinedCard extends StatelessWidget {
  final Widget child;
  const OutlinedCard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Theme.of(context).colorScheme.outline),
      ),
      child: child,
    );
  }
}
