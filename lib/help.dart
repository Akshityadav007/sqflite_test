
import 'dart:convert';

Lectures lecturesFromJson(String str) => Lectures.fromJson(json.decode(str));
String lecturesToJson(Lectures data) => json.encode(data.toJson());


class Lectures{
  String attendedLectures;
  String totalLectures;
  String primaryKey;

  Lectures({
    this.attendedLectures,
    this.totalLectures,
    this.primaryKey,
});

  factory Lectures.fromJson(Map<String,dynamic> json) => Lectures(
    primaryKey: json['primaryKey'],
    attendedLectures: json['attendedLectures'],
    totalLectures: json['totalLectures'],
  );

  Map<String,dynamic> toJson() => {
    'primaryKey': primaryKey,
    'attendedLectures':attendedLectures,
    'totalLectures':totalLectures,
  };
}