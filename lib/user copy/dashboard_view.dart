import 'dart:io';
import 'package:aplikasi_simatukang/user/permohonan_view.dart';
import 'package:aplikasi_simatukang/user/notifikasi_view.dart';
import 'package:aplikasi_simatukang/user/riwayat_view.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:carousel_slider/carousel_slider.dart';
//page
// import 'package:aplikasi_dashboard/home/home_view.dart';

class dashboardPage extends StatefulWidget {
  dashboardPage({
    Key? key,
  }) : super(key: key);

  @override
  State<dashboardPage> createState() => _dashboardPageState();
}

class _dashboardPageState extends State<dashboardPage> {
  _dashboardPageState({
    Key? key,
  });

  int _currentIndex = 0;
  int _currentIndexCarousel = 0;
  String _currentMenu = 'Home';
  List? data = [];
  List imgList = [
    "https://static01.nyt.com/images/2015/10/24/opinion/24manguel/24manguel-superJumbo.jpg",
    "https://library.stiesia.ac.id/wp-content/uploads/2021/04/photo-1507842217343-583bb7270b66.jpg",
    "https://media.istockphoto.com/photos/wooden-bookshelves-filled-with-books-picture-id1265077901?b=1&k=20&m=1265077901&s=170667a&w=0&h=LBfpUBQC8lwaURRu_3N5H9OQKmKo8kXddLSVCtqJrgc="
  ];

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var a = 0; a < list.length; a++) {
      result.add(handler(a, list[a]));
    }
    return result;
  }

  @override
  void initState() {
    super.initState();
  }

  void _changeSelectedNavBar(int index) {
    setState(() {
      _currentIndex = index;

      if (index == 0) {
        _currentMenu = 'Beranda';
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => dashboardPage()),
        );
      } else if (index == 1) {
        _currentMenu = 'Riwayat';
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => riwayatPage()),
        );
      } else if (index == 2) {
        _currentMenu = 'Permohonan';
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //       builder: (context) => dashboardePage(
        //             hakAkses: hakAkses,
        //             token: token,
        //             userId: userId,
        //             index: 2,
        //           )),
        // );
      } else if (index == 3) {
        _currentMenu = 'dashboarde';
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //       builder: (context) => dashboardePage(
        //             hakAkses: hakAkses,
        //             token: token,
        //             userId: userId,
        //             index: 2,
        //           )),
        // );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    //pemanggilan material
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(255, 202, 0, 1),
        leading: Container(
          padding: EdgeInsets.only(top: 5, left: 15, bottom: 5),
          child: Image.asset(
            'assets/images/LogoSimatukangWhite.png',
            width: 300,
            height: 300,
          ),
        ),
        actions: [
          Container(
            padding: EdgeInsets.only(right: 10),
            child: GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => notifikasiPage()));
              },
              child: Container(
                  padding: EdgeInsets.only(right: 5),
                  child: Center(
                    child: Image.asset(
                      "assets/images/iconNotification.png",
                      height: 25,
                      width: 25,
                      alignment: Alignment.bottomCenter,
                    ),
                  )),
            ),
          )
        ],
        title: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                "Selamat Datang di",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.black),
                textAlign: TextAlign.left,
              ),
              Text(
                "SIMATUKANG",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.black),
                textAlign: TextAlign.left,
              ),
            ],
          ),
        ),
      ),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.only(left: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[],
            ),
          ),
          SizedBox(height: 20),
          CarouselSlider(
            options: CarouselOptions(
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                pauseAutoPlayOnTouch: true,
                enlargeCenterPage: true,
                viewportFraction: 0.8,
                scrollDirection: Axis.horizontal,
                onPageChanged: (indexCarousel, reason) {
                  setState(() {
                    _currentIndexCarousel = indexCarousel;
                  });
                }),
            items: imgList.map((imgUrl) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Image.network(
                      imgUrl,
                      fit: BoxFit.contain,
                      height: 180.0,
                      width: 180.0,
                    ),
                  );
                },
              );
            }).toList(),
          ),
          Container(
              padding: EdgeInsets.all(10),
              child: Card(
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Container(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      // Row 1
                      Text(
                        'Pesan Tukang Langsung',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      SizedBox(height: 10),
                      Container(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                            Container(
                              child: Column(children: <Widget>[
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                permohonanPage()));
                                  },
                                  child: Container(
                                      child: Center(
                                    child: Image.asset(
                                      "assets/images/iconBrush.png",
                                      height: 60,
                                      width: 60,
                                      alignment: Alignment.bottomCenter,
                                    ),
                                  )),
                                ),
                                Text('Sima Cat')
                              ]),
                            ),
                            Container(
                              child: Column(children: <Widget>[
                                GestureDetector(
                                  onTap: () {
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (context) =>
                                    //             registerPage()));
                                  },
                                  child: Container(
                                      child: Center(
                                    child: Image.asset(
                                      "assets/images/iconLantai.png",
                                      height: 60,
                                      width: 60,
                                      alignment: Alignment.bottomCenter,
                                    ),
                                  )),
                                ),
                                Text('Sima Keramik')
                              ]),
                            ),
                            Container(
                              child: Column(children: <Widget>[
                                GestureDetector(
                                  onTap: () {
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (context) =>
                                    //             registerPage()));
                                  },
                                  child: Container(
                                      child: Center(
                                    child: Image.asset(
                                      "assets/images/iconListrik.png",
                                      height: 60,
                                      width: 60,
                                      alignment: Alignment.bottomCenter,
                                    ),
                                  )),
                                ),
                                Text('Sima Listrik')
                              ]),
                            ),
                          ])),
                    ],
                  )),
                  // SizedBox(
                  //   height: 30,
                  // ),
                ),
              )),
          Container(
              padding: EdgeInsets.all(10),
              child: Card(
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Container(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      // Row 2
                      Text(
                        'Aneka Solusi Untuk Rumah Anda',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      Container(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                            Container(
                              child: Column(children: <Widget>[
                                GestureDetector(
                                  onTap: () {
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (context) =>
                                    //             registerPage()));
                                  },
                                  child: Container(
                                      child: Center(
                                    child: Image.asset(
                                      "assets/images/iconBrush.png",
                                      height: 60,
                                      width: 60,
                                      alignment: Alignment.bottomCenter,
                                    ),
                                  )),
                                ),
                                Text('Sima Cat')
                              ]),
                            ),
                            Container(
                              child: Column(children: <Widget>[
                                GestureDetector(
                                  onTap: () {
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (context) =>
                                    //             registerPage()));
                                  },
                                  child: Container(
                                      child: Center(
                                    child: Image.asset(
                                      "assets/images/iconListrik.png",
                                      height: 60,
                                      width: 60,
                                      alignment: Alignment.bottomCenter,
                                    ),
                                  )),
                                ),
                                Text('Sima Listrik')
                              ]),
                            ),
                            Container(
                              child: Column(children: <Widget>[
                                GestureDetector(
                                  onTap: () {
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (context) =>
                                    //             registerPage()));
                                  },
                                  child: Container(
                                      child: Center(
                                    child: Image.asset(
                                      "assets/images/iconAtap.png",
                                      height: 60,
                                      width: 60,
                                      alignment: Alignment.bottomCenter,
                                    ),
                                  )),
                                ),
                                Text('Sima Atap')
                              ]),
                            ),
                          ])),
                      SizedBox(height: 15),
                      // Row 2
                      Container(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                            Container(
                              child: Column(children: <Widget>[
                                GestureDetector(
                                  onTap: () {
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (context) =>
                                    //             registerPage()));
                                  },
                                  child: Container(
                                      child: Center(
                                    child: Image.asset(
                                      "assets/images/iconBocor.png",
                                      height: 60,
                                      width: 60,
                                      alignment: Alignment.bottomCenter,
                                    ),
                                  )),
                                ),
                                Text('Sima Bocor')
                              ]),
                            ),
                            Container(
                              child: Column(children: <Widget>[
                                GestureDetector(
                                  onTap: () {
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (context) =>
                                    //             registerPage()));
                                  },
                                  child: Container(
                                      child: Center(
                                    child: Image.asset(
                                      "assets/images/iconPipa.png",
                                      height: 60,
                                      width: 60,
                                      alignment: Alignment.bottomCenter,
                                    ),
                                  )),
                                ),
                                Text('Sima Pipa')
                              ]),
                            ),
                            Container(
                              child: Column(children: <Widget>[
                                GestureDetector(
                                  onTap: () {
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (context) =>
                                    //             registerPage()));
                                  },
                                  child: Container(
                                      child: Center(
                                    child: Image.asset(
                                      "assets/images/iconAtap.png",
                                      height: 60,
                                      width: 60,
                                      alignment: Alignment.bottomCenter,
                                    ),
                                  )),
                                ),
                                Text('Sima Desain')
                              ]),
                            ),
                          ])),
                    ],
                  )),
                  // SizedBox(
                  //   height: 30,
                  // ),
                ),
              )),
          Container(
            child: Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(left: 20, top: 10),
                    child: Text(
                      'Bacaan untuk inspirasi',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(15),
                    height: 250,
                    child: ListView(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      children: [
                        Card(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.all(10),
                                child: Image.asset(
                                  'assets/images/gambar1.jpg',
                                  width: 200,
                                  height: 120,
                                ),
                              ),
                              Container(
                                  width: 200,
                                  margin: EdgeInsets.all(10),
                                  child: Column(
                                    children: <Widget>[
                                      Text(
                                        'Aneka Solusi Untuk Rumah Anda',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13),
                                      ),
                                      Text(
                                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ',
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    ],
                                  )),
                            ],
                          ),
                        ),
                        Card(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.all(10),
                                child: Image.asset(
                                  'assets/images/gambar1.jpg',
                                  width: 200,
                                  height: 120,
                                ),
                              ),
                              Container(
                                  width: 200,
                                  margin: EdgeInsets.all(10),
                                  child: Column(
                                    children: <Widget>[
                                      Text(
                                        'Aneka Solusi Untuk Rumah Anda',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13),
                                      ),
                                      Text(
                                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ',
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    ],
                                  )),
                            ],
                          ),
                        ),
                        Card(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.all(10),
                                child: Image.asset(
                                  'assets/images/gambar1.jpg',
                                  width: 200,
                                  height: 120,
                                ),
                              ),
                              Container(
                                  width: 200,
                                  margin: EdgeInsets.all(10),
                                  child: Column(
                                    children: <Widget>[
                                      Text(
                                        'Aneka Solusi Untuk Rumah Anda',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13),
                                      ),
                                      Text(
                                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ',
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    ],
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 15)
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color.fromRGBO(255, 202, 0, 1),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Permohonan'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person), label: 'dashboarde'),
        ],
        currentIndex: _currentIndex,
        selectedItemColor: Color.fromRGBO(0, 0, 0, 1),
        onTap: _changeSelectedNavBar,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
