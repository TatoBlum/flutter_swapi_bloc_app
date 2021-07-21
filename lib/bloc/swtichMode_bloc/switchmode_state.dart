part of 'switchmode_bloc.dart';

class SwitchmodeState {
  bool mode;

  SwitchmodeState({bool mode}) : this.mode = mode ?? false;

  SwitchmodeState copyWith({bool mode}) =>
      SwitchmodeState(mode: mode ?? this.mode);

  SwitchmodeState estadoInicial() => SwitchmodeState();
}
