import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:quraanproject/screens/surahindex.dart';
import 'package:quran/quran.dart' as quran;
import 'package:quran/surah_data.dart';
class ChapterButton extends StatefulWidget {
  const ChapterButton({Key? key}) : super(key: key);

  @override
  State<ChapterButton> createState() => _ChapterButtonState();
}

class _ChapterButtonState extends State<ChapterButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          fixedSize: const Size(250, 50),
          primary: Colors.cyan,
          elevation: 5,
          onPrimary: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))),
      child: const Text(
        'SURAH INDEX',
        style: TextStyle(fontSize: 23, fontFamily: "font1"),
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SlideAnimation1()),
        );
      },
    );
  }
}

class SlideAnimation1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double _w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                showSearch(context: context, delegate: Mysearch());
              },
              icon: const Icon(Icons.search))
        ],
        
          title: Text(
            "Surah Index",
            style: TextStyle(fontFamily: "font4", fontSize: 30),
          ),
          centerTitle: true,
          brightness: Brightness.dark),
      body: AnimationLimiter(
        child: ListView.builder(
          padding: EdgeInsets.all(_w / 30),
          physics:
              BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          itemCount: 114,
          itemBuilder: (BuildContext c, int i) {
            int surahno = i + 1;
            return AnimationConfiguration.staggeredList(
              position: i,
              delay: Duration(milliseconds: 100),
              child: SlideAnimation(
                duration: Duration(milliseconds: 2500),
                curve: Curves.fastLinearToSlowEaseIn,
                horizontalOffset: 30,
                verticalOffset: 300.0,
                child: FlipAnimation(
                  duration: Duration(milliseconds: 3000),
                  curve: Curves.fastLinearToSlowEaseIn,
                  flipAxis: FlipAxis.y,
                  child: Container(
                    child: ListTile(
                      
                      title: Text(
                        quran.getSurahName(surahno),
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: "font3",
                        ),
                      ),
                      subtitle: Text(quran.getSurahNameEnglish(surahno)),
                      trailing: Text(
                        quran.getSurahNameArabic(surahno),
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (ctx) => Qurancontent(surahno: surahno)));
                      },
                    ),
                    margin: EdgeInsets.only(bottom: _w / 20),
                    height: _w / 5,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 40,
                          spreadRadius: 10,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
class Mysearch extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            if (query.isEmpty) {
              close(context, null);
            } else {
              query = '';
            }
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Text(query),
    );
  }
  var quranList=[];
  
    
  
  @override
  Widget buildSuggestions(BuildContext context) {
    quranList.clear();
    for(var i=1;i<=114;i++){
      quranList.add(quran.getSurahName(i));
      
      
    }
    final List listItems;
    if (query.isEmpty) {
      listItems = quranList;
    } else {
      listItems = quranList
            .where((element) => element
                .toLowerCase()
                .contains(query.toLowerCase().toString()))
            .toList();

    }
           

    return listItems.isEmpty
        ? const Center(child: Text("No Data Found!"))
        : ListView.builder(
            itemCount: listItems.length,
            itemBuilder: (context, index) {
              int i;

              return Padding(
                  padding: const EdgeInsets.only(left: 15.00, right: 15.00),
                  child: Column(
                    children: [
                     ListTile(
                      
                      title: Text(
                        listItems[index],
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: "font3",
                        ),
                      ),
                      //  subtitle: Text(quran.getSurahNameEnglish()),
                      // trailing: Text(
                      //   quran.getSurahNameArabic(index),
                      //   style: TextStyle(
                      //       fontSize: 22, fontWeight: FontWeight.bold),
                      // ),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (ctx) => Qurancontent(surahno: index+1)));
                      },
                    ),
                      
                    ],
                  ));
            });
  }
}