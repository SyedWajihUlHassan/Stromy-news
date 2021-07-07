import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';

// import 'package:localstore/localstore.dart';
import 'package:stromy/helper/data.dart';
import 'package:stromy/helper/news.dart';
import 'package:stromy/models/article_model.dart';
import 'package:stromy/models/category_model.dart';
import 'package:stromy/views/about.dart';
import 'package:stromy/views/article_view.dart';
import 'package:stromy/views/favorites.dart';
import 'package:stromy/models/favs-model.dart';
import 'package:stromy/views/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategoryModel> categories = <CategoryModel>[];
  List<ArticleModel> articles = <ArticleModel>[];

  // final db = Localstore.instance;

  bool _loading = true;
  List<Favorite> favorites = <Favorite>[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkArray();
    categories = getCategories();
    getNews();
  }

  getNews() async {
    News newsClass = News();
    await newsClass.getNews();
    articles = newsClass.news;
    setState(() {
      _loading = false;
    });
  }

  checkArray() async {
    final sp = await SharedPreferences.getInstance();
    var favArray = sp.getString('settings') ?? "";
    if (favArray.startsWith('[')) {
      favArray = "";
    }

    if (favArray == "") {
      sp.setString('settings', '{"favorites":[]}');
    }
    loadSettings(favArray);
  }

  loadSettings(String settingsObjS) {
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
    setState(() {
      favorites.addAll(favs);
    });
  }

  // saveToFav() {
  //   final id = db.collection('favoriteList').doc().id;
  //   late String imageUrl, title, desc, url;
  //
  //
  //
  //   db.collection('favoriteList').doc(id).set(
  //     {
  //       'imageUrl' : imageUrl,
  //       'title' : title,
  //       'desc' : desc,
  //       'url' : url
  //
  //     }
  //   );
  // }

  FutureOr onGoBack(dynamic value) {
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.fromLTRB(50, 0, 0, 0),
          child: Row(
            children: [
              Text('Stromy'),
              Text(
                'News',
                style: TextStyle(color: Colors.black),
              )
            ],
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepOrange,
      ),
      body: _loading
          ? Center(
              child: Container(
                margin: const EdgeInsets.fromLTRB(0, 130, 0, 0),
                child: Column(children: [
                  Image.asset(
                    'images/logo.png',
                    width: 120,
                    height: 120,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(80.0),
                    child: CircularProgressIndicator(),
                  )
                ]),
              ),
            )
          : SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: <Widget>[
                    ///Categories
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Container(
                        height: 70,
                        child: ListView.builder(
                            itemCount: categories.length,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return CategoryTile(
                                imageUrl: categories[index].imageUrl,
                                categoryName: categories[index].categoryName,
                              );
                            }),
                      ),
                    ),

                    ///Blogs
                    Container(
                      child: ListView.builder(
                          padding: const EdgeInsets.only(top: 16.0),
                          itemCount: articles.length,
                          physics: const NeverScrollableScrollPhysics(),
                          // scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            String tit = articles[index].title;
                            bool liked = favorites
                                .any((element) => element.title == tit);

                            return BlogTile(
                                imageUrl: articles[index].urlToImage,
                                title: tit,
                                desc: articles[index].description,
                                url: articles[index].url,
                                liked: liked);
                          }),
                    )
                  ],
                ),
              ),
            ),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: <Color>[Colors.deepOrange, Colors.orangeAccent])),
              child: Container(
                child: Column(
                  children: <Widget>[
                    Material(
                      borderRadius: BorderRadius.all(Radius.circular(50.0)),
                      elevation: 10,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Image.asset(
                          'images/logo.png',
                          width: 80,
                          height: 80,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Stromy',
                            style:
                                TextStyle(color: Colors.white, fontSize: 20.0),
                          ),
                          Text(
                            'News',
                            style:
                                TextStyle(color: Colors.black, fontSize: 20.0),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            CustomListTile(
                Icons.home,
                'Home',
                (BuildContext context) => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Home()),
                      )
                    }),
            CustomListTile(
                Icons.favorite,
                'Favorites',
                (BuildContext context) => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Favorites()),
                      ).then((value) => getNews()),
                    }),
            CustomListTile(
                Icons.info,
                'About',
                (BuildContext context) => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => About()),
                      )
                    }),
            CustomListTile(Icons.logout, 'LogOut',
                (BuildContext context) async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.remove('settings');
              await prefs.remove('email');
              await prefs.remove('password');
              await Future.delayed(Duration(seconds: 2));

              Navigator.of(context).pushAndRemoveUntil(
                // the new route
                MaterialPageRoute(
                  builder: (BuildContext context) => Login(),
                ),

                // this function should return true when we're done removing routes
                // but because we want to remove all other screens, we make it
                // always return false
                (Route route) => false,
              );
            }),
          ],
        ),
      ),
    );
  }
}

class CategoryTile extends StatelessWidget {
  final imageUrl, categoryName;

  CategoryTile({this.imageUrl, this.categoryName});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.only(right: 16),
        child: Stack(
          children: <Widget>[
            ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Image.network(
                  imageUrl,
                  width: 120,
                  height: 60,
                  fit: BoxFit.cover,
                )),
            Container(
              alignment: Alignment.center,
              width: 120,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Colors.black26,
              ),
              child: Text(
                categoryName,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CustomListTile extends StatelessWidget {
  IconData icon;
  String text;
  Function onTap;

  CustomListTile(this.icon, this.text, this.onTap);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
      child: Container(
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey.shade300))),
        child: InkWell(
          splashColor: Colors.orangeAccent,
          onTap: () => onTap(context),
          child: Container(
            height: 50,
            child: Row(
              children: <Widget>[
                Icon(icon),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    text,
                    style: TextStyle(fontSize: 16.0),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BlogTile extends StatelessWidget {
  final String imageUrl, title, desc, url;
  var liked = false;

  BlogTile(
      {required this.imageUrl,
      required this.title,
      required this.desc,
      required this.url,
      required this.liked});

  //
  // _saveToFav() async {
  //   final favArticle = {
  //     "imageUrl": imageUrl,
  //     "title": title,
  //     "desc": desc,
  //     "url": url
  //   };
  //
  //   final favs = await SharedPreferences.getInstance();
  //   final favArray = favs.getString('favsArray') ?? "";
  //
  //   Map Array = jsonDecode(favArray);
  //
  //   Array.addAll(favArticle);
  //   print(Array);
  // }

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
              if (liked) {
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
              } else {
                final favs = await SharedPreferences.getInstance();
                final settingsObjS = favs.getString('settings') ?? "";

                final settingsObj = jsonDecode(settingsObjS);

                if (settingsObj["favorites"]
                        .where((element) => element["imageUrl"] == imageUrl)
                        .length > 0) {
                  return;
                }

                settingsObj["favorites"].add(favArticle);
                print(settingsObj["favorites"]);

                final finalSettingObj = jsonEncode(settingsObj);
                favs.setString('settings', finalSettingObj);
              }
            })
          ],
        ),
      ),
    );
  }
}

class FavButton extends StatefulWidget {
  final Function save;
  final bool liked;

  const FavButton(this.liked, this.save);

  @override
  _FavButtonState createState() => _FavButtonState(liked, save);
}

class _FavButtonState extends State<FavButton> {
  bool liked;
  Function ssave;

  _FavButtonState(this.liked, this.ssave);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
          leading: IconButton(
        icon: Icon(liked ? Icons.favorite : Icons.favorite_border,
            color: liked ? Colors.red : Colors.grey),
        onPressed: () {
          setState(() {
            ssave();
            liked = !liked;
          });
        },
      )),
    );
  }
}


