import 'package:fitdiyet_diyetisyen/Models/danisan_model.dart';
import 'package:fitdiyet_diyetisyen/Models/randevu_danisan.dart';

import 'package:fitdiyet_diyetisyen/Views/helpers/size_settings.dart';
import 'package:fitdiyet_diyetisyen/Views/ui/danisan/danisan_profile.dart';
import 'package:fitdiyet_diyetisyen/Views/ui/diyet/diyet_listesi.dart';

import 'package:fitdiyet_diyetisyen/Views/widgets/appbar/arrow_back_appbar.dart';

import 'package:flutter/material.dart';

/// [Detay Sayfası]
class DanisanListViewDetail extends StatefulWidget {
  final RandevuDanisan danisan;
  final Users users;

  const DanisanListViewDetail({Key key, this.danisan, this.users})
      : super(key: key);

  @override
  _DanisanListViewDetailState createState() => _DanisanListViewDetailState();
}

class _DanisanListViewDetailState extends State<DanisanListViewDetail> {
  RandevuDanisan danisanModel;
  Users usersModel;

  bool isFavori = false;
  Color favoriColor = Colors.white;

  void _addFavori() {
    setState(() {
      isFavori = !isFavori;
      isFavori
          ? favoriColor = Color(0xffff0000)
          : favoriColor = Color(0xffffffff);
      print('FAVORİ ÇALIŞTI => $isFavori');
    });
  }

  @override
  void initState() {
    danisanModel = widget.danisan;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: arrowBackAppBar(context),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 15,
              ),
              Card(
                elevation: 50,
                shadowColor: Colors.black,
                color: Colors.purple[700],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: SizedBox(
                  width: displayWidth(context) * 0.9,
                  height: displayHeight(context) * 0.3,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              Align(
                                alignment: Alignment.topRight,
                                child: IconButton(
                                    icon: Icon(
                                      Icons.favorite,
                                      color: favoriColor,
                                    ),
                                    onPressed: _addFavori),
                              ),
                              // Align(
                              //   alignment: Alignment.center,
                              //   child: CircleAvatar(
                              //     backgroundColor: Colors.green[500],
                              //     radius: 40,
                              //     backgroundImage: NetworkImage(
                              //       diyetisyenModel.profilFotografi,
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            danisanModel.danisanAdi.toUpperCase(),
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          // Text(
                          //   danisanModel.saat,
                          //   style: TextStyle(
                          //     fontSize: 15,
                          //     color: Colors.white54,
                          //   ),
                          // ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Flexible(
                                child: Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.orange,
                                    ),
                                    borderRadius: BorderRadius.circular(5.0),
                                    color: Colors.orange[700],
                                  ),
                                  child: IconButton(
                                    icon: Icon(Icons.message),
                                    onPressed: () {},
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Flexible(
                                child: Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.orange,
                                    ),
                                    borderRadius: BorderRadius.circular(5.0),
                                    color: Colors.orange[700],
                                  ),
                                  child: IconButton(
                                    icon: Icon(Icons.video_call_sharp),
                                    onPressed: () {},
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Flexible(
                                child: Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.orange,
                                    ),
                                    borderRadius: BorderRadius.circular(5.0),
                                    color: Colors.orange[700],
                                  ),
                                  child: IconButton(
                                    icon: Icon(Icons.phone),
                                    onPressed: () {},
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              SizedBox(
                height: 15,
              ),
              Card(
                elevation: 50,
                shadowColor: Colors.black,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: SizedBox(
                  width: displayWidth(context) * 0.9,
                  height: displayHeight(context) * 0.3,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 50,
                          ),
                          MaterialButton(
                            color: Theme.of(context).accentColor,
                            shape: StadiumBorder(),
                            child: Text(
                              "Diyet Listesi Hazırla",
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () async {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DiyetListesiOlustur(
                                    dnsnId: int.parse(danisanModel.danisanId),
                                  ),
                                ),
                              );
                            },
                          ),
                          MaterialButton(
                            color: Theme.of(context).accentColor,
                            shape: StadiumBorder(),
                            child: Text(
                              "Tüm Profilini Görüntüle",
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () async {
                               Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DanisanProfile(
                                    danisanId: int.parse(danisanModel.danisanId),
                                  ),
                                ),
                              );
                              print(danisanModel.danisanId);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
