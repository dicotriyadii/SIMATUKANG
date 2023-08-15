import 'dart:async';

import 'package:aplikasi_simatukang/login_view.dart';
import 'package:aplikasi_simatukang/user/keluhan_view.dart';
import 'package:flutter/material.dart';
// import 'package:aplikasi_simatukang/home/home_view.dart';

class SplashScreenPage2 extends StatefulWidget {
  const SplashScreenPage2({Key? key}) : super(key: key);

  @override
  _SplashScreenPage2State createState() => _SplashScreenPage2State();
}

class _SplashScreenPage2State extends State<SplashScreenPage2> {
  TextEditingController username = new TextEditingController();
  TextEditingController tes = new TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
          child: Column(
        children: <Widget>[
          Center(
              child: Container(
                  margin: EdgeInsets.only(top: 90),
                  child: Column(
                    children: <Widget>[
                      Image.asset(
                        "assets/images/gambar1.jpg",
                        height: 300,
                        width: 300,
                        alignment: Alignment.bottomCenter,
                      ),
                      Container(
                        padding: EdgeInsets.all(20),
                        child: Text(
                          'Sampaikan Keluhan Konstruksi anda. Kami akan memberikan solusi terbaik untuk rumah anda',
                          style: TextStyle(fontSize: 20),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Container(
                        width: 300,
                        margin: EdgeInsets.only(top: 30),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Color.fromRGBO(
                                255, 202, 0, 1), // Background color
                          ),
                          child: Text(
                            "Menyampaikan Keluhan",
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => keluhanPage()),
                            );
                          },
                        ),
                      ),
                      Container(
                        width: 300,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Color.fromRGBO(
                                255, 202, 0, 1), // Background color
                          ),
                          child: Text(
                            "Nanti Dulu",
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()),
                            );
                          },
                        ),
                      )
                    ],
                  )))
        ],
      )),
    );
  }
}
