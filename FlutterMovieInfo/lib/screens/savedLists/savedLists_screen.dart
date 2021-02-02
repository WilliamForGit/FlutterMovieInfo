import 'package:MoviePKR/models/Movie.dart';
import 'package:MoviePKR/models/movieList.dart';
import 'package:MoviePKR/providers/movieLists_provider.dart';
import 'package:MoviePKR/screens/singleList/singleList_screen.dart';
import 'package:MoviePKR/util/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SavedList extends StatefulWidget {
  @override
  _SavedListState createState() => _SavedListState();
}

class _SavedListState extends State<SavedList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [AppColors.primaryColor, AppColors.secondaryColor],
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: Text(
              'My Movie Lists',
              style: TextStyle(
                fontSize: 24,
              ),
            ),
            centerTitle: true,
          ),
          body: _myList(),
          floatingActionButton: _floatButton(context),
        ));
  }

  TextEditingController textEditingController = TextEditingController();

  ListView _myList() {
    final snapshot = Provider.of<MovieLists>(context, listen: false);
    var list = snapshot.movieLists;

    return ListView.builder(
      itemCount: list.length,
      padding: EdgeInsets.all(10),
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => MovieListScreen(
                        snapshot.movieLists[index].listTitle,
                        snapshot.movieLists[index].movies)));
          },
          child: Card(
            color: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
              child: Container(
                  height: 80,
                  width: double.infinity,
                  color: Colors.transparent,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      SizedBox(
                        width: 110,
                        height: double.infinity,
                        child: Container(
                          child: setImageToMymovielist(
                              snapshot.movieLists[index].movies),
                        ),
                      ),
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 15, 5, 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Flexible(
                              child: Text(
                                snapshot.movieLists[index].listTitle,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                            ),
                            Text(
                              movieCount(snapshot.movieLists[index]
                                  .count),
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      )),
                      Container(
                        child: IconButton(
                            icon: Icon(Icons.close),
                            color: Colors.white,
                            splashColor: Colors.transparent,
                            onPressed: () => setState(
                                () => snapshot.removeList(list[index]))),
                      )
                    ],
                  )),
            ),
          ),
        );
      },
    );
  }

  String movieCount(int count) {
    if (count == 0) {
      return '0 movie';
    } else if (count == 1) {
      return '1 movie';
    } else {
      return count.toString() + ' movies';
    }
  }

  Widget setImageToMymovielist(List<Movie> movies) {
    if (movies.length > 0) {
      if (movies[0].posterPath == null) {
        return Image.asset(
          'assets/images/no-image.png',
        );
      } else {
        return Image(
          image: NetworkImage(ApiData.postersUrl + movies[0].posterPath),
          height: 80,
          width: 75,
        );
      }
    } else {
      return Image.asset(
        'assets/images/no-image.png',
      );
    }
  }

  Widget _floatButton(BuildContext context) {
    return Container(
      width: 130,
      child: FloatingActionButton.extended(
        backgroundColor: AppColors.thirdColor,
        icon: Icon(Icons.add, color: Colors.white, size: 20),
        onPressed: () {
          setState(() {
            show();
          });
        },
        label: Text('New List'),
      ),
    );
  }

  void show() {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
              backgroundColor:
                  Color.fromARGB(225, 18, 18, 30).withOpacity(0.95),
              shape: new RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              title: Text(
                'Create a Movie List',
                style: TextStyle(
                    color: Colors.white60, fontWeight: FontWeight.w300),
                textAlign: TextAlign.center,
              ),
              content: _textInputField(),
              actions: <Widget>[
                _addListButton(),
              ]);
        });
  }

  Widget _textInputField() {
    return TextField(
        autofocus: true,
        maxLength: 30,
        maxLengthEnforced: true,
        controller: textEditingController,
        cursorColor: Colors.white,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelStyle: TextStyle(
              color: Colors.white, fontSize: 14, fontWeight: FontWeight.w300),
          enabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.white70)),
          border: const OutlineInputBorder(),
          labelText: 'List Name',
        ));
  }

  Widget _addListButton() {
    return Padding(
      padding: const EdgeInsets.only(right: 100, left: 100),
      child: FlatButton.icon(
          shape: new RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50)),
          color: AppColors.thirdColor,
          icon: Icon(
            Icons.add_rounded,
            color: Colors.white,
            size: 15.0,
          ),
          label: Text(
            'ADD',
            style: TextStyle(color: Colors.white, fontSize: 15.0),
            textAlign: TextAlign.center,
          ),
          onPressed: () {
            setState(() {
              if (textEditingController.text.trim().isNotEmpty) {
                Provider.of<MovieLists>(context, listen: false)
                    .addNewList(new MovieList(textEditingController.text));
                textEditingController.text = '';
                Navigator.of(context, rootNavigator: true)
                    .pop();

              }
            });
          }),
    );
  }
}
