
import 'dart:convert';


Map<String, List<Event>> eventFromJson(String str) =>
    Map.from(json.decode(str)).map((k, v) => MapEntry<String, List<Event>>(
        k, List<Event>.from(v.map((x) => Event.fromJson(x)))));

String eventToJson(Map<String, List<Event>> data) =>
    json.encode(Map.from(data).map((k, v) => MapEntry<String, dynamic>(
        k, List<dynamic>.from(v.map((x) => x.toJson())))));

class Event {
  Event({
    this.eventDescp,
    this.eventTitle,
    this.time,
    this.month,
    this.year,
    this.createdOn
  });

  String? eventDescp;
  String? eventTitle;
  String? time;
  String? month;
  String? year;
  DateTime? createdOn;

  factory Event.fromJson(Map<String, dynamic> json) => Event(
      eventDescp: json["eventDescp"],
      eventTitle: json["eventTitle"],
      time: json["time"],
      month:json["month"],
      year: json["year"],
      createdOn: json["createdOn"]

  );

  Map<String, dynamic> toJson() => {
    "eventDescp": eventDescp,
    "eventTitle": eventTitle,
    "time": time,
    'month':month,
    'year':year,
    'createdOn':createdOn
  };

  Event.fromSnapshot(snapshot)
      : eventDescp = snapshot['eventDescp'],
        eventTitle = snapshot['eventTitle'],
        time = snapshot['time'],
        month=snapshot['month'],
        year=snapshot['year'],
        createdOn=snapshot['createdOn'];

}


//
// class Feed {
//   String? image_url;
//   String? title;
//   String? description;
//   Feed({this.image_url, this.title, this.description});
//
//   Feed.fromSnapshot(snapshot)
//       : image_url = snapshot['image_url'],
//         title = snapshot['title'],
//         description = snapshot['description'];
// }