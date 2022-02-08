import 'package:flutter/material.dart';
import 'package:pet_groom/search/search_delegate.dart';


class CustomAppBar extends StatelessWidget {


  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(

      elevation: 4.0,

      actions: [
        /*IconButton(
          onPressed: () => showSearch(
            context: context,
            delegate: AppSearchDelegate(searchServices: List.empty()),
          ),
          icon: const Icon(Icons.search),
        )*/
      ],
    );
  }
}
