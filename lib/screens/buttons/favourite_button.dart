import 'package:flutter/material.dart';
import 'package:quraanproject/Favourites/favourites.dart';


class FavouritesButton extends StatelessWidget {
  const FavouritesButton({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  ElevatedButton(
              style: ElevatedButton.styleFrom(
                  fixedSize: const Size(250, 50),
                  primary: Color.fromARGB(255, 44, 104, 126),
                  onPrimary: Colors.white,
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50))),
              onPressed: () {
                Navigator.push(context, SizeTransition3(Favourite()));
              }
                  ,
              child: Text(
                'FAVOURITES',
                style: TextStyle(fontSize: 23, fontFamily: "font1"),
              ),
            ) ;
    //  return IconButton(onPressed: (){  Navigator.push(context, SizeTransition3(SettingsPage()));}, icon: Icon(Icons.settings,size: 30,));
  }
}
class SizeTransition3 extends PageRouteBuilder {
  final Widget page;

  SizeTransition3(this.page)
      : super(
          pageBuilder: (context, animation, anotherAnimation) => page,
          transitionDuration: Duration(milliseconds: 1000),
          reverseTransitionDuration: Duration(milliseconds: 200),
          transitionsBuilder: (context, animation, anotherAnimation, child) {
            animation = CurvedAnimation(
                curve: Curves.fastLinearToSlowEaseIn,
                parent: animation,
                reverseCurve: Curves.fastOutSlowIn);
            return Align(
              alignment: Alignment.center,
              child: SizeTransition(
                axis: Axis.horizontal,
                sizeFactor: animation,
                child: page,
                axisAlignment: 0,
              ),
            );
          },
        );
}
