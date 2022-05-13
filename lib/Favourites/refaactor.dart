//###################...Favourites button Refactoring...########################

import 'package:flutter/material.dart';
import 'package:quraanproject/main.dart';

class Favourites extends StatefulWidget {
  String videoPath;
  Favourites({Key? key, required this.isPressed2, required this.videoPath})
      : super(key: key);

  dynamic favList = favSongsBox.values == null ? favSongsBox : favSongsBox.get('favList');

  bool isHighlighted = true;
  bool isPressed = true;
  bool isPressed2 = true;

  @override
  State<Favourites> createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
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