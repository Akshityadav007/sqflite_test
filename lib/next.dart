import 'package:flutter/material.dart';
import 'package:sqflite_test/database_sql.dart';

class NextPage extends StatefulWidget {
  @override
  _NextPageState createState() => _NextPageState();
}

class _NextPageState extends State<NextPage> {
  Map<String, String> newLectureData = {};
  Future _dataFuture;

  getAttendance() async {
    final _attendanceData = await DatabaseSql.db.getLecture();
    return _attendanceData;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _dataFuture = getAttendance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FutureBuilder(
                future: _dataFuture,
                builder: (_, attendanceData) {
                  switch (attendanceData.connectionState) {
                    case ConnectionState.none:
                      return Container();
                    case ConnectionState.waiting:
                      return Container();
                    case ConnectionState.active:
                      return Container();
                    case ConnectionState.done:
                      if (!newLectureData.containsKey('primaryKey')) {
                        newLectureData =
                            Map<String, String>.from(attendanceData.data);
                      }
                      return Column(
                        children: <Widget>[
                          Text(newLectureData['attendedLectures']),
                          Text(newLectureData['totalLectures']),
                        ],
                      );
                  }
                  return Container();
                }),
            RaisedButton(onPressed: ()=>Navigator.pop(context),child: Text('back'),),
          ],
        ),
      ),
    );
  }
}
