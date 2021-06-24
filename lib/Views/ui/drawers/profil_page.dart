import 'dart:io';

import 'package:fitdiyet_diyetisyen/Controllers/danisan_service.dart';
import 'package:fitdiyet_diyetisyen/Views/widgets/appbar/arrow_back_appbar.dart';
import 'package:fitdiyet_diyetisyen/Views/widgets/drawer/profile/profile_form_textfield.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfilPage extends StatefulWidget {
  @override
  _ProfilPageState createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  File _image;
  final picker = ImagePicker();
  final photoNameController = TextEditingController();
  String adiniz;
  final adController = TextEditingController();
  final soyadController = TextEditingController();
  final tcController = TextEditingController();
  final hakkimdaController = TextEditingController();
  final kategoriController = TextEditingController();
  final aciklamaController = TextEditingController();
  final telefonController = TextEditingController();
  String adTxt;
  String soyadTxt;
  String tcTxt;
  String telefonTxt;
  String yasTxt;
  String kategoriTxt;
  String hakkimdaTxt;
  String cinsiyetTxt;

  _postProfileData() {
    DanisanService.upload(_image, adTxt, soyadTxt, tcTxt, telefonTxt, yasTxt,
        kategoriTxt, hakkimdaTxt, cinsiyetTxt);
  }

  _getProfileData() {
    DanisanService.getProfile();
  }

  int _cinsiyet = 0;
  void _handleCinsiyetValue(int cinsiyetValue) {
    setState(() {
      _cinsiyet = cinsiyetValue;

      switch (_cinsiyet) {
        case 0:
          cinsiyetTxt = _cinsiyet.toString();
          print("Cinsiyetim $cinsiyetTxt");
          break;

        case 1:
          cinsiyetTxt = _cinsiyet.toString();
          print("Cinsiyetim: $cinsiyetTxt");
          break;
      }
    });
  }

  prtImage() {
    print(_image);
  }

  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  String userName;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: arrowBackAppBar(context),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(15),
          child: Column(
            children: <Widget>[
              Stack(
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Stack(
                          children: <Widget>[
                            CircleAvatar(
                              radius: 70,
                              child: ClipOval(
                                child: _image != null
                                    ? Image.file(
                                        _image,
                                        fit: BoxFit.fill,
                                        width: 150,
                                        height: 150,
                                      )
                                    : Image.asset("assets/eIFBqS61.jpg"),
                              ),
                            ),
                            Positioned(
                              bottom: 1,
                              right: 1,
                              child: InkWell(
                                onTap: () {
                                  choiceImage();
                                },
                                child: Container(
                                  height: 40,
                                  width: 40,
                                  child: Icon(
                                    Icons.add_a_photo,
                                    color: Colors.white,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.deepOrange,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        ProfileFormTextField(
                          lblText: "Ad",
                          hntText: adiniz,
                          klavyeTipi: TextInputType.name,
                          txtController: adController,
                          onchanged: (String adi) {
                            adTxt = adi;
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        ProfileFormTextField(
                          lblText: "Soyad",
                          klavyeTipi: TextInputType.name,
                          txtController: soyadController,
                          onchanged: (String soyad) {
                            soyadTxt = soyad;
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        ProfileFormTextField(
                          txtController: tcController,
                          klavyeTipi: TextInputType.number,
                          lblText: "T.C",
                          onchanged: (String tc) {
                            tcTxt = tc;
                          },
                        ),
                        ProfileFormTextField(
                          txtController: telefonController,
                          klavyeTipi: TextInputType.phone,
                          lblText: "Telefon",
                          onchanged: (String telefon) {
                            telefonTxt = telefon;
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Align(
                          child: Text("Yaş"),
                          alignment: Alignment.centerLeft,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        DropdownButtonFormField<String>(
                          hint: yasTxt == null
                              ? Text('Yaş')
                              : Text(
                                  yasTxt,
                                  style: TextStyle(color: Colors.blue),
                                ),
                          isExpanded: true,
                          iconSize: 30.0,
                          style: TextStyle(color: Colors.blue),
                          validator: (value) {
                            if (value?.isEmpty ?? true) {
                              return 'Lütfen tüm alanları doldurunuz';
                            }
                            return null;
                          },
                          items:
                              List<int>.generate(100, (int index) => index + 1)
                                  .map(
                            (yas) {
                              return DropdownMenuItem<String>(
                                value: yas.toString(),
                                child: Text(yas.toString()),
                              );
                            },
                          ).toList(),
                          onChanged: (yas) {
                            setState(
                              () {
                                yasTxt = yas;
                              },
                            );
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: Text(
                            "Cinsiyet",
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            new Radio(
                              value: 0,
                              groupValue: _cinsiyet,
                              onChanged: _handleCinsiyetValue,
                            ),
                            new Text(
                              'Erkek',
                              style: new TextStyle(fontSize: 16.0),
                            ),
                            new Radio(
                              value: 1,
                              groupValue: _cinsiyet,
                              onChanged: _handleCinsiyetValue,
                            ),
                            new Text(
                              'Kadın',
                              style: new TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                          ],
                        ),
                        ProfileFormTextField(
                          txtController: kategoriController,
                          klavyeTipi: TextInputType.multiline,
                          lblText: "Kategoriniz",
                          onchanged: (String kategori) {
                            kategoriTxt = kategori;
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        ProfileFormTextField(
                          maxLine: null,
                          txtController: aciklamaController,
                          klavyeTipi: TextInputType.multiline,
                          lblText: "Hakkınızda",
                          onchanged: (String aciklama) {
                            hakkimdaTxt = aciklama;
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: MaterialButton(
                                color: Theme.of(context).accentColor,
                                shape: StadiumBorder(),
                                child: Text(
                                  "GÜNCELLE",
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: () async {
                                  if (_formKey.currentState.validate()) {
                                    _formKey.currentState.save();

                                    //_postProfilePhoto();
                                    _postProfileData();
                                    _getProfileData();
                                  } else {
                                    print("validation failed");
                                  }
                                },
                              ),
                            ),
                            SizedBox(width: 20),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future choiceImage() async {
    var pickedImage = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _image = File(pickedImage.path);
      print("FOTO NAME $_image");
    });
  }
}
