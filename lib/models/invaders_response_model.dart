import 'dart:convert';
import 'package:starwars_urbetrack_app/models/invader_model.dart';

InvadersResponse invadersResponseFromJson(String str) =>
    InvadersResponse.fromJson(json.decode(str));

String invadersResponseToJson(InvadersResponse data) =>
    json.encode(data.toJson());

class InvadersResponse {
  InvadersResponse({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  int count;
  String next;
  dynamic previous;
  List<Invader> results;

  factory InvadersResponse.fromJson(Map<String, dynamic> json) =>
      InvadersResponse(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results:
            List<Invader>.from(json["results"].map((x) => Invader.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}
