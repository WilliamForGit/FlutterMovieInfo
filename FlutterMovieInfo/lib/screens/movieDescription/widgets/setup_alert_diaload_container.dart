import 'dart:ui';

import 'package:MoviePKR/models/Movie.dart';
import 'package:MoviePKR/providers/movieLists_provider.dart';
import 'package:MoviePKR/util/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SetupAlertDialoadContainer extends StatefulWidget {
  final Movie movie;
  // final int id;
  SetupAlertDialoadContainer({Key key, this.movie}) : super(key: key);

  @override
  _SetupAlertDialoadContainerState createState() =>
      _SetupAlertDialoadContainerState(movie);
}

class _SetupAlertDialoadContainerState
    extends State<SetupAlertDialoadContainer> {
  Movie movie;
  _SetupAlertDialoadContainerState(this.movie);
  @override
  Widget build(BuildContext context) {
    final ScrollController _controllerOne = ScrollController();
    var list = Provider.of<MovieLists>(context, listen: false).movieLists;

    return Center(
      child: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            backgroundColor: AppColors.primaryColor.withAlpha(120),
            title: Text(
              'Add to list',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            ),
            content: Builder(
              builder: (context) {
                var height = MediaQuery.of(context).size.height;
                var width = MediaQuery.of(context).size.width;

                return Container(
                    height: height - 100,
                    width: width - 0,
                    child: Scrollbar(
                      radius: Radius.circular(20),
                      thickness: width = 3,
                      controller: _controllerOne,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 5, left: 5),
                        child: ListView.builder(
                            controller: _controllerOne,
                            itemCount: list.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                focusColor: AppColors.thirdColor,
                                splashColor: AppColors.thirdColor,
                                onTap: () {
                                  bool result = Provider.of<MovieLists>(context,
                                          listen: false)
                                      .addFilmToList(movie, index);
                                  result
                                      ? showDialog(
                                          context: context,
                                          builder: (context) {
                                            Future.delayed(Duration(seconds: 1),
                                                () {
                                              Navigator.of(context,
                                                      rootNavigator: true)
                                                  .pop(true);
                                              Navigator.of(context,
                                                      rootNavigator: true)
                                                  .pop(true);
                                            });
                                            return AlertDialog(
                                              backgroundColor:
                                                  Colors.black.withOpacity(0.9),
                                              title: Text(
                                                  'Movie was added successfully',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16)),
                                            );
                                          })
                                      : showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              elevation: 10,
                                              backgroundColor: Color.fromARGB(
                                                      225, 18, 18, 30)
                                                  .withOpacity(0.95),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                              ),
                                              title: Text(
                                                  'Movie has already been added',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16)),
                                              actions: [
                                                TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: Text('OK',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white)))
                                              ],
                                            );
                                          },
                                        );
                                },
                                child: Card(
                                  color: Colors.transparent,
                                  elevation: 0,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(color: Colors.black38),
                                    ),
                                    child: Container(
                                        padding: EdgeInsets.all(8.0),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          gradient: LinearGradient(
                                            begin: Alignment.topRight,
                                            end: Alignment.bottomLeft,
                                            colors: [
                                              AppColors.primaryColor
                                                  .withOpacity(0.5),
                                              AppColors.secondaryColor
                                                  .withOpacity(0.4)
                                            ],
                                          ),
                                        ),
                                        height: 50,
                                        width: double.infinity,
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: <Widget>[
                                            Expanded(
                                                child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 10, top: 5),
                                                  child: Container(
                                                    child: Text(
                                                      list[index].listTitle,
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 16),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ))
                                          ],
                                        )),
                                  ),
                                ),
                              );
                            }),
                      ),
                    ));
              },
            ),
            actionsPadding: EdgeInsets.only(right: 100),
            actions: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.only(right: 10),
                    height: 40,
                    width: 90,
                    child: FloatingActionButton.extended(
                        backgroundColor: AppColors.thirdColor,
                        label: Text('CANCEL', style: TextStyle(fontSize: 12)),
                        onPressed: () {
                          Navigator.of(context).pop();
                        }),
                  ),
                  Container(height: 15),
                ],
              )
            ],
          ),
        );
      }),
    );
  }
}
