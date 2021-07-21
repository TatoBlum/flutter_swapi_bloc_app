part of 'switchmode_bloc.dart';

@immutable
abstract class SwitchmodeEvent {}

class ChangeModeEvent extends SwitchmodeEvent {
  final bool value;

  ChangeModeEvent({this.value});
}
