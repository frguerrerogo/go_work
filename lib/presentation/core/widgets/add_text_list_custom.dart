import 'package:flutter/material.dart';

class AddTextListWidget extends StatefulWidget {
  final List<String> textList;
  final String title;
  final String hintText;
  final String buttonText;
  final ValueChanged<List<String>> onChanged;

  const AddTextListWidget({
    super.key,
    required this.textList,
    required this.title,
    required this.hintText,
    required this.buttonText,
    required this.onChanged,
  });

  @override
  State<AddTextListWidget> createState() => _AddTextListWidgetState();
}

class _AddTextListWidgetState extends State<AddTextListWidget> {
  final TextEditingController _controller = TextEditingController();
  late List<String> _mutableTextList;
  @override
  void initState() {
    super.initState();
    _mutableTextList = List.from(widget.textList);
  }

  void _addTextToList() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        _mutableTextList.add(_controller.text);
        _controller.clear();
        widget.onChanged(_mutableTextList);
      });
    }
  }

  void _removeTextFromList(int index) {
    setState(() {
      _mutableTextList.removeAt(index);
      widget.onChanged(_mutableTextList);
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: colorScheme.onPrimaryContainer,
          width: 1,
        ),
      ),
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            widget.title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: widget.hintText,
                floatingLabelBehavior: FloatingLabelBehavior.always,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: colorScheme.onPrimaryContainer,
                    width: 1,
                  ),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              ),
              style: const TextStyle(fontSize: 14),
              textAlignVertical: TextAlignVertical.center,
              cursorHeight: 20,
            ),
          ),
          ElevatedButton(
            onPressed: _addTextToList,
            style: ElevatedButton.styleFrom(
              backgroundColor: colorScheme.primaryContainer,
              foregroundColor: colorScheme.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              widget.buttonText,
            ),
          ),
          const SizedBox(height: 10),
          Column(
            children: _mutableTextList.asMap().entries.map((entry) {
              int index = entry.key;
              String text = entry.value;
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: colorScheme.primaryContainer,
                ),
                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                padding: const EdgeInsets.all(5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                          text,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete_forever),
                      onPressed: () => _removeTextFromList(index), // Eliminar el texto
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
