import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:starwars_urbetrack_app/models/invader_model.dart';
import 'package:starwars_urbetrack_app/pages/InvaderDetail.dart';
import 'package:starwars_urbetrack_app/services/api_services.dart';
part 'invaders_event.dart';
part 'invaders_state.dart';

class InvadersBloc extends Bloc<InvadersEvent, InvadersState> {
  final ApiServices repository;
  InvadersBloc({this.repository}) : super(InvadersState());

  @override
  Stream<InvadersState> mapEventToState(
    InvadersEvent event,
  ) async* {
    if (event is FetchInvadersEvent) {
      if (state.invaders == null) yield LoadingInvaders();
      try {
        List<Invader> invaders = await repository.getInvaders();
        if (state.invaders == null) {
          yield InvadersLoaded(invaders: [...invaders]);
        } else {
          yield InvadersLoaded(invaders: [...state.invaders]);
        }
      } catch (error) {
        yield InvadersErrorMessage(error: error.toString());
      }
    }

    if (event is FetchMoreInvadersEvent) {
      try {
        List<Invader> invaders = await repository.getInvaders();
        if (invaders != null && state.invaders != null) {
          yield InvadersLoaded(
              invaders: [...state.invaders, ...invaders],
              isLoading: !state.isLoading);
        } else {
          yield InvadersLoaded(invaders: [...state.invaders]);
        }
      } catch (e) {
        yield InvadersErrorMessage(error: state.error);
      }
    }

    if (event is FetchInvaderDetail) {
      try {
        yield LoadingInvaders(invaders: [...state.invaders]);

        final String homeWorld = await repository.getHomeworld(event.invader);
        final List<String> vehicles =
            await repository.getVehicles(event.invader);
        final List<String> starships =
            await repository.getStarships(event.invader);

        yield InvadersWithInvaderDetail(
          invaders: [...state.invaders],
          invader: state.invader.copyWith(
            homeWorld: homeWorld,
            vehiclesName: vehicles,
            starshipsName: starships,
          ),
        );

        Navigator.push(
          event.context,
          MaterialPageRoute(
            builder: (context) => InvaderDetail(
              invader: event.invader,
            ),
          ),
        );
      } catch (e) {
        yield InvadersErrorMessage(error: e.toString());
      }
    }
  }
}
