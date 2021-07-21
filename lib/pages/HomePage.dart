import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:starwars_urbetrack_app/bloc/swtichMode_bloc/switchmode_bloc.dart';
import 'package:starwars_urbetrack_app/boxes.dart';
import 'package:starwars_urbetrack_app/models/invader_model.dart';
import 'package:starwars_urbetrack_app/widgets/drawer_widget.dart';
import 'package:starwars_urbetrack_app/widgets/invadersList.dart';
import 'package:starwars_urbetrack_app/widgets/invadersOffLineList.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SwitchmodeBloc swithBloc;

  @override
  void initState() {
    swithBloc = BlocProvider.of<SwitchmodeBloc>(context);

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SwitchmodeBloc, SwitchmodeState>(
        builder: (context, state) {
      return Scaffold(
          appBar: AppBar(
            backgroundColor:
                (!swithBloc.state.mode) ? Colors.blue : Colors.black,
            title: Text('Invaders'),
          ),
          drawer: DraweWidget(),
          body: ValueListenableBuilder<Box<Invader>>(
            valueListenable: Boxes.getInvaders().listenable(),
            builder: (context, box, _) {
              final invaders = box.values.toList().cast<Invader>();
              return buildContent(invaders);
            },
          ));
    });
  }

  buildContent(List<Invader> invaders) {
    return BlocBuilder<SwitchmodeBloc, SwitchmodeState>(
      builder: (context, state) {
        if (!state.mode)
          return InvadersList();
        else
          return InvadersOfflineList(invaders: invaders);
      },
    );
  }
}
