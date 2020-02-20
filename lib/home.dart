import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              shape: StadiumBorder(),
              child: Text(
                'شروع بازی',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                ),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/players');
              },
            ),
            RaisedButton(
              shape: StadiumBorder(),
              child: Text(
                'تنظیمات',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                ),
              ),
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}
