import 'package:Expenseye/Components/Drawer/my_drawer.dart';
import 'package:Expenseye/Components/Stats/category_stats_container.dart';
import 'package:Expenseye/Components/Stats/pie_outside_label_chart.dart';
import 'package:Expenseye/Enums/transac_type.dart';
import 'package:Expenseye/Models/Transac.dart';
import 'package:Expenseye/Providers/stats_notifier.dart';
import 'package:Expenseye/Utils/chart_util.dart';
import 'package:Expenseye/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

typedef GetTransacs = Future<List<Transac>> Function();

class StatsPage extends StatelessWidget {
  final GetTransacs future;

  StatsPage({
    @required this.future,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => StatsNotifier(),
      child: Consumer<StatsNotifier>(
        builder: (context, model, child) => Scaffold(
          drawer: MyDrawer(),
          body: FutureBuilder<List<Transac>>(
            future: future(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data != null && snapshot.data.length > 0) {
                  var aggregatedTransacs =
                      ChartUtil.convertTransacsToChartSeries(
                    snapshot.data,
                    model.type,
                  );

                  model.data = List.from(aggregatedTransacs[0].data);
                  model.sortCategoryGroups();

                  return SingleChildScrollView(
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      child: Column(
                        children: <Widget>[
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            model.type == TransacType.expense
                                ? AppLocalizations.of(context)
                                    .translate('expenses')
                                : AppLocalizations.of(context)
                                    .translate('incomes'),
                            style: Theme.of(context).textTheme.headline5,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          SizedBox(
                            height: 200.0,
                            child: PieOutsideLabelChart(
                              aggregatedTransacs,
                              animate: false,
                            ),
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: RaisedButton(
                              onPressed: model.switchChartType,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Icon(Icons.swap_horiz),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    model.type == TransacType.expense
                                        ? AppLocalizations.of(context)
                                            .translate('switchToIncomes')
                                        : AppLocalizations.of(context)
                                            .translate('switchToExpenses'),
                                    style: TextStyle(fontSize: 11),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          CategoryStatsContainer(
                            data: model.data,
                            totalCost: _calcTypeTotal(model.data),
                            changeCurrentSort: model.changeCurrentSort,
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  return Align(
                    alignment: Alignment.center,
                    child:
                        Text(AppLocalizations.of(context).translate('noData')),
                  );
                }
              } else {
                return Align(
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  double _calcTypeTotal(List<CategoryGroup> categoryGroups) {
    double total = 0;

    for (var categoryGroup in categoryGroups) {
      total += (categoryGroup.total);
    }

    return total;
  }
}
