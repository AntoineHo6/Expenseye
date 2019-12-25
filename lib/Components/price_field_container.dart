import 'package:expense_app_beginner/Resources/Strings.dart';
import 'package:flutter/material.dart';

class PriceFieldContainer extends StatelessWidget {
  final TextEditingController controller;
  final bool isPriceInvalid;
  final Function infoChanged;

  PriceFieldContainer(this.controller, this.isPriceInvalid, this.infoChanged);

  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.amber, // * Temporary
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.symmetric(horizontal: 20),
      //color: Colors.blueAccent,
      child: Column(
        children: <Widget>[
          SizedBox(
            width: double.infinity,
            child: Text(
              Strings.price + ' :',
              textAlign: TextAlign.left,
              style: Theme.of(context).textTheme.title,
            ),
          ),
          TextField(
            maxLength: 10,
            controller: controller,
            onChanged: infoChanged,
            decoration: InputDecoration(
              hintText: Strings.price,
              errorText: isPriceInvalid
                  ? Strings.price + ' ' + Strings.isInvalid
                  : null,
            ),
            keyboardType: TextInputType.number,
          ),
        ],
      ),
    );
  }
}
