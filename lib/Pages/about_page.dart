import 'package:Expenseye/Resources/Strings.dart';
import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.about),
      ),
      body: Container(
        margin: const EdgeInsets.all(40),
        child: Column(
          children: <Widget>[
            Text('Version: ${Strings.versionNumber}'),
            SizedBox(height: 10),
            Text(
              Strings.appBy,
              style: Theme.of(context).textTheme.headline,
            ),
          ],
        ),
      ),
    );
  }
}
