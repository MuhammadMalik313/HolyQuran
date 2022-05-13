import 'package:flutter/material.dart';

class Favourites extends StatelessWidget {
  const Favourites({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        
        appBar: AppBar(
          centerTitle: true,
          title: Text("FAVOURITES",style: TextStyle(
            fontFamily: "font3",
            fontSize: 30,
          )),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(border: Border.all(width: 5, color: Color.fromARGB(255, 245, 150, 143)),  borderRadius: BorderRadius.all(Radius.circular(50)),),
                  child: ListTile(
                    title: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Surath AL Fathiha",style: TextStyle(fontSize: 20,fontFamily: "font2"),),
                    ),
                    trailing: Icon(Icons.play_arrow,color: Colors.red,size: 35,),
                  ),
                ),
                SizedBox(height: 15,),
                Container(
                  decoration: BoxDecoration(border: Border.all(width: 5, color: Color.fromARGB(255, 245, 150, 143)),  borderRadius: BorderRadius.all(Radius.circular(50)),),
                  child: ListTile(
                    title: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Surath AL Nas",style: TextStyle(fontSize: 20,fontFamily: "font2"),),
                    ),
                    trailing: Icon(Icons.play_arrow,color: Colors.red,size: 35,),
                  ),
                ),
                 SizedBox(height: 15,),
                Container(
                  decoration: BoxDecoration(border: Border.all(width: 5, color: Color.fromARGB(255, 245, 150, 143)),  borderRadius: BorderRadius.all(Radius.circular(50)),),
                  child: ListTile(
                    title: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Surath AL baqara",style: TextStyle(fontSize: 20,fontFamily: "font2"),),
                    ),
                    trailing: Icon(Icons.play_arrow,color: Colors.red,size: 35,),
                  ),
                ),
              ],
            ),
        ),
        )
        );
  }
}
