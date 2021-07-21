part of 'invaders_bloc.dart';

abstract class InvadersEvent {}

class FetchInvadersEvent extends InvadersEvent {}

class FetchMoreInvadersEvent extends InvadersEvent {}

class FetchInvaderDetail extends InvadersEvent {
  final Invader invader;
  final BuildContext context;

  FetchInvaderDetail({this.invader, this.context});
}
