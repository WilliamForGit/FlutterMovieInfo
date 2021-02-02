import 'package:MoviePKR/screens/mainPage/widgets/PopUpMenuButton.dart';
import 'package:MoviePKR/widgets/SearchBar.dart';
import 'package:flutter/material.dart';

class SliverBar extends StatelessWidget {
  const SliverBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 180,
      floating: true,
      pinned: true,
      snap: true,
      elevation: 50,
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      title: Text(
        'The Movie App',
        style: TextStyle(fontSize: 26),
      ),
      centerTitle: true,
      flexibleSpace: FlexibleSpaceBar(
        background: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 80.0),
            Padding(
              padding: const EdgeInsets.all(5),
              child: Container(
                  width: double.infinity,
                  child: Column(
                    children: [
                      searchBar(context),
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text('Trending',
                              style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700)),
                        ),
                      )
                    ],
                  )),
            ),
          ],
        ),
      ),
      actions: <Widget>[PopUpMenu()],
    );
  }
}
