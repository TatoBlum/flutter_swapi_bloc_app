import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:starwars_urbetrack_app/bloc/invaders_bloc/invaders_bloc.dart';
import 'package:starwars_urbetrack_app/boxes.dart';
import 'package:starwars_urbetrack_app/models/invader_model.dart';
import 'package:starwars_urbetrack_app/services/api_services.dart';

class InvadersList extends StatefulWidget {
  const InvadersList({Key key}) : super(key: key);

  @override
  _InvadersListState createState() => _InvadersListState();
}

class _InvadersListState extends State<InvadersList> {
  InvadersBloc invadersbloc;
  ApiServices apiServices = ApiServices();

  final ScrollController scrollController = new ScrollController();

  @override
  void initState() {
    invadersbloc = BlocProvider.of<InvadersBloc>(context);
    invadersbloc.add(FetchInvadersEvent());

    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 1000) {
        invadersbloc.add(FetchMoreInvadersEvent());
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InvadersBloc, InvadersState>(
      builder: (BuildContext context, state) {
        // print("loading: ${state.invader}");

        if (state is LoadingInvaders) {
          return Center(
            child: Container(
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (state is InvadersLoaded || state is InvadersWithInvaderDetail) {
          return Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      ListView.builder(
                        controller: scrollController,
                        scrollDirection: Axis.vertical,
                        itemCount: state.invaders.length,
                        itemBuilder: (_, int index) {
                          return Container(
                            width: 130,
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Card(
                                    elevation: 0,
                                    color: Color(0xFFf4f4f4),
                                    child: ListTile(
                                      contentPadding:
                                          EdgeInsets.fromLTRB(10, 0, 10, 0),
                                      title: Text(
                                        state.invaders[index].name,
                                        style: TextStyle(
                                            fontFamily: "DINregular",
                                            fontSize: 22),
                                      ),
                                      subtitle: Column(
                                        children: [
                                          Text(
                                            'Gender: ${state.invaders[index].gender}.',
                                            style: TextStyle(
                                                fontFamily: "DINregular",
                                                fontSize: 18),
                                          ),
                                          Text(
                                            'Weight: ${state.invaders[index].mass} Kg.',
                                            style: TextStyle(
                                                fontFamily: "DINregular",
                                                fontSize: 18),
                                          ),
                                          Text(
                                            'Height: ${state.invaders[index].height} cm.',
                                            style: TextStyle(
                                                fontFamily: "DINregular",
                                                fontSize: 18),
                                          ),
                                        ],
                                      ),
                                      trailing: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          MaterialButton(
                                            onPressed: () async {
                                              final Invader invader =
                                                  state.invaders[index];

                                              invadersbloc.add(
                                                  FetchInvaderDetail(
                                                      invader: invader,
                                                      context: context));

                                              var mybox = Boxes.getInvaders();

                                              if (mybox.values
                                                  .contains(invader)) {
                                                invader.save();
                                              }
                                            },
                                            child: Text(
                                              'Invader Detail',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            color: Colors.blue,
                                            shape: StadiumBorder(),
                                            elevation: 0,
                                            splashColor: Colors.transparent,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      if (state.isLoading)
                        Center(
                          child: Container(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
        //if state is InvadersErrorMessage
        else {
          return Container(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Something went wrong. Please try again"),
                  SizedBox(
                    height: 10,
                  ),
                  MaterialButton(
                    onPressed: () async {
                      apiServices.page = 0;
                      await Hive.box<Invader>('imv2').clear();
                      apiServices.onDisplayInvaders.clear();
                      invadersbloc.add(FetchInvadersEvent());
                    },
                    child: Text(
                      'Try Again',
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Colors.blue,
                    shape: StadiumBorder(),
                    elevation: 0,
                    splashColor: Colors.transparent,
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
