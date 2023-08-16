import 'dart:io';
// import 'package:aplikasi_riwayat/Home/riwayate_view.dart';
// import 'package:aplikasi_riwayat/Home/riwayat_view.dart';
import 'package:aplikasi_simatukang/user/detailRiwayat_view.dart';
import 'package:aplikasi_simatukang/user/dashboard_view.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

//page
// import 'package:aplikasi_riwayat/home/home_view.dart';

class riwayatPage extends StatefulWidget {
  final token;
  final nomorTelepon;
  riwayatPage({Key? key, required this.token, required this.nomorTelepon})
      : super(key: key);

  @override
  State<riwayatPage> createState() =>
      _riwayatPageState(token: token.toString(), nomorTelepon: nomorTelepon);
}

class _riwayatPageState extends State<riwayatPage> {
  _riwayatPageState(
      {Key? key, required this.token, required this.nomorTelepon});
  final String token;
  final String nomorTelepon;
  // var token =
  // "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJJc3N1ZXIgb2YgdGhlIEpXVCIsImF1ZCI6IkF1ZGllbmNlIHRoYXQgdGhlIEpXVCIsInN1YiI6IlN1YmplY3Qgb2YgdGhlIEpXVCIsImlhdCI6MTY5MjE3MjA1NCwiZXhwIjoxNjkyMjU4NDU0LCJub21vclRlbGVwb24iOiIwODIyNzU4NDk2NzAifQ.pldzQsErON3N-aVDt1nMuf-csG-lr813JALYOgKHVnI";
  int _currentIndex = 1;
  String _currentMenu = 'Home';
  List? data = [];

  void getFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      // token = prefs.getString("token");
    });
  }

  // API
  Future<String> riwayatPermohonan() async {
    final response = await http.get(
      Uri.parse(
          'http://10.1.12.49/project/APISimatukang/api/TampilPermohonanByNomorTelepon/' +
              nomorTelepon),
      headers: {
        'Authorization': "Bearer " + token,
      },
    );
    if (response.statusCode == 200) {
      setState(() {
        var resBody = json.decode(response.body);
        data = resBody;
      });
    } else {
      setState(() {
        var resBody = json.decode(response.body);
      });
    }
    return "Succses !";
  }

  @override
  void initState() {
    super.initState();
    this.getFromSharedPreferences();
    this.riwayatPermohonan();
  }

  void _changeSelectedNavBar(int index) {
    setState(() {
      _currentIndex = index;

      if (index == 0) {
        _currentMenu = 'Beranda';
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => dashboardPage(
                    token: token,
                    nomorTelepon: nomorTelepon,
                  )),
        );
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
        //       builder: (context) => riwayatePage(
        //             hakAkses: hakAkses,
        //             token: token,
        //             userId: userId,
        //             index: 2,
        //           )),
        // );
      } else if (index == 3) {
        _currentMenu = 'riwayate';
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //       builder: (context) => riwayatePage(
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
                  "Riwayat Permohonan",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.black),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          )),
      body: ListView.builder(
        itemCount: data == null ? 0 : data?.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                data?[index]['data'].length != 0
                    ? Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              child: Column(
                                children: <Widget>[
                                  for (int i = 0;
                                      i < data?[index]['data'].length;
                                      i++)
                                    Card(
                                      child: ListTile(
                                        // leading: Image.asset(
                                        //   'assets/images/iconDocument.png',
                                        //   width: 45,
                                        //   height: 45,
                                        // ),
                                        contentPadding: EdgeInsets.all(15),
                                        title: Text(
                                          data?[index]['data'][i]['nama'],
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        subtitle: Container(
                                          child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Container(
                                                  child: Row(children: <Widget>[
                                                    Text(data?[index]['data'][i]
                                                        ['keluhan']),
                                                  ]),
                                                ),
                                                // Container(
                                                //   child: Row(children: <Widget>[
                                                //     Text('Tanggal : '),
                                                //     Text(data?[index]['data'][0]
                                                //         ['tanggal']),
                                                //   ]),
                                                // ),
                                                // Container(
                                                //   child: Row(children: <Widget>[
                                                //     Text('Lokasi : '),
                                                //     Text(data?[index]['data'][0]
                                                //         ['lokasi']),
                                                //   ]),
                                                // ),
                                                // Container(
                                                //   child: Row(children: <Widget>[
                                                //     Text('Status : '),
                                                //     Text(data?[index]['data'][0]
                                                //         ['status']),
                                                //   ]),
                                                // ),
                                                Container(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    children: <Widget>[
                                                      ElevatedButton(
                                                        onPressed: () {
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        detailRiwayatPage()),
                                                          );
                                                        },
                                                        child: Text(
                                                            'LIhat Detail'),
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                                primary: Color
                                                                    .fromRGBO(
                                                                        1255,
                                                                        202,
                                                                        0,
                                                                        1)),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ]),
                                        ),
                                      ),
                                    )
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    : Container(
                        padding: EdgeInsets.only(left: 5, top: 120),
                        child: Center(
                            child: Column(
                          children: <Widget>[
                            // Image.asset(
                            //   'assets/images/noData.png',
                            //   width: 250,
                            //   height: 250,
                            // ),
                            Text(
                              'Tidak Ada Data yang ditemukan',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            )
                          ],
                        )))
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color.fromRGBO(255, 202, 0, 1),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Permohonan'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'riwayate'),
        ],
        currentIndex: _currentIndex,
        selectedItemColor: Color.fromRGBO(0, 0, 0, 1),
        onTap: _changeSelectedNavBar,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
