part of 'invaders_bloc.dart';

class InvadersState {
  final List<Invader> invaders;
  final Invader invader;
  final String error;

  InvadersState({this.invaders, Invader invader, bool loader, this.error})
      : invader = invader ?? new Invader();

  InvadersState copyWith({List<Invader> invaders, Invader invader}) =>
      InvadersState(
          invaders: invaders ?? this.invaders,
          invader: invader ?? this.invader);

  factory InvadersState.initial() => InvadersState();
}

class LoadingInvaders extends InvadersState {
  final List<Invader> invaders;

  LoadingInvaders({this.invaders});
}

class InvadersLoaded extends InvadersState {
  final List<Invader> invaders;

  InvadersLoaded({this.invaders});
}

class InvadersErrorMessage extends InvadersState {
  final String error;

  InvadersErrorMessage({this.error});
}

class InvadersWithInvaderDetail extends InvadersState {
  final List<Invader> invaders;
  final Invader invader;

  InvadersWithInvaderDetail({this.invaders, this.invader});
}
