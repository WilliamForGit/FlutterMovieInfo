import 'package:MoviePKR/screens/savedLists/savedLists_screen.dart';
import 'package:MoviePKR/util/constants.dart';
import 'package:flutter/material.dart';

class PopUpMenu extends StatelessWidget {
  const PopUpMenu({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: AppColors.primaryColor.withOpacity(0.9),
      icon: Icon(Icons.person, color: Colors.white),
      itemBuilder: (context) => [
        PopupMenuItem(
            textStyle: TextStyle(color: Colors.white, fontSize: 16),
            value: 1,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'My Lists',
              ),
            )),
      ],
      onSelected: (value) => {
        if (value == 1)
          {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SavedList()),
            )
          }
      },
    );
  }
}
