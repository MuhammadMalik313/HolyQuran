import 'package:flutter/material.dart';
import 'package:quran/quran.dart' as quran;

class Qurancontent extends StatelessWidget {
  Qurancontent({Key? key, required this.surahno}) : super(key: key);
  int surahno;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        elevation: 0,
        toolbarHeight:100,
        title: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('${quran.getPlaceOfRevelation(surahno)}',style: TextStyle(color: Colors.black,fontSize: 15,fontFamily: "font2"),),
                Text(
                  'سورة ${quran.getSurahNameArabic(surahno)}',
                  style: TextStyle(
                    color: Color.fromARGB(255, 0, 6, 8),
                    fontSize: 30,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                 Text('Ayath No\n    ${quran.getVerseCount(surahno).toString()}',style: TextStyle(color: Colors.black,fontSize: 15,fontFamily: "font2"),),
              ],
            ),
           
          ],
        ),
        centerTitle: true,
        flexibleSpace: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/Luxury-Golden-Frame-PNG-Transparent-Image.png'), fit: BoxFit.contain)),
          ),
        ),
      ),
      body: ListView(
        children:[
           Center(child: Text(quran.basmala,style: TextStyle(color: Colors.black,fontSize: 30,fontWeight: FontWeight.w800,),)),
          Padding(
          padding: const EdgeInsets.all(8),
          child: Container(
            decoration: BoxDecoration(color: Colors.white,),
            child: ListView.builder(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemCount: quran.getVerseCount(surahno),
              itemBuilder: (context, index) {
                int verseno = index + 1;
                return Column(
                  children: [
                    
                    ListTile(
                      
                      title: Text(
                        
                        quran.getVerse(surahno, verseno, verseEndSymbol: true),
                        textAlign: TextAlign.end,
                        style: TextStyle(fontSize: 24,fontWeight: FontWeight.w800),
                      ),
                     
                      
                    ),
                    Image.asset("assets/7262342_preview-removebg-preview.png",fit: BoxFit.fitWidth,height: 10,width: 500)
                  ],
                );
              },
            ),
          ),
        ),
        ] 
      ),
    ));
  }
}
