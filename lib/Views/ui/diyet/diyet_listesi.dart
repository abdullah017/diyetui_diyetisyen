import 'dart:convert';

import 'package:fitdiyet_diyetisyen/Controllers/danisan_service.dart';
import 'package:fitdiyet_diyetisyen/Models/besin_model.dart';
import 'package:fitdiyet_diyetisyen/Models/ogun_model.dart';
import 'package:fitdiyet_diyetisyen/Views/widgets/appbar/arrow_back_appbar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class DiyetListesiOlustur extends StatefulWidget {
  final int dnsnId;
  const DiyetListesiOlustur({Key key, this.dnsnId}) : super(key: key);

  @override
  _DiyetListesiOlusturState createState() => _DiyetListesiOlusturState();
}

class _DiyetListesiOlusturState extends State<DiyetListesiOlustur> {
  int danisanId;
  String _selection;
  String _besinSelectionOne;

  int ogunNo;
  int besinNo;

  // ignore: deprecated_member_use
  List<Besinler> besinler = new List<Besinler>();
  final DanisanService danisanService = DanisanService();
  Besinler besinModel = Besinler();
  List<Besinler> parseDateBringBesin(String responseBody) {
    final parsed =
        jsonDecode(responseBody.toString()).cast<Map<String, dynamic>>();
    return parsed.map<Besinler>((json) => Besinler.fromJson(json)).toList();
  }

  Future<List<Besinler>> getDiyetisyen() async {
    //
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var url = baseUrl +
        "diyetisyen/besinler" +
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
        besinModel = Besinler.fromJson(e);
        print('ss ' + besinModel.besinAdi.toString());
      }).toList();
      setState(() {
        besinler = parseDateBringBesin(response.body);
      });
      return (json.decode(response.body) as List)
          .map((e) => Besinler.fromJson(e))
          .toList();
    } else {
      throw Exception('Not Network ${response.statusCode}');
    }
  }

// ignore: deprecated_member_use
  List<OgunlerElement> ogunler = new List<OgunlerElement>();

  OgunlerElement ogunModel = OgunlerElement();
  List<OgunlerElement> parseDateBringOgun(String responseBody) {
    final parsed = jsonDecode(responseBody);
    print("PARSED BODY : $parsed");
    return parsed['ogunler']
        .map<OgunlerElement>((json) => OgunlerElement.fromJson(json))
        .toList();
  }

  // ignore: missing_return
  Future<List<OgunlerElement>> getOgun() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var url = baseUrl +
        "diyetisyen/ogunler" +
        "?" +
        "token=" +
        localStorage.getString("token");
    await http.get(
      Uri.parse(url),
    );
    var response = await http.get(Uri.parse(url));
    print('response geliyor : ' + response.body);
    if (response.statusCode == 200) {
      final _value = await jsonDecode(response.body);
      print("GELEN VALUE $_value");
      List<dynamic> list = _value["ogunler"];
      print(list);
      list.forEach((e) {
        ogunModel = OgunlerElement.fromJson(e);
        print('ss ' + ogunModel.ogunAdi.toString());
      });
      setState(() {
        ogunler = parseDateBringOgun(response.body);
        print("SETSTATE BODY: ${response.body}");
      });
      print(response.body);
    } else {
      throw Exception('Not Network ${response.statusCode}');
    }
  }

  initState() {
    super.initState();
    getDiyetisyen();
    getOgun();
    danisanId = widget.dnsnId;
  }

  dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: arrowBackAppBar(context),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Öğün seçtikten sonra besinleri seçin.\nÖğün için birden fazla besin eklemek isterseniz öğünü seçip besinleri eklemeye devam edin",
                style: TextStyle(color: Colors.grey),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text("ÖĞÜN ADI"),
            SizedBox(
              height: 10,
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: EdgeInsets.all(10.0),
                  child: DropdownButton(
                    items: ogunler.map((item) {
                      return DropdownMenuItem(
                        child: Text(item.ogunAdi),
                        value: item.id.toString(),
                      );
                    }).toList(),
                    onChanged: (newVal) {
                      setState(() {
                        _selection = newVal;
                        ogunNo = int.parse(_selection);
                        print(_selection);
                      });
                    },
                    value: _selection,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text("BESİN 1"),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButton(
                items: besinler.map((item) {
                  return DropdownMenuItem(
                    child: Text(item.besinAdi),
                    value: item.id.toString(),
                  );
                }).toList(),
                onChanged: (besin) {
                  setState(() {
                    _besinSelectionOne = besin;
                    besinNo = int.parse(_besinSelectionOne);
                    print(_besinSelectionOne);
                  });
                },
                value: _besinSelectionOne,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            MaterialButton(
              color: Theme.of(context).accentColor,
              shape: StadiumBorder(),
              child: Text(
                "Kaydet",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () async {
                print(danisanId);
                postBesinOneri(_selection, _besinSelectionOne, danisanId);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future postBesinOneri(String ogunId, besinId, int danisanId) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var url = baseUrl +
        "program/insert/$danisanId?token=" +
        localStorage.get("token");
    var map = new Map<String, dynamic>();
    map['ogun_id'] = ogunId;
    map['besin_id'] = besinId;
    map['diyetisyen_id'] = localStorage.get("id");

    http.Response response = await http
        .post(
      Uri.parse(url),
      body: map,
    )
        .catchError((e) {
      print(e);
    });
    print(response.body);
    if (response.body.isEmpty) {
      throw Exception('İşlem başarısız.');
    } else {
      return myDialog(context);
    }
  }

  Future<AlertDialog> myDialog(BuildContext context) {
    return showDialog<AlertDialog>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            margin: EdgeInsets.all(8.0),
            child: Form(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[Text("Besin başarıyla kaydedildi")],
              ),
            ),
          ),
          actions: <Widget>[
            // ignore: deprecated_member_use
            FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Tamam")),
          ],
        );
      },
    );
  }
}
