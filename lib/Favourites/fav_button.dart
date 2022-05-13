//###################...Favourites button Refactoring...########################

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:quraanproject/main.dart';
import 'package:quraanproject/model/data_model.dart';

class FavouriteButton extends StatefulWidget {
  String videoPath;
  FavouriteButton({Key? key, required this.isPressed2, required this.videoPath})
      : super(key: key);

  dynamic favList =
      favSongsBox.values == null ? favSongsBox : favSongsBox.get('favList');

  bool isHighlighted = true;
  bool isPressed = true;
  bool isPressed2 = true;

  @override
  State<FavouriteButton> createState() => _FavouriteButtonState();
}

class _FavouriteButtonState extends State<FavouriteButton> {
  @override
  Widget build(BuildContext context) {
    if (favSongsBox == null) {
      var existingItem = widget.favList.firstWhere(
          (itemToCheck) => itemToCheck.favVideo == widget.videoPath,
          orElse: () => null);
      if (existingItem == null) {
        widget.isPressed2 = true;
      } else {
        widget.isPressed2 = false;
      }
    }
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onHighlightChanged: (value) {
        setState(() {
          widget.isHighlighted = !widget.isHighlighted;
        });
      },
      onTap: () {
        setState(() {
          widget.isPressed2 = !widget.isPressed2;
          if (!widget.isPressed2) {
            // addToFavList(widget.videoPath);
          } else {
            // removeFromFav(widget.videoPath);
          }
        });
      },
      child: AnimatedContainer(
        margin: EdgeInsets.all(widget.isHighlighted ? 0 : 2.5),
        height: widget.isHighlighted ? 50 : 45,
        width: widget.isHighlighted ? 50 : 45,
        curve: Curves.fastLinearToSlowEaseIn,
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 20,
              offset: const Offset(5, 10),
            ),
          ],
          color: Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: widget.isPressed2
            ? Icon(
                Icons.favorite_border,
                color: Colors.black.withOpacity(0.6),
              )
            : Icon(
                Icons.favorite,
                color: Color(0xffED3030),
              ),
      ),
    );
  }
}

// ##################################################################################

class MyCustomWidget extends StatefulWidget {
  int favIndex;
  MyCustomWidget({
    Key? key,
    required this.favIndex,
  }) : super(key: key);

  @override
  _MyCustomWidgetState createState() => _MyCustomWidgetState();
}

class _MyCustomWidgetState extends State<MyCustomWidget> {
  
 
  bool isHighlighted = true;
  List<Favourites> favList = favSongsBox.values.toList();

  @override
  Widget build(BuildContext context) {
     bool isPressed2 = checkFavExist(widget.favIndex);
     print(isPressed2);
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onHighlightChanged: (value) {
        setState(() {
          isHighlighted = !isHighlighted;
        });
      },
      onTap: () {
        setState(() {
          isPressed2 = !isPressed2;
          if (isPressed2 == false) {
            final favAdd = Favourites(favNo: widget.favIndex);
            if (checkFavExist(favAdd.favNo)) {
              favSongsBox.add(favAdd);
              print("Added");
            } 
          }else {
              deleteItem(widget.favIndex);
              print("Already Exists");
            }
        });
      },
      child: AnimatedContainer(
        margin: EdgeInsets.all(isHighlighted ? 0 : 2.5),
        height: isHighlighted ? 50 : 45,
        width: isHighlighted ? 50 : 45,
        curve: Curves.fastLinearToSlowEaseIn,
        duration: Duration(milliseconds: 300),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 20,
              offset: Offset(5, 10),
            ),
          ],
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: isPressed2
            ? Icon(
                Icons.favorite_border,
                color: Colors.black.withOpacity(0.6),
              )
            : Icon(
                Icons.favorite,
                color: Colors.pink.withOpacity(1.0),
              ),
      ),
    );
  }

  checkFavExist(int favNo) {
    if (favSongsBox.isNotEmpty) {
      List<Favourites> favlistSong = favSongsBox.values.toList();
      final isExists = favlistSong
          .where((itemToCheck) => itemToCheck.favNo == favNo);
          print("#######################################################################");
      if (isExists.isEmpty) {
        return true; //no matching element found
      } else {
        return false; //matching element found in db
      }
    }
    return true;
  }
  deleteItem(int id) {
    final Map<dynamic, Favourites> deliveriesMap = favSongsBox.toMap();
    dynamic desiredKey;
    deliveriesMap.forEach((key, value){
        if (value.favNo == id)
            desiredKey = key;
    });
    favSongsBox.delete(desiredKey);
  }
}
