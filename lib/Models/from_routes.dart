// To parse this JSON data, do
//
//     final fromRoutes = fromRoutesFromJson(jsonString);

import 'dart:convert';

FromRoutes fromRoutesFromJson(String str) =>
    FromRoutes.fromJson(json.decode(str));

String fromRoutesToJson(FromRoutes data) => json.encode(data.toJson());

class FromRoutes {
  List<Route> routes;

  FromRoutes({
    required this.routes,
  });

  factory FromRoutes.fromJson(Map<String, dynamic> json) => FromRoutes(
        routes: List<Route>.from(json["routes"].map((x) => Route.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "routes": List<dynamic>.from(routes.map((x) => x.toJson())),
      };
}

class Route {
  String from;

  Route({
    required this.from,
  });

  factory Route.fromJson(Map<String, dynamic> json) => Route(
        from: json["from"],
      );

  Map<String, dynamic> toJson() => {
        "from": from,
      };
}
