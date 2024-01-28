import 'package:flutter/material.dart';

class FieldMainWidget extends StatefulWidget {
  final String hint;
  final TextEditingController controller;
  final bool enabledField;


  const FieldMainWidget

  ({super.key, required this.hint, required this.controller, required this.enabledField});

  @override
  State<StatefulWidget> createState() => _FieldMainWidgetState();

}

class _FieldMainWidgetState extends State<FieldMainWidget> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      enabled: widget.enabledField,
      controller: widget.controller,
      decoration: InputDecoration(
        hintText: widget.hint,
        filled: true,
        fillColor: Colors.grey[300],
        border: OutlineInputBorder(
          borderRadius:
          BorderRadius.circular(10.0),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius:
          BorderRadius.circular(10.0),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius:
          BorderRadius.circular(10.0),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

}