import 'dart:io';
// import 'package:aplikasi_notifikasi/Home/notifikasie_view.dart';
// import 'package:aplikasi_notifikasi/Home/riwayat_view.dart';
import 'package:aplikasi_simatukang/user/detailNotifikasi_view.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:awesome_dialog/awesome_dialog.dart';

//page
// import 'package:aplikasi_notifikasi/home/home_view.dart';

class notifikasiPage extends StatefulWidget {
  notifikasiPage({
    Key? key,
  }) : super(key: key);

  @override
  State<notifikasiPage> createState() => _notifikasiPageState();
}

class _notifikasiPageState extends State<notifikasiPage> {
  _notifikasiPageState({
    Key? key,
  });

  int _currentIndex = 0;
  String _currentMenu = 'Home';
  List? data = [];

  @override
  void initState() {
    super.initState();
  }

  void _changeSelectedNavBar(int index) {
    setState(() {
      _currentIndex = index;

      if (index == 0) {
        _currentMenu = 'Beranda';
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //       builder: (context) => HomePage(
        //             hakAkses: hakAkses,
        //             token: token,
        //             userId: userId,
        //             index: 0,
        //           )),
        // );
      } else if (index == 1) {
        _currentMenu = 'Riwayat';
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //       builder: (context) => RiwayatPage(
        //             hakAkses: hakAkses,
        //             token: token,
        //             userId: userId,
        //             index: 1,
        //           )),
        // );
      } else if (index == 2) {
        _currentMenu = 'Permohonan';
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //       builder: (context) => notifikasiePage(
        //             hakAkses: hakAkses,
        //             token: token,
        //             userId: userId,
        //             index: 2,
        //           )),
        // );
      } else if (index == 3) {
        _currentMenu = 'notifikasie';
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //       builder: (context) => notifikasiePage(
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
          leading: IconButton(
            icon: new Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Notifikasi",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.black),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          )),
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
          Container(
              padding: EdgeInsets.all(10),
              child: Card(
                child: Container(
                  padding: EdgeInsets.all(15),
                  child: Container(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Respon Keluhan | 1234',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Terimakasih sudah menyampaikan keluhan anda. Keluhan anda sudah kami respon',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          detailNotifikasiPage()),
                                );
                              },
                              child: Text('Lihat'),
                              style: ElevatedButton.styleFrom(
                                  primary: Color.fromRGBO(1255, 202, 0, 1)),
                            ),
                          ],
                        ),
                      )
                    ],
                  )),
                  // SizedBox(
                  //   height: 30,
                  // ),
                ),
              ))
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color.fromRGBO(255, 202, 0, 1),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Permohonan'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person), label: 'notifikasie'),
        ],
        currentIndex: _currentIndex,
        selectedItemColor: Color.fromRGBO(0, 0, 0, 1),
        onTap: _changeSelectedNavBar,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
