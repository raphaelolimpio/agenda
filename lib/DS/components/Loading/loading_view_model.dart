import 'dart:async';

import 'package:flutter/material.dart';

class LoadingViewModel extends StatefulWidget {
  final Duration _duration;
  final Color _color;
  final String _title;

  const LoadingViewModel({
    Key? key,
    Duration duration = const Duration(milliseconds: 300),
    Color color = Colors.white,
    String title = 'Loading...',
  })  : _duration = duration,
        _color = color,
        _title = title;

  @override
  LoadingViewModelState createState() => LoadingViewModelState();
}

class LoadingViewModelState extends State<LoadingViewModel> {
  late Timer _time;

  @override
  void initState() {
    super.initState();
    _time = Timer(widget._duration, () {
      Navigator.of(context).pop();
    });
  }

  @override
  void dispose() {
    _time.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: widget._color,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(width: 16),
            Text(widget._title),
          ],
        ),
      ),
    );
  }
}
