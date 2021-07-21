import 'package:hive/hive.dart';
import 'package:starwars_urbetrack_app/models/invader_model.dart';

class Boxes {
  static Box<Invader> getInvaders() => Hive.box<Invader>('imv2');
}
