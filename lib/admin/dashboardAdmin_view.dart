import 'dart:io';
import 'package:aplikasi_simatukang/admin/daftarKeluhan_view.dart';
import 'package:aplikasi_simatukang/admin/daftarKeuangan_view.dart';
import 'package:aplikasi_simatukang/user/notifikasi_view.dart';
import 'package:aplikasi_simatukang/user/riwayat_view.dart';
import 'package:aplikasi_simatukang/admin/daftarKeuangan_view.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:carousel_slider/carousel_slider.dart';
//page
// import 'package:aplikasi_dashboardAdmin/home/home_view.dart';

class dashboardAdminPage extends StatefulWidget {
  dashboardAdminPage({
    Key? key,
  }) : super(key: key);

  @override
  State<dashboardAdminPage> createState() => _dashboardAdminPageState();
}

class _dashboardAdminPageState extends State<dashboardAdminPage> {
  _dashboardAdminPageState({
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
          MaterialPageRoute(builder: (context) => dashboardAdminPage()),
        );
      } else if (index == 1) {
        _currentMenu = 'Riwayat';
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => riwayatPage()),
        );
      } else if (index == 2) {
        _currentMenu = 'dashboardAdmin';
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //       builder: (context) => dashboardAdminePage(
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
                "Admin SIMATUKANG",
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
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  "assets/images/LogoSimatukangText2.png",
                  height: 250,
                  width: 250,
                  alignment: Alignment.bottomCenter,
                ),
                Container(
                  width: 300,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary:
                          Color.fromRGBO(255, 202, 0, 1), // Background color
                    ),
                    child: Text(
                      "Daftar Keluhan",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => daftarKeluhanPage()),
                      );
                    },
                  ),
                ),
                Container(
                  width: 300,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary:
                          Color.fromRGBO(255, 202, 0, 1), // Background color
                    ),
                    child: Text(
                      "Daftar Keuangan",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => daftarKeuanganPage()),
                      );
                    },
                  ),
                ),
                Container(
                  width: 300,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary:
                          Color.fromRGBO(255, 202, 0, 1), // Background color
                    ),
                    child: Text(
                      "Riwayat Permohonan",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => dashboardAdminPage()),
                      );
                    },
                  ),
                ),
                Container(
                  width: 300,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red, // Background color
                    ),
                    child: Text(
                      "Keluar",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => dashboardAdminPage()),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color.fromRGBO(255, 202, 0, 1),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person), label: 'dashboardAdmine'),
        ],
        currentIndex: _currentIndex,
        selectedItemColor: Color.fromRGBO(0, 0, 0, 1),
        onTap: _changeSelectedNavBar,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
