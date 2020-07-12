import 'package:flutter/material.dart';

class FutureTotalBox extends StatelessWidget {
  final String title;
  final Future<double> future;
  final Color textColor;

  FutureTotalBox({
    @required this.title,
    @required this.future,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<double>(
      future: this.future,
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          return Expanded(
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    FittedBox(
                      child: Text(
                        title,
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ),
                    const SizedBox(height: 5),
                    FittedBox(
                      child: Text(
                        '${snapshot.data.toStringAsFixed(2)} \$',
                        style: TextStyle(
                          color: textColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          return Expanded(
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: const Align(
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator(),
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
