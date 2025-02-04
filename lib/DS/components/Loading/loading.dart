import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  final String _title;

  const Loading({
    super.key,
    Duration duration = const Duration(milliseconds: 300),
    Color color = Colors.white,
    String title = 'Loading...',
  }) : _title = title;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(width: 16),
            Text(_title),
          ],
        ),
      ),
    );
  }
}
