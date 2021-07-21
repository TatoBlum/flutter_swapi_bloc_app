import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:starwars_urbetrack_app/models/invader_model.dart';
import 'package:starwars_urbetrack_app/models/invaders_response_model.dart';
import 'package:starwars_urbetrack_app/models/models.dart';

class ApiServices {
  static final ApiServices _instancia = new ApiServices._internal();

  factory ApiServices() {
    return _instancia;
  }

  ApiServices._internal();

  List<Invader> onDisplayInvaders = [];
  int page = 0;

  Future getInvaders() async {
    page++;
    final queryparams = {'page': page.toString()};
    if (page <= 9) {
      // print("page: $page");
      var url = Uri.https("swapi.dev", "/api/people/", queryparams);
      final response = await http.get(url);
      final invadersResponse =
          InvadersResponse.fromJson(json.decode(response.body));
      onDisplayInvaders = [...onDisplayInvaders, ...invadersResponse.results];
      return invadersResponse.results;
    } else {
      return null;
    }
  }

  Future getHomeworld(Invader invader) async {
    final url = invader.homeworld;
    final response = await http.get(Uri.parse(url));
    final homeworldResponse =
        InvaderHomeworld.fromJson(json.decode(response.body));
    invader.homeWorldName = homeworldResponse.name;
    return homeworldResponse.name;
  }

  Future getVehicles(Invader invader) async {
    if (invader.vehicles.length > 0) {
      final List<String> vehicles = [];
      for (var i = 0; i < invader.vehicles.length; i++) {
        final invaderVehicle = await http.get(Uri.parse(invader.vehicles[i]));
        final result =
            InvaderVehicles.fromJson(json.decode(invaderVehicle.body));
        invader.vehiclesName.add(result.name);
        vehicles.add(result.name);
      }
      vehicles.toSet().toList();
      invader.vehiclesName.toSet().toList();

      return vehicles;
    }
  }

  Future getStarships(Invader invader) async {
    if (invader.starships.length > 0) {
      final List<String> starships = [];
      for (var i = 0; i < invader.starships.length; i++) {
        final invaderStarships =
            await http.get(Uri.parse(invader.starships[i]));
        final result =
            InvaderVehicles.fromJson(json.decode(invaderStarships.body));
        invader.starshipsName.add(result.name);
        starships.add(result.name);
      }
      starships.toSet().toList();
      invader.starshipsName.toSet().toList();

      return starships;
    }
  }

  Future postInvader(Invader invader) async {
    try {
      var body = {
        "userId": 1.toString(),
        "dateTime": DateTime.now().toString(),
        "character_name": invader.name,
      };
      var url = Uri.https("jsonplaceholder.typicode.com", "/posts");

      final result = await http.post((url), body: body);
      if (result.statusCode == 200 || result.statusCode == 201) {
        return result;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
