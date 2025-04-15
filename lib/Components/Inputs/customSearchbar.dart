import 'package:flutter/material.dart';

class Customsearchbar extends StatefulWidget {
  final TextEditingController controller;
  final List<String> suggestions;

  const Customsearchbar({required this.controller, required this.suggestions});
  @override
  State<Customsearchbar> createState() => _CustomsearchbarState();
}

class _CustomsearchbarState extends State<Customsearchbar> {
  @override
  Widget build(BuildContext context) {
    return SearchAnchor(
      builder: (BuildContext context, SearchController controller) {
        return SearchBar(
          shadowColor: WidgetStatePropertyAll(null),
          shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))),
          hintStyle: WidgetStatePropertyAll(
            TextStyle(color: Colors.white12),
          ),
          hintText: 'Klub poctivých skautu',
          controller: widget.controller,
          textStyle: WidgetStatePropertyAll(
              TextStyle(color: Colors.white70, fontSize: 18)),
          backgroundColor:
              WidgetStatePropertyAll(Color.fromARGB(255, 26, 27, 29)),
          leading: const Icon(
            Icons.search,
            color: Colors.white24,
          ),
        );
      },
      suggestionsBuilder: (BuildContext context, SearchController controller) {
        return List<ListTile>.generate(4, (int index) {
          return ListTile(
            title: Text(widget.suggestions[index]),
            onTap: () {
              setState(() {
                controller.closeView(widget.suggestions[index]);
              });
            },
          );
        });
      },
    );
  }
}
