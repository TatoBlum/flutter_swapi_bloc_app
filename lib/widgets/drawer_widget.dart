import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starwars_urbetrack_app/bloc/invaders_bloc/invaders_bloc.dart';
import 'package:starwars_urbetrack_app/bloc/swtichMode_bloc/switchmode_bloc.dart';
import 'package:starwars_urbetrack_app/boxes.dart';
import 'package:starwars_urbetrack_app/models/invader_model.dart';
import 'package:starwars_urbetrack_app/services/api_services.dart';

class DraweWidget extends StatefulWidget {
  @override
  _DraweWidgetState createState() => _DraweWidgetState();
}

class _DraweWidgetState extends State<DraweWidget> {
  final storage = Boxes.getInvaders().values;
  ApiServices apiServices = ApiServices();

  SwitchmodeBloc swithBloc;
  InvadersBloc invadersBloc;

  @override
  void initState() {
    swithBloc = BlocProvider.of<SwitchmodeBloc>(context);
    invadersBloc = BlocProvider.of<InvadersBloc>(context);

    super.initState();
  }

  @override
  void dispose() {
    if (apiServices.page == 9) {
      invadersBloc.close();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              child: Center(
                child: Container(
                  child: Text('MENU'),
                ),
              ),
            ),
            Column(
              children: [
                CupertinoSwitch(
                  value: swithBloc.state.mode,
                  onChanged: (value) {
                    if (invadersBloc.state.invaders != null) {
                      List<Invader> invaders = invadersBloc.state.invaders;

                      final mybox = Boxes.getInvaders();
                      if (storage.length == 0) {
                        invaders.forEach((invader) {
                          mybox.add(invader);
                        });
                      } else if (storage.length > 0) {
                        invaders.forEach((invader) {
                          if (!storage.contains(invader)) mybox.add(invader);
                        });
                      }
                    }

                    setState(() {
                      swithBloc.state.mode = value;
                    });
                    swithBloc.add(ChangeModeEvent(value: value));
                  },
                ),
                !swithBloc.state.mode ? Text('Online') : Text('Offline')
              ],
            ),
          ],
        ),
      ),
    );
  }
}
