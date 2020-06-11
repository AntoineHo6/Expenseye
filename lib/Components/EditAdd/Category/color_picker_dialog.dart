import 'package:Expenseye/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class ColorPickerDialog extends StatelessWidget {
  final Color initialColor;

  ColorPickerDialog(this.initialColor);

  @override
  Widget build(BuildContext context) {
    Color currentColor = initialColor;

    return AlertDialog(
      title: Text(AppLocalizations.of(context).translate('pickAColor')),
      content: ColorPicker(
        pickerColor: currentColor,
        showLabel: false,
        enableAlpha: true,
        onColorChanged: (newColor) => currentColor = newColor,
        pickerAreaHeightPercent: 0.8,
      ),
      actions: <Widget>[
        FlatButton(
          textColor: Colors.white,
          child: Text(AppLocalizations.of(context).translate('cancelCaps')),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        FlatButton(
          textColor: Colors.white,
          child: Text(AppLocalizations.of(context).translate('confirmCaps')),
          onPressed: () {
            Navigator.pop(context, currentColor);
          },
        ),
      ],
    );
  }

}
