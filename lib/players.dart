import 'package:flutter/material.dart';

class PlayersPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PlayersPageState();
}

class PlayersPageState extends State<PlayersPage> {
  var players = [
    {'name': 'محمدرضا'},
    {'name': 'کشاورز'},
    {'name': 'مهدی'},
    {'name': 'رهبری'},
    {'name': 'دلیر'},
    {'name': 'رضایی‌نیا'},
    {'name': 'رمضانی'},
    {'name': 'صادق'},
    {'name': 'سیدعلی'},
    {'name': 'طه'},
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
                alignment: Alignment(-1, 0),
                children: <Widget>[
                  TextField(
                    controller: newPlayerName,
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 24,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(500))),
                      hintText: 'افزودن بازیکن جدید',
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      if (newPlayerName.text.trim() == '') return;

                      setState(() {
                        players.add({'name': newPlayerName.text.trim()});
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
              padding: EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 24,
              ),
              child: Text(
                'تعیین نقش‌ها',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                ),
              ),
              shape: StadiumBorder(),
            ),
          ],
        ),
      ),
    );
  }
}
