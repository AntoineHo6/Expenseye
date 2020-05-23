import 'package:Expenseye/Resources/Strings.dart';
import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {

  const AboutPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.about),
      ),
      body: Container(
        margin: const EdgeInsets.all(40),
        child: Column(
          children: <Widget>[
            const Text('Version: ${Strings.versionNumber}'),
            const SizedBox(height: 10),
            Text(
              Strings.appBy,
              style: Theme.of(context).textTheme.headline5,
            ),
          ],
        ),
      ),
    );
  }
}
