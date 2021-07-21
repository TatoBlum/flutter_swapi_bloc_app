import 'package:hive/hive.dart';

part 'invader_model.g.dart';

@HiveType(typeId: 0)
class Invader extends HiveObject {
  Invader({
    this.name,
    this.height,
    this.mass,
    this.hairColor,
    this.skinColor,
    this.eyeColor,
    this.birthYear,
    this.gender,
    this.homeworld,
    this.films,
    this.species,
    this.vehicles,
    this.starships,
    this.created,
    this.edited,
    this.url,
    this.vehiclesName,
    this.starshipsName,
  });

  @HiveField(0)
  String name;
  @HiveField(1)
  String height;
  @HiveField(2)
  String mass;
  @HiveField(3)
  String hairColor;
  @HiveField(4)
  String skinColor;
  @HiveField(5)
  String eyeColor;
  @HiveField(6)
  String birthYear;
  @HiveField(7)
  String gender;
  @HiveField(8)
  String homeworld;
  @HiveField(9)
  String homeWorldName;
  @HiveField(10)
  List<String> films;
  @HiveField(11)
  List<String> species;
  @HiveField(12)
  List<String> vehicles;
  @HiveField(13)
  List<String> vehiclesName;
  @HiveField(14)
  List<String> starships;
  @HiveField(15)
  List<String> starshipsName;
  @HiveField(16)
  DateTime created;
  @HiveField(17)
  DateTime edited;
  @HiveField(18)
  String url;

  factory Invader.fromJson(Map<String, dynamic> json) => Invader(
        name: json["name"],
        height: json["height"],
        mass: json["mass"],
        hairColor: json["hair_color"],
        skinColor: json["skin_color"],
        eyeColor: json["eye_color"],
        birthYear: json["birth_year"],
        gender: json["gender"],
        homeworld: json["homeworld"],
        films: List<String>.from(json["films"].map((x) => x)),
        species: List<String>.from(json["species"].map((x) => x)),
        vehicles: List<String>.from(json["vehicles"].map((x) => x)),
        starships: List<String>.from(json["starships"].map((x) => x)),
        created: DateTime.parse(json["created"]),
        edited: DateTime.parse(json["edited"]),
        url: json["url"],
        vehiclesName: [],
        starshipsName: [],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "height": height,
        "mass": mass,
        "hair_color": hairColor,
        "skin_color": skinColor,
        "eye_color": eyeColor,
        "birth_year": birthYear,
        "gender": gender,
        "homeworld": homeworld,
        "films": List<dynamic>.from(films.map((x) => x)),
        "species": List<dynamic>.from(species.map((x) => x)),
        "vehicles": List<dynamic>.from(vehicles.map((x) => x)),
        "starships": List<dynamic>.from(starships.map((x) => x)),
        "created": created.toIso8601String(),
        "edited": edited.toIso8601String(),
        "url": url,
      };

  Invader copyWith({
    String homeWorld,
    List<String> starshipsName,
    List<String> vehiclesName,
  }) =>
      Invader(
        homeworld: homeWorld ?? this.homeWorldName,
        starshipsName: starshipsName ?? this.starshipsName,
        vehiclesName: vehiclesName ?? this.vehiclesName,
      );
}
