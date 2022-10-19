import 'package:flutter/material.dart';

class BuildButton extends StatefulWidget {
  const BuildButton(
      {required this.buttonTitle,
      this.width,
      this.height,
      this.onPressed,
      Key? key})
      : super(key: key);

  final String buttonTitle;
  final double? width;
  final double? height;
  final void Function()? onPressed;

  @override
  State<BuildButton> createState() => _BuildButtonState();
}

class _BuildButtonState extends State<BuildButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: ElevatedButton(
        onPressed: widget.onPressed,
        child: Text(widget.buttonTitle),
        style: ElevatedButton.styleFrom(
          primary: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
      ),
    );
  }
}
