import 'dart:math';

import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class RolesPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => RolesPageState();
}

class RolesPageState extends State<RolesPage> {
  List players;
  int mafiaCount;
  bool hasDoctor = true;
  bool hasDetective = true;
  bool hasBuff = false;
  bool hasSniper = false;

  @override
  Widget build(BuildContext context) {
    players = ModalRoute.of(context).settings.arguments;
    mafiaCount =
        players.length < 6 ? 1 : mafiaCount ?? (players.length / 3).floor();

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'کل بازیکنان',
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    players.length.toString(),
                    style: TextStyle(fontSize: 64),
                  ),
                  SizedBox(height: 32),
                  if (players.length < 6)
                    Text(
                      'یک مافیا',
                      style: TextStyle(fontSize: 32),
                    ),
                  if (players.length >= 6)
                    Text(
                      'تعداد مافیاها',
                      style: TextStyle(fontSize: 18),
                    ),
                  if (players.length >= 6)
                    NumberPicker.integer(
                      itemExtent: 32,
                      highlightSelectedValue: true,
                      initialValue: mafiaCount,
                      minValue: 1,
                      maxValue: (players.length / 2).floor() - 1,
                      onChanged: (value) {
                        setState(() {
                          mafiaCount = value;
                        });
                      },
                    ),
                  SizedBox(height: 32),
                  Wrap(
                    children: <Widget>[
                      InkWell(
                        child: Container(
                          width: 200,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Checkbox(
                                  value: hasDoctor,
                                ),
                                Text(
                                  'دکتر',
                                  style: TextStyle(fontSize: 18),
                                ),
                              ]),
                        ),
                        onTap: () {
                          setState(() {
                            hasDoctor = !hasDoctor;
                          });
                        },
                      ),
                      InkWell(
                        child: Container(
                          width: 200,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Checkbox(
                                  value: hasDetective,
                                ),
                                Text(
                                  'کارآگاه',
                                  style: TextStyle(fontSize: 18),
                                ),
                              ]),
                        ),
                        onTap: () {
                          setState(() {
                            hasDetective = !hasDetective;
                          });
                        },
                      ),
                      InkWell(
                        child: Container(
                          width: 200,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Checkbox(
                                  value: hasBuff,
                                ),
                                Text(
                                  'رویین‌تن',
                                  style: TextStyle(fontSize: 18),
                                ),
                              ]),
                        ),
                        onTap: () {
                          setState(() {
                            hasBuff = !hasBuff;
                          });
                        },
                      ),
                      InkWell(
                        child: Container(
                          width: 200,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Checkbox(
                                  value: hasSniper,
                                ),
                                Text(
                                  'اسنایپر',
                                  style: TextStyle(fontSize: 18),
                                ),
                              ]),
                        ),
                        onTap: () {
                          setState(() {
                            hasSniper = !hasSniper;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            RaisedButton(
              onPressed: () {
                assignRoles();
                Navigator.pushNamed(context, '/view-roles', arguments: players);
              },
              padding: EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 24,
              ),
              child: Text(
                'مشاهده نقش‌ها',
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

  assignRoles() {
    List roles = List.from(List.filled(players.length, 'شهروند'));
    roles.replaceRange(0, mafiaCount, List.filled(mafiaCount, 'مافیا'));
    roles[roles.indexOf('مافیا')] = 'رئیس مافیا';
    if (hasDoctor) roles[roles.lastIndexOf('شهروند')] = 'پزشک';
    if (hasDetective) roles[roles.lastIndexOf('شهروند')] = 'کارآگاه';
    if (hasBuff) roles[roles.lastIndexOf('شهروند')] = 'رویین‌تن';
    if (hasSniper) roles[roles.lastIndexOf('شهروند')] = 'اسنایپر';
    roles.shuffle(Random.secure());
    roles.asMap().forEach((i, role) {
      players[i]['role'] = role;
      players[i]['status'] = 'not-seen';
    });
  }
}
