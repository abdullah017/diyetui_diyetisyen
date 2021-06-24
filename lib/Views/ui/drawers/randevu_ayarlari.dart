import 'package:fitdiyet_diyetisyen/Controllers/danisan_service.dart';
import 'package:fitdiyet_diyetisyen/Views/widgets/appbar/arrow_back_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class RandevuAyarlari extends StatefulWidget {
  const RandevuAyarlari({Key key}) : super(key: key);

  @override
  _RandevuAyarlariState createState() => _RandevuAyarlariState();
}

class _RandevuAyarlariState extends State<RandevuAyarlari> {
  String _date = "Tarih Seçin";
  String _timeStart = "Saat Seçin";
  String _timeEnd = "Saat Seçin";
  String _allTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: arrowBackAppBar(context),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Randevu için müsait olduğunuz tarih ve zaman dilimini girin.\nSeansların başlangıç ve bitiş saatlerini seçin\nSeçtiğiniz saatler seansların seçilen tarihte ne kadar süreceğini belirler",
              ),
              SizedBox(
                height: 25,
              ),
              // ignore: deprecated_member_use
              RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
                elevation: 4.0,
                onPressed: () {
                  DatePicker.showDatePicker(context,
                      theme: DatePickerTheme(
                        containerHeight: 210.0,
                      ),
                      showTitleActions: true,
                      minTime: DateTime(2000, 1, 1),
                      maxTime: DateTime(2022, 12, 31), onConfirm: (date) {
                    print('confirm $date');
                    _date = '${date.year}-${date.month}-${date.day}';
                    setState(() {});
                  }, currentTime: DateTime.now(), locale: LocaleType.tr);
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 50.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.date_range,
                                  size: 18.0,
                                  color: Colors.teal,
                                ),
                                Text(
                                  " $_date",
                                  style: TextStyle(
                                      color: Colors.teal,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      Text(
                        "  SEÇ",
                        style: TextStyle(
                            color: Colors.teal,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0),
                      ),
                    ],
                  ),
                ),
                color: Colors.white,
              ),
              SizedBox(
                height: 20.0,
              ),
              // ignore: deprecated_member_use
              RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
                elevation: 4.0,
                onPressed: () {
                  DatePicker.showTimePicker(context,
                      theme: DatePickerTheme(
                        containerHeight: 210.0,
                      ),
                      showTitleActions: true, onConfirm: (time) {
                    print('confirm $time');
                    _timeStart = time.minute <= 9
                        ? '0${time.hour}:0${time.minute}'
                        : '${time.hour}:${time.minute}';
                    setState(() {});
                  }, currentTime: DateTime.now(), locale: LocaleType.tr);
                  setState(() {});
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 50.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.access_time,
                                  size: 18.0,
                                  color: Colors.teal,
                                ),
                                Text(
                                  " $_timeStart",
                                  style: TextStyle(
                                      color: Colors.teal,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      Text(
                        "  SEÇ",
                        style: TextStyle(
                            color: Colors.teal,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0),
                      ),
                    ],
                  ),
                ),
                color: Colors.white,
              ),
              SizedBox(
                height: 20,
              ),
              // ignore: deprecated_member_use
              RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
                elevation: 4.0,
                onPressed: () {
                  DatePicker.showTimePicker(context,
                      theme: DatePickerTheme(
                        containerHeight: 210.0,
                      ),
                      showTitleActions: true, onConfirm: (timeEnd) {
                    print('confirm $timeEnd');
                    _timeEnd = timeEnd.minute <= 9
                        ? '0${timeEnd.hour}:0${timeEnd.minute}'
                        : '${timeEnd.hour}:${timeEnd.minute}';
                    setState(() {});
                  }, currentTime: DateTime.now(), locale: LocaleType.tr);
                  setState(() {});
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 50.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.access_time,
                                  size: 18.0,
                                  color: Colors.teal,
                                ),
                                Text(
                                  " $_timeEnd",
                                  style: TextStyle(
                                      color: Colors.teal,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      Text(
                        "  SEÇ",
                        style: TextStyle(
                            color: Colors.teal,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0),
                      ),
                    ],
                  ),
                ),
                color: Colors.white,
              ),
              SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  MaterialButton(
                    color: Theme.of(context).accentColor,
                    shape: StadiumBorder(),
                    child: Text(
                      "GÜNCELLE",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      if (_date != null &&
                          _timeStart != null &&
                          _timeEnd != null) {
                        _date = _date.substring(0, 8).trim().toString();

                        _allTime = _timeStart.trim() + " - " + _timeEnd.trim();
                        print(_allTime);
                        DanisanService.postRandevuAyar(_allTime, _date);
                      }
                    },
                  ),
                  SizedBox(width: 20),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
