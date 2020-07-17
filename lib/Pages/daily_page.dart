import 'package:Expenseye/Components/Global/add_transac_fab.dart';
import 'package:Expenseye/Components/Drawer/my_drawer.dart';
import 'package:Expenseye/Components/Transac/transac_list_tile.dart';
import 'package:Expenseye/Enums/transac_type.dart';
import 'package:Expenseye/Helpers/google_firebase_helper.dart';
import 'package:Expenseye/Models/Transac.dart';
import 'package:Expenseye/Providers/Global/db_notifier.dart';
import 'package:Expenseye/Providers/Global/settings_notifier.dart';
import 'package:Expenseye/Utils/date_time_util.dart';
import 'package:Expenseye/Utils/transac_util.dart';
import 'package:Expenseye/app_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';

// * Considered the Home Page
class DailyPage extends StatefulWidget {
  final DateTime day = DateTime.now();

  @override
  _DailyPageState createState() => _DailyPageState();
}

class _DailyPageState extends State<DailyPage> with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    loadDailyNotifications();

    return Scaffold(
      drawer: MyDrawer(),
      body: FutureBuilder<List<Transac>>(
        future: Provider.of<DbNotifier>(context).queryTransacsByDay(widget.day),
        builder: (context, snapshot) {
          // TODO: check for init of DbModel in futurebuilder in main
          if (snapshot.hasData && DbNotifier.catMap.length > 0 && DbNotifier.accMap.length > 0) {
            if (snapshot.data != null && snapshot.data.length > 0) {
              return mySliverView(snapshot.data, context);
            } else {
              return mySliverView([], context);
            }
          } else {
            return const Align(
              alignment: Alignment.center,
              child: const CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: AddTransacFab(
        onExpensePressed: () =>
            TransacUtil.showAddTransacDialog(context, widget.day, TransacType.expense),
        onIncomePressed: () =>
            TransacUtil.showAddTransacDialog(context, widget.day, TransacType.income),
      ),
    );
  }

  CustomScrollView mySliverView(
    List<Transac> transacs,
    BuildContext context,
  ) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          expandedHeight: 160,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            title: Text(
              DateTimeUtil.formattedDate(context, widget.day),
              style: Theme.of(context).textTheme.headline1,
            ),
            centerTitle: true,
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return Container(
                margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: TransacListTile(
                  transacs[index],
                  contentPadding: const EdgeInsets.all(15),
                  onPressed: () async => await TransacUtil.openEditTransacPage(
                    context,
                    transacs[index],
                  ),
                ),
              );
            },
            childCount: transacs.length,
          ),
        ),
      ],
    );
  }

  Future<void> loadDailyNotifications() async {
    final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    TimeOfDay settingsTime =
        Provider.of<SettingsNotifier>(context, listen: false).getLocalNotifTime();

    var time = Time(
      settingsTime.hour,
      settingsTime.minute,
    );
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'repeatDailyAtTime channel id',
      'repeatDailyAtTime channel name',
      'repeatDailyAtTime description',
    );
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics =
        NotificationDetails(androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.showDailyAtTime(
      0,
      AppLocalizations.of(context).translate('dontForgetToAddYourTransactions'),
      null,
      time,
      platformChannelSpecifics,
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused) {
      GoogleFirebaseHelper.uploadDbFile();
    }
  }
}
