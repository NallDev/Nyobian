import 'package:flutter/material.dart';
import 'package:restaurant_app/utils/constant.dart';

class MySearch extends StatefulWidget {
  final Function(String) onTextChanged;
  final Function() onClearText;
  const MySearch({Key? key, required this.onTextChanged, required this.onClearText}) : super(key: key);

  @override
  State<MySearch> createState() => _MySearchState();
}

class _MySearchState extends State<MySearch> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextField(
        controller: _controller,
        decoration: InputDecoration(
            hintText: searchHint,
            prefixIcon: const Icon(Icons.search),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
            suffixIcon: _controller.text.isNotEmpty
                ? GestureDetector(
                    onTap: () {
                      _controller.clear();
                      widget.onClearText();
                    },
                    child: const Icon(Icons.clear),
                  )
                : null),
        onChanged: (value) {
          widget.onTextChanged(value);
        },
      ),
    );
  }
}