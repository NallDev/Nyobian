import 'package:flutter/material.dart';
import 'package:restaurant_app/utils/constant.dart';

class MySearch extends StatefulWidget {
  final Function(String) onTextChanged;
  const MySearch({Key? key, required this.onTextChanged}) : super(key: key);

  @override
  State<MySearch> createState() => _MySearchState();
}

class _MySearchState extends State<MySearch> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: TextField(
        controller: _controller,
        decoration: InputDecoration(
            hintText: searchHint,
            prefixIcon: Icon(Icons.search),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
            filled: true,
            fillColor: Colors.white,
            contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
            suffixIcon: _controller.text.isNotEmpty
                ? GestureDetector(
                    onTap: () {
                      _controller.clear();
                      setState(() {});
                    },
                    child: Icon(Icons.clear),
                  )
                : null),
        onChanged: (value) {
          setState(() {
            widget.onTextChanged(value);
          });
        },
      ),
    );
  }
}
