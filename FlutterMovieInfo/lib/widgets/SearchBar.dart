import 'package:MoviePKR/screens/searchResults/search_result.dart';
import 'package:MoviePKR/util/constants.dart';
import 'package:flutter/material.dart';

Widget searchBar(BuildContext context) {
  TextEditingController textEditingController = TextEditingController();

  return Builder(builder: (context) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10),
      child: Material(
        color: AppColors.primaryColor.withOpacity(0.7),
        elevation: 0.0,
        borderRadius: BorderRadius.circular(25.0),
        child: TextFormField(
          style: TextStyle(color: Colors.white),
          controller: textEditingController,
          onFieldSubmitted: (value) {
            _submitSearch(context, value);
          },
          decoration: InputDecoration(
            border: InputBorder.none,
            prefixIcon: IconButton(
                icon: Icon(Icons.search),
                color: Colors.white,
                onPressed: () {
                  _submitSearch(context, textEditingController.text);
                }),
            contentPadding: EdgeInsets.only(left: 15.0, top: 15.0),
            hintText: 'Search for movies',
            hintStyle: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  });
}

void _submitSearch(BuildContext context, String input) {
  if (input.isEmpty) {
    Scaffold.of(context).showSnackBar(SnackBar(
        backgroundColor: AppColors.secondaryColor.withOpacity(0.8),
        content: Text(
          'Search text is empty',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 15),
        )));
  } else {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => new SearchResult(search: input),
        ));
  }
}
