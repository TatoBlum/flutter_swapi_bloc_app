import 'package:flutter/material.dart';
import 'package:starwars_urbetrack_app/models/invader_model.dart';
import 'package:starwars_urbetrack_app/pages/InvaderDetail.dart';

class InvadersOfflineList extends StatefulWidget {
  final List<Invader> invaders;
  InvadersOfflineList({Key key, this.invaders}) : super(key: key);

  @override
  _InvadersOfflineListState createState() =>
      _InvadersOfflineListState(invaders);
}

class _InvadersOfflineListState extends State<InvadersOfflineList> {
  final List<Invader> invaders;

  _InvadersOfflineListState(this.invaders);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[400],
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(8),
              itemCount: invaders.length,
              itemBuilder: (BuildContext context, int index) {
                final invader = invaders[index];
                return ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Card(
                    elevation: 0,
                    color: Color(0xFFf4f4f4),
                    child: ListTile(
                      contentPadding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                      title: Text(
                        invader.name,
                        style:
                            TextStyle(fontFamily: "DINregular", fontSize: 22),
                      ),
                      subtitle: Text(
                        '${invader.gender}',
                        style:
                            TextStyle(fontFamily: "DINregular", fontSize: 22),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          MaterialButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => InvaderDetail(
                                    invader: invader,
                                  ),
                                ),
                              );
                            },
                            child: Text(
                              'Ver detalle',
                              style: TextStyle(color: Colors.white),
                            ),
                            color: Colors.black,
                            shape: StadiumBorder(),
                            elevation: 0,
                            splashColor: Colors.transparent,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
