import 'dart:convert';

import 'package:fitdiyet_diyetisyen/Controllers/danisan_service.dart';
import 'package:fitdiyet_diyetisyen/Models/randevu_model.dart';
import 'package:fitdiyet_diyetisyen/Views/helpers/size_settings.dart';
import 'package:fitdiyet_diyetisyen/Views/widgets/appbar/arrow_back_appbar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Randevularim extends StatefulWidget {
  const Randevularim({Key key}) : super(key: key);

  @override
  _RandevularimState createState() => _RandevularimState();
}

class _RandevularimState extends State<Randevularim> {
  // ignore: deprecated_member_use
  List<Randevu> randevular = new List<Randevu>();
  final DanisanService danisanervice = DanisanService();
  Randevu randevuModel = Randevu();

  List<Randevu> parseDateBringDiyetisyen(String responseBody) {
    final parsed =
        jsonDecode(responseBody.toString()).cast<Map<String, dynamic>>();

    return parsed.map<Randevu>((json) => Randevu.fromJson(json)).toList();
  }

  Future<List<Randevu>> getRandevu() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var url = baseUrl +
        "diyetisyen/list" +
        "?" +
        "token=" +
        localStorage.getString("token");
    await http.get(
      Uri.parse(url),
    );
    var response = await http.get(Uri.parse(url));
    print('response geliyor : ' + response.body);

    if (response.statusCode == 200) {
      print('asd');
      List<dynamic> list = await jsonDecode(response.body);

      list.map((e) {
        randevuModel = Randevu.fromJson(e);
        print('ss ' + randevuModel.danisanAdi.toString());
      }).toList();

      setState(() {
        randevular = parseDateBringDiyetisyen(response.body);
      });

      return (json.decode(response.body) as List)
          .map((e) => Randevu.fromJson(e))
          .toList();
    } else {
      throw Exception('Not Network ${response.statusCode}');
    }
  }

  Future<List<Randevu>> randevu;
  @override
  void initState() {
    super.initState();
    randevu = getRandevu();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: arrowBackAppBar(context),
      body: SingleChildScrollView(
          padding: EdgeInsets.all(8.0),
          child: Column(children: [
            Expanded(
              flex: 0,
              child: Container(
                width: double.infinity,
                height: displayHeight(context) * 0.9,
                child: ListView.builder(
                    itemCount: randevular.length,
                    scrollDirection: Axis.vertical,
                    physics: ScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      var randevu = randevular[index];
                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        color: Color(0xff654769),
                        elevation: 10,
                        child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              ListTile(
                                leading: Icon(
                                  Icons.access_time_rounded,
                                  size: 50,
                                  color: Colors.white,
                                ),
                                title: Center(
                                  child: Text(
                                    'Danışanınız: ${randevu.danisanAdi}',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                subtitle: Column(
                                  children: [
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "Randevu Saati: ${randevu.saat}",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "Randevu Tarihi: ${randevu.tarih}",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
              ),
            ),
          ])),
    );
  }
}
