import 'package:flutter/material.dart';

class AnimatedTextFieldCustom extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final IconData icon;

  const AnimatedTextFieldCustom({
    required this.controller,
    required this.labelText,
    required this.icon,
    super.key,
  });

  @override
  State<AnimatedTextFieldCustom> createState() => _AnimatedTextFieldCustomState();
}

class _AnimatedTextFieldCustomState extends State<AnimatedTextFieldCustom> {
  bool _isFocused = false;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Focus(
        onFocusChange: (hasFocus) {
          setState(() {
            _isFocused = hasFocus;
          });
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(widget.icon, color: _isFocused ? colorScheme.primary : Colors.grey),
                SizedBox(width: 8),
                Expanded(
                  child: TextFormField(
                    controller: widget.controller,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: widget.labelText,
                      hintStyle: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 16,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Requerido';
                      }
                      return null;
                    },
                    style: TextStyle(color: Colors.black87, fontSize: 16),
                  ),
                ),
              ],
            ),
            AnimatedContainer(
              duration: Duration(milliseconds: 300),
              height: 3,
              width: _isFocused ? 150 : 0,
              decoration: BoxDecoration(
                color: colorScheme.primary,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
