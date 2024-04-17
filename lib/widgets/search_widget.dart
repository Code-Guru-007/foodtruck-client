import 'package:flutter/material.dart';

import 'package:treatlab_new/helper/defines.dart';

class SearchWidget extends StatelessWidget {
  final String hintText;
  final VoidCallbackWithString onSearch;

  const SearchWidget({
    super.key,
    this.hintText = 'Search',
    required this.onSearch,
  });

  @override
  Widget build(BuildContext context) => SearchBar(
        hintText: hintText,
        backgroundColor: MaterialStateColor.resolveWith(
          (states) => Colors.white,
        ),
        surfaceTintColor: MaterialStateColor.resolveWith(
          (states) => const Color(0xFFFFF4E7),
        ),
        overlayColor: MaterialStateColor.resolveWith(
          (states) => Colors.white,
        ),
        shadowColor: MaterialStateColor.resolveWith(
          (states) => Colors.transparent,
        ),
        leading: const Icon(Icons.search),
        shape: MaterialStateProperty.all(
          const ContinuousRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
            side: BorderSide(width: 0.2),
          ),
        ),
        onChanged: (text) => onSearch(text),
      );
}
