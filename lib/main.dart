import 'package:flutter/material.dart';
import 'package:sqflite_test/help.dart';
import 'package:sqflite_test/next.dart';

import 'database_sql.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlatButton(
              onPressed: () async {
                var newDBLecture = Lectures(
                    primaryKey: 'attendance',
                    attendedLectures: '5',
                    totalLectures: '20');
                DatabaseSql.db.newLectureData(newDBLecture);
                // int _attendanceId = await DatabaseSql.instance.insert({
                //   DatabaseSql.columnName: 5,
                // });
                // int _totalId = await DatabaseSql.instance.insert({
                //   DatabaseSql.columnName: 10,
                // });
                //  print('This is the id: $_attendanceId & $_totalId');
                // _dataFuture = await getAttendance();
              },
              child: Text('Insert'),
              color: Colors.red,
            ),
            FlatButton(
              onPressed: () {

                var result = DatabaseSql.db.update('15', '25');
                print("this is updated: $result");
              },
              child: Text('Update'),
            ),
            RaisedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => NextPage()));
              },
              child: Text('Next'),
            )

            // FlatButton(
            //   onPressed: () async {
            //     // List<Map<String, dynamic>> queryRows =
            //     //     await DatabaseSql.instance.queryAll();
            //     // print("these are the queries: ${queryRows.toList()}");
            //   },
            //   child: Text('Query'),
            //   color: Colors.green,
            // ),
            // Text(text),
            // FlatButton(
            //   onPressed: () async {
            //     // List<Map<String, dynamic>> querRows =
            //     //     await DatabaseSql.instance.showQuery(2);
            //     // setState(() {
            //     //   text = querRows.toString();
            //     // });
            //     // print("This is the required query: $querRows");
            //   },
            //   child: Text('Show required query'),
            //   color: Colors.purple,
            // ),
            // FlatButton(
            //   onPressed: () async {
            //     // int updateId = await DatabaseSql.instance.update(
            //     //     {DatabaseSql.columnId: 2, DatabaseSql.columnName: 4});
            //     // print("This is the number of updated IDs: $updateId");
            //   },
            //   child: Text('Update'),
            //   color: Colors.blue,
            // ),
            // FlatButton(
            //   onPressed: () async {
            //     // int rowsDeleted = await DatabaseSql.instance.delete(2);
            //     // print("The deleted number of rows is: $rowsDeleted");
            //   },
            //   child: Text('Delete'),
            //   color: Colors.yellow,
            // )
          ],
        ),
      ),
    );
  }
}
