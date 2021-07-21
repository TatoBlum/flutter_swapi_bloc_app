import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:starwars_urbetrack_app/bloc/swtichMode_bloc/switchmode_bloc.dart';

import 'package:starwars_urbetrack_app/models/invader_model.dart';
import 'package:starwars_urbetrack_app/services/api_services.dart';
import 'package:starwars_urbetrack_app/widgets/dialog_widget.dart';

class InvaderDetail extends StatelessWidget {
  final Invader invader;
  const InvaderDetail({Key key, this.invader}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final apiServices = ApiServices();

    return BlocBuilder<SwitchmodeBloc, SwitchmodeState>(
        builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Invader Detail'),
          backgroundColor: (!state.mode) ? Colors.blue : Colors.black,
        ),
        body: Center(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  invader.name,
                  style: TextStyle(
                      fontFamily: "DINregular",
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  'Hair: ${invader.hairColor}.',
                  style: TextStyle(fontFamily: "DINregular", fontSize: 18),
                ),
                Text(
                  'Skin Color: ${invader.skinColor}.',
                  style: TextStyle(fontFamily: "DINregular", fontSize: 18),
                ),
                Text(
                  'Home World: ${invader.homeWorldName}.',
                  style: TextStyle(fontFamily: "DINregular", fontSize: 18),
                ),
                if (invader.vehiclesName != null)
                  Text("Vechicles:",
                      style: TextStyle(fontFamily: "DINregular", fontSize: 18)),
                _getInvaderItems(invader.vehiclesName.toSet().toList()),
                if (invader.starshipsName != null)
                  Text("Starships:",
                      style: TextStyle(fontFamily: "DINregular", fontSize: 18)),
                _getInvaderItems(invader.starshipsName.toSet().toList()),
                (!state.mode)
                    ? MaterialButton(
                        onPressed: () async {
                          //POST ACA http
                          final result = await apiServices.postInvader(invader);
                          if (result.runtimeType == Response) {
                            _showDialog(context, "", "Message send!");
                          } else {
                            _showDialog(context, "Please try again",
                                "Something went wrong.");
                          }
                        },
                        child: Text(
                          'Enviar información',
                          style: TextStyle(color: Colors.white),
                        ),
                        color: Colors.blue,
                        shape: StadiumBorder(),
                        elevation: 0,
                        splashColor: Colors.transparent,
                      )
                    : Container(),
              ],
            ),
          ),
        ),
      );
    });
  }

  _getInvaderItems(List vehicles) {
    return new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: vehicles.map((item) {
          return Text(
            " $item,",
            textAlign: TextAlign.center,
            style: TextStyle(fontFamily: "DINregular", fontSize: 18),
          );
        }).toList());
  }

  _showDialog(BuildContext context, String texto, String desc) {
    AlertDialogWidget(
      width: 80,
      context: context,
      text: texto,
      description: desc,
      onPressed: () {},
    );
  }
}
