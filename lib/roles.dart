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

  @override
  Widget build(BuildContext context) {
    players = ModalRoute.of(context).settings.arguments;
    mafiaCount = players.length < 6 ? 1 : mafiaCount ?? (players.length / 3).floor();

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('تعداد کل بازیکنان: ${players.length}'),
                  Text('تعداد مافیاها:'),
                  players.length < 6 ? Text('1') : NumberPicker.integer(
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
                  InkWell(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Checkbox(
                            value: hasDoctor,
                          ),
                          Text('دکتر داشته باشیم'),
                        ]),
                    onTap: () {
                      setState(() {
                        hasDoctor = !hasDoctor;
                      });
                    },
                  ),
                  InkWell(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Checkbox(
                            value: hasDetective,
                          ),
                          Text('کارآگاه داشته باشیم'),
                        ]),
                    onTap: () {
                      setState(() {
                        hasDetective = !hasDetective;
                      });
                    },
                  ),
                ],
              ),
            ),
            RaisedButton(
              onPressed: () {
                assignRoles();
                Navigator.pushNamed(context, '/view-roles', arguments: players);
              },
              child: Text('مشاهده نقش‌ها'),
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
    roles.shuffle(Random.secure());
    roles.asMap().forEach((i, role) {
      players[i]['role'] = role;
      players[i]['status'] = 'not-seen';
    });
  }
}
