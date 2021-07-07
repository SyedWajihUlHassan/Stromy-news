import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stromy/models/favs-model.dart';

import 'article_view.dart';
import 'home.dart';
// import 'home.dart';

class Favorites extends StatefulWidget {
  const Favorites({Key? key}) : super(key: key);

  @override
  _FavoritesState createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  List<Favorite> favorites = <Favorite>[];

  @override
  initState() {
    // favorites = Array;
    super.initState();

    loadFavorites();
  }

  refreshState(prev) {
    print("Wajih BDA");
    List<Favorite> ss = [];
    prev.forEach((s) => {
          ss.add(new Favorite(
              title: s["title"],
              imgUrl: s["imageUrl"],
              desc: s["desc"],
              url: s["url"]))
        });
    setState(() {
      favorites = ss;
    });
  }

  loadFavorites() async {
    var ss = await getFavorites();
    setState(() {
      favorites = ss;
    });
  }

  Future<bool> _onWillPop() async {
    print("On Back Pressed!");

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => Home()),
            (Route<dynamic> route) => false,
      );

    return false;
  }

  Future<List<Favorite>> getFavorites() async {
    favorites.clear();
    final sp = await SharedPreferences.getInstance();
    final settingsObjS = sp.getString('settings') ?? "";
    final settingsObj = jsonDecode(settingsObjS);
    print(settingsObj);
    List<Favorite> favs = [];
    settingsObj['favorites'].forEach((s) => {
          favs.add(new Favorite(
              title: s["title"],
              imgUrl: s["imageUrl"],
              desc: s["desc"],
              url: s["url"]))
        });
    // .map((s) => print(s)).toList();
    return favs;
  }

  Widget build(BuildContext context) {
    // Navigator.pop(context,true);

    return new WillPopScope(
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => Home()),
                  (Route<dynamic> route) => false,
                );
              },
            ),
            title: Padding(
              padding: const EdgeInsets.fromLTRB(50, 0, 0, 0),
              child: Row(
                children: [
                  Text('Stromy'),
                  Text(
                    ' News',
                    style: TextStyle(color: Colors.black),
                  )
                ],
              ),
            ),
            centerTitle: true,
            backgroundColor: Colors.deepOrange,
          ),
          body: SingleChildScrollView(
            child: Container(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  child: ListView.builder(
                      padding: const EdgeInsets.only(top: 16.0),
                      itemCount: favorites.length,
                      physics: const NeverScrollableScrollPhysics(),
                      // scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        bool liked = true;
                        return _BlogTile(
                            imageUrl: favorites[index].imgUrl,
                            title: favorites[index].title,
                            desc: favorites[index].desc,
                            url: favorites[index].url,
                            liked: liked,
                            loadParentFavs: this.refreshState);
                      }),
                ),
              ),
            ),
          ),
        ),
        onWillPop: _onWillPop);
  }
}

class _BlogTile extends StatelessWidget {
  final String imageUrl, title, desc, url;
  final bool liked;
  final loadParentFavs;

  const _BlogTile(
      {required this.imageUrl,
      required this.title,
      required this.desc,
      required this.url,
      required this.liked,
      required this.loadParentFavs});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ArticleView(
                      blogUrl: url,
                    )));
      },
      child: Container(
        decoration: BoxDecoration(
            // gradient: LinearGradient(colors: <Color>[
            //   Colors.deepOrange,
            //   Colors.orangeAccent
            // ]
            // ),
            color: Colors.black,
            borderRadius: BorderRadius.circular(10)),
        margin: EdgeInsets.only(bottom: 16),
        child: Column(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
                child: Image.network(imageUrl)),
            SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 5, 5, 5),
              child: Text(
                title,
                style: TextStyle(
                    fontSize: 17,
                    color: Colors.white,
                    fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 5, 5, 20),
              child: Text(
                desc,
                style: TextStyle(color: Colors.white60),
              ),
            ),
            FavButton(liked, () async {
              print("On Pressed!");
              final favArticle = {
                "imageUrl": imageUrl,
                "title": title,
                "desc": desc,
                "url": url
              };

              final favs = await SharedPreferences.getInstance();
              final settingsObjS = favs.getString('settings') ?? "";

              final settingsObj = jsonDecode(settingsObjS);

              print(settingsObj);
              print("settingsObj");

              // List<Favorite> ss = [];

              settingsObj["favorites"]
                  .removeWhere((element) => element["imageUrl"] == imageUrl);

              // print(settingsObj["favorites"]);

              final finalSettingObj = jsonEncode(settingsObj);
              favs.setString('settings', finalSettingObj);

              loadParentFavs(settingsObj["favorites"]);
            })
          ],
        ),
      ),
    );
  }
}
//
// class __BlogTileState extends State<_BlogTile> {
//   final String imageUrl, title, desc, url;
//   bool liked;
//   final loadParentFavs;
//
//   __BlogTileState(this.imageUrl, this.title, this.desc, this.url, this.liked,
//       this.loadParentFavs);
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//             context,
//             MaterialPageRoute(
//                 builder: (context) => ArticleView(
//                       blogUrl: url,
//                     )));
//       },
//       child: Container(
//         decoration: BoxDecoration(
//             // gradient: LinearGradient(colors: <Color>[
//             //   Colors.deepOrange,
//             //   Colors.orangeAccent
//             // ]
//             // ),
//             color: Colors.black,
//             borderRadius: BorderRadius.circular(10)),
//         margin: EdgeInsets.only(bottom: 16),
//         child: Column(
//           children: [
//             ClipRRect(
//                 borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(10),
//                     topRight: Radius.circular(10)),
//                 child: Image.network(imageUrl)),
//             SizedBox(
//               height: 8,
//             ),
//             Padding(
//               padding: const EdgeInsets.fromLTRB(15, 5, 5, 5),
//               child: Text(
//                 title,
//                 style: TextStyle(
//                     fontSize: 17,
//                     color: Colors.white,
//                     fontWeight: FontWeight.w500),
//               ),
//             ),
//             SizedBox(
//               height: 8,
//             ),
//             Padding(
//               padding: const EdgeInsets.fromLTRB(15, 5, 5, 20),
//               child: Text(
//                 desc,
//                 style: TextStyle(color: Colors.white60),
//               ),
//             ),
//             FavButton(liked, () async {
//               print("On Pressed!");
//               final favArticle = {
//                 "imageUrl": imageUrl,
//                 "title": title,
//                 "desc": desc,
//                 "url": url
//               };
//
//               final favs = await SharedPreferences.getInstance();
//               final settingsObjS = favs.getString('settings') ?? "";
//
//               final settingsObj = jsonDecode(settingsObjS);
//
//               print(settingsObj);
//               print("settingsObj");
//
//               // List<Favorite> ss = [];
//
//               settingsObj["favorites"]
//                   .removeWhere((element) => element["imageUrl"] == imageUrl);
//
//               // print(settingsObj["favorites"]);
//
//               final finalSettingObj = jsonEncode(settingsObj);
//               favs.setString('settings', finalSettingObj);
//
//               loadParentFavs(settingsObj["favorites"]);
//             })
//           ],
//         ),
//       ),
//     );
//   }
//
//   void _stateUpdate() {
//     setState(() {});
//     print("refresh done");
//   }
// }

// class BlogTile extends StatelessWidget {
//   final String imageUrl, title, desc, url;
//   bool liked;
//
//   BlogTile(
//       {required this.imageUrl,
//       required this.title,
//       required this.desc,
//       required this.url,
//       required this.liked});
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//             context,
//             MaterialPageRoute(
//                 builder: (context) => ArticleView(
//                       blogUrl: url,
//                     )));
//       },
//       child: Container(
//         decoration: BoxDecoration(
//             // gradient: LinearGradient(colors: <Color>[
//             //   Colors.deepOrange,
//             //   Colors.orangeAccent
//             // ]
//             // ),
//             color: Colors.black,
//             borderRadius: BorderRadius.circular(10)),
//         margin: EdgeInsets.only(bottom: 16),
//         child: Column(
//           children: [
//             ClipRRect(
//                 borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(10),
//                     topRight: Radius.circular(10)),
//                 child: Image.network(imageUrl)),
//             SizedBox(
//               height: 8,
//             ),
//             Padding(
//               padding: const EdgeInsets.fromLTRB(15, 5, 5, 5),
//               child: Text(
//                 title,
//                 style: TextStyle(
//                     fontSize: 17,
//                     color: Colors.white,
//                     fontWeight: FontWeight.w500),
//               ),
//             ),
//             SizedBox(
//               height: 8,
//             ),
//             Padding(
//               padding: const EdgeInsets.fromLTRB(15, 5, 5, 20),
//               child: Text(
//                 desc,
//                 style: TextStyle(color: Colors.white60),
//               ),
//             ),
//             FavButton(liked, () async {
//               print("On Pressed!");
//               final favArticle = {
//                 "imageUrl": imageUrl,
//                 "title": title,
//                 "desc": desc,
//                 "url": url
//               };
//
//               final favs = await SharedPreferences.getInstance();
//               final settingsObjS = favs.getString('settings') ?? "";
//
//               final settingsObj = jsonDecode(settingsObjS);
//
//               print(settingsObj);
//               print("settingsObj");
//
//               // List<Favorite> ss = [];
//               Map m = new Map();
//
//               settingsObj["favorites"]
//                   .removeWhere((element) => element["imageUrl"] == imageUrl);
//
//               print(settingsObj["favorites"]);
//
//               final finalSettingObj = jsonEncode(settingsObj);
//               favs.setString('settings', finalSettingObj);
//
//             })
//           ],
//         ),
//       ),
//     );
//   }
// }

class FavButton extends StatelessWidget {
  final Function save;
  final bool liked;

  const FavButton(this.liked, this.save);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
          leading: IconButton(
        icon: Icon(liked ? Icons.favorite : Icons.favorite_border,
            color: liked ? Colors.red : Colors.grey),
        onPressed: () {
          save();
        },
      )),
    );
  }
}
//
// class _FavButtonState extends State<FavButton> {
//   bool liked;
//   Function ssave;
//
//   _FavButtonState(this.liked, this.ssave);
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//   }
//
// }
