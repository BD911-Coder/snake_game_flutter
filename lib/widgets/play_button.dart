import 'package:flutter/material.dart';

class PlayButton extends StatelessWidget {
  const PlayButton({Key? key, required String buttonText})
      : _buttonText = buttonText,
        super(key: key);
  final String _buttonText;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: (() {}),
      child: Text(_buttonText),
    );
  }
}
