import 'package:flutter/material.dart';

class PlayersPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PlayersPageState();
}

class PlayersPageState extends State<PlayersPage> {
  var players = [
    {
      'name': 'ممدرضا',
      'status': '',
      'role': '',
    },
    {
      'name': 'کشا',
      'status': '',
      'role': '',
    },
    {
      'name': 'مهدی',
      'status': '',
      'role': '',
    },
    {
      'name': 'سدمرتضی',
      'status': '',
      'role': '',
    },
    {
      'name': 'دلیر',
      'status': '',
      'role': '',
    },
    {
      'name': 'علی',
      'status': '',
      'role': '',
    },
    {
      'name': 'رمضانی',
      'status': '',
      'role': '',
    },
    {
      'name': 'صادق',
      'status': '',
      'role': '',
    },
    {
      'name': 'سدعلی',
      'status': '',
      'role': '',
    },
    {
      'name': 'ظاهری',
      'status': '',
      'role': '',
    },
    {
      'name': 'طه',
      'status': '',
      'role': '',
    },
    {
      'name': 'رها',
      'status': '',
      'role': '',
    },
    {
      'name': 'صفا',
      'status': '',
      'role': '',
    },
  ];

  TextEditingController newPlayerName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Stack(
                alignment: Alignment(-1,0),
                children: <Widget>[
                    TextField(
                      controller: newPlayerName,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(500)
                          )
                        ),
                        hintText: 'افزودن بازیکن جدید',
                      ),
                    ),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      if (newPlayerName.text.trim() == '') return;

                      setState(() {
                        players.add({
                          'name': newPlayerName.text.trim()
                        });
                      });
                      newPlayerName.clear();
                    },
                  )
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: players
                    .map(
                      (item) => Card(
                        shape: StadiumBorder(),
                        child: ListTile(
                          leading: Icon(
                            Icons.person,
                          ),
                          title: Text(
                            item['name'],
                          ),
                          trailing: IconButton(
                            onPressed: () {
                              setState(() {
                                players.remove(item);
                              });
                            },
                            icon: Icon(
                              Icons.remove_circle,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
            RaisedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/roles', arguments: players);
              },
              child: Text('تعیین تعداد مافیاها'),
              shape: StadiumBorder(),
            ),
          ],
        ),
      ),
    );
  }
}
