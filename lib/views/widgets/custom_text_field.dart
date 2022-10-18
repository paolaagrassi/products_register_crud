import 'package:flutter/material.dart';

class BuildTextField extends StatefulWidget {
  const BuildTextField(
      {required this.labelText, this.controller, this.prefix, Key? key})
      : super(key: key);

  final TextEditingController? controller;
  final Widget? labelText;
  final Widget? prefix;

  @override
  State<BuildTextField> createState() => _BuildTextFieldState();
}

class _BuildTextFieldState extends State<BuildTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      decoration: InputDecoration(
        label: widget.labelText,
        prefix: widget.prefix,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
      ),
    );
  }
}
