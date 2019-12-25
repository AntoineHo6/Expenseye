import 'package:expense_app_beginner/Resources/Strings.dart';
import 'package:flutter/material.dart';

class NameFieldContainer extends StatelessWidget{
  final TextEditingController controller;
  final bool isNameInvalid;
  final Function infoChanged;

  NameFieldContainer(this.controller, this.isNameInvalid, this.infoChanged);

  @override
  Widget build(BuildContext context) {
    return Container(
                color: Colors.yellowAccent, // * Temporary
                padding: EdgeInsets.all(20),
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        Strings.name + ' :',
                        textAlign: TextAlign.left,
                        style: Theme.of(context).textTheme.title,
                      ),
                    ),
                    TextField(
                      //textAlign: TextAlign.center,
                      maxLength: 50,
                      controller: controller,
                      onChanged: infoChanged,
                      decoration: InputDecoration(
                        hintText: Strings.name,
                        errorText: isNameInvalid
                            ? Strings.name + ' ' + Strings.isInvalid
                            : null,
                      ),
                    ),
                  ],
                ),
              );
  }

}