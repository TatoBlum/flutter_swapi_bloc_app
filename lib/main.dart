import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:starwars_urbetrack_app/bloc/invaders_bloc/invaders_bloc.dart';
import 'package:starwars_urbetrack_app/bloc/swtichMode_bloc/switchmode_bloc.dart';
import 'package:starwars_urbetrack_app/models/invader_model.dart';
import 'package:starwars_urbetrack_app/pages/HomePage.dart';
import 'package:starwars_urbetrack_app/services/api_services.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(InvaderAdapter());

  await Hive.openBox<Invader>('imv2');
  await Hive.box<Invader>('imv2').clear();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => InvadersBloc(repository: ApiServices()),
        ),
        BlocProvider(
          create: (_) => SwitchmodeBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        home: HomePage(),
      ),
    );
  }
}
