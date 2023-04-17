import 'dart:developer';

import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({super.key});

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: TextFormField(
        controller: _searchController,
        onChanged: (value) {},
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.search),
          hintText: 'Search dogs...',
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          // borderRadius: BorderRadius.circular(10.0),
          suffixIcon: IconButton(
            onPressed: () {
              final String searchTerm = _searchController.text;
              _searchController.clear();
              log("Searchbar Text --> $searchTerm");
            },
            icon: const Icon(Icons.search),
          ),
        ),
      ),
    );
  }
}
