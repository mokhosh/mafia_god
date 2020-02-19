import 'package:flutter/material.dart';

class ViewRolesPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ViewRolesPageState();
}

class ViewRolesPageState extends State<ViewRolesPage> {
  List players;

  @override
  Widget build(BuildContext context) {
    players = ModalRoute.of(context).settings.arguments;

    if (players.indexWhere((player) => player['status'] != 'alive') == -1) {
      return Scaffold(
        body: Center(
          child: RaisedButton(
            onLongPress: () {
              Navigator.pushNamed(context, '/game', arguments: players);
            },
            child: Text('من راوی هستم'),
            shape: StadiumBorder(),
          ),
        ),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: GridView.count(
          padding: EdgeInsets.all(8),
          crossAxisCount: 3,
          children: players
              .map((player) => Opacity(
                    opacity: player['status'] == 'alive' ? 0 : 1,
                    child: InkWell(
                      splashColor: Colors.red,
                      onLongPress: () {
                        if (player['status'] == 'not-seen') {
                          setState(() {
                            player['status'] = 'seen';
                          });
                        }
                      },
                      onTap: () {
                        if (player['status'] == 'seen') {
                          setState(() {
                            player['status'] = 'alive';
                          });
                        }
                      },
                      child: Card(
                        child: Container(
                          padding: EdgeInsets.all(8),
                          alignment: Alignment.center,
                          child: Text(player['status'] == 'seen'
                              ? player['role']
                              : player['name']),
                        ),
                      ),
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
