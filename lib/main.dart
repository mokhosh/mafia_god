import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mafia_god/view_roles.dart';
import 'package:mafia_god/players.dart';
import 'package:flutter/material.dart';
import 'package:mafia_god/roles.dart';
import 'package:mafia_god/game.dart';
import 'package:mafia_god/home.dart';

// todo move all arguments ro widget itself

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'راوی مافیا',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        brightness: Brightness.dark,
      ),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('fa'),
      ],
      initialRoute: '/players',
      routes: {
        '/': (context) => HomePage(),
        '/players': (context) => PlayersPage(),
        '/roles': (context) => RolesPage(),
        '/view-roles': (context) => ViewRolesPage(),
        '/game': (context) => GamePage(ModalRoute.of(context).settings.arguments),
      },
    );
  }
}
