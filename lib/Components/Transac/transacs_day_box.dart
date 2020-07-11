import 'package:Expenseye/Components/Transac/transac_list_tile.dart';
import 'package:Expenseye/Models/Transac.dart';
import 'package:Expenseye/Pages/EditAddTransac/edit_transac_page.dart';
import 'package:Expenseye/Resources/Themes/app_colors.dart';
import 'package:Expenseye/Utils/date_time_util.dart';
import 'package:Expenseye/Utils/transac_util.dart';
import 'package:Expenseye/app_localizations.dart';
import 'package:flutter/material.dart';

class TransacsDayBox extends StatelessWidget {
  final List<Transac> transacs;

  TransacsDayBox(this.transacs);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: Column(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(left: 10, right: 32),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  DateTimeUtil.formattedDate(context, transacs[0].date),
                  style: Theme.of(context).textTheme.headline5,
                ),
                Text(
                  '${TransacUtil.calcTransacsTotal(transacs).toStringAsFixed(2)} \$',
                  style: TextStyle(
                    color: ColorChooserFromTheme.balanceColor,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Column(
            children: transacs
                .map(
                  (transac) => Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: TransacListTile(
                      transac,
                      onPressed: () async => await _openEditTransac(
                        context,
                        transac,
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }

  // * Make sure parent widget is listening to DbModel so changes refresh the page
  Future<void> _openEditTransac(BuildContext context, Transac transac) async {
    int action = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditTransacPage(transac)),
    );

    if (action != null) {
      final snackBar = SnackBar(
        content: action == 1
            ? Text(AppLocalizations.of(context).translate('succEdited'))
            : Text(AppLocalizations.of(context).translate('succDeleted')),
        backgroundColor: Colors.grey.withOpacity(0.5),
      );

      Scaffold.of(context).showSnackBar(snackBar);
    }
  }
}
