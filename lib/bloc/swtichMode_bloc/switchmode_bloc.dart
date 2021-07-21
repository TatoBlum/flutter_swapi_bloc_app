import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'switchmode_event.dart';
part 'switchmode_state.dart';

class SwitchmodeBloc extends Bloc<SwitchmodeEvent, SwitchmodeState> {
  SwitchmodeBloc() : super(SwitchmodeState());

  @override
  Stream<SwitchmodeState> mapEventToState(
    SwitchmodeEvent event,
  ) async* {
    if (event is ChangeModeEvent) {
      yield state.copyWith(mode: event.value);
    }
  }
}
