import 'package:Expenseye/Components/Global/add_item_fab.dart';
import 'package:Expenseye/Components/Drawer/my_drawer.dart';
import 'package:Expenseye/Components/Items/item_list_tile.dart';
import 'package:Expenseye/Helpers/google_firebase_helper.dart';
import 'package:Expenseye/Models/Item.dart';
import 'package:Expenseye/Providers/Global/db_model.dart';
import 'package:Expenseye/Providers/Global/item_model.dart';
import 'package:Expenseye/Providers/Global/settings_notifier.dart';
import 'package:Expenseye/Utils/date_time_util.dart';
import 'package:Expenseye/app_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// * Considered the Home Page
class DailyPage extends StatefulWidget {
  final DateTime day = DateTime.now();

  @override
  _DailyPageState createState() => _DailyPageState();
}

class _DailyPageState extends State<DailyPage> with WidgetsBindingObserver {
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

  @override
  Widget build(BuildContext context) {
    // * initialize local notifications
    final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    initLocalNotifications(flutterLocalNotificationsPlugin);
    loadDailyNotifications(flutterLocalNotificationsPlugin);

    final _itemModel = Provider.of<ItemModel>(context);
    final _dbModel = Provider.of<DbModel>(context);

    return Scaffold(
      drawer: MyDrawer(),
      body: FutureBuilder<List<Item>>(
        future: _dbModel.queryItemsByDay(widget.day),
        builder: (context, snapshot) {
          if (snapshot.hasData && DbModel.catMap.length > 0) {
            if (snapshot.data != null && snapshot.data.length > 0) {
              return mySliverView(snapshot.data, _itemModel, context);
            } else {
              return mySliverView([], _itemModel, context);
            }
          } else {
            return const Align(
              alignment: Alignment.center,
              child: const CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: AddExpenseFab(
        onExpensePressed: () => _itemModel.showAddExpense(context, widget.day),
        onIncomePressed: () => _itemModel.showAddIncome(context, widget.day),
      ),
    );
  }

  CustomScrollView mySliverView(
      List<Item> items, ItemModel itemModel, BuildContext context) {
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
                margin: EdgeInsets.fromLTRB(10, 20, 10, 0),
                child: ItemListTile(
                  items[index],
                  contentPadding: const EdgeInsets.all(15),
                  onPressed: () async =>
                      await itemModel.openEditItem(context, items[index]),
                ),
              );
            },
            childCount: items.length,
          ),
        ),
      ],
    );
  }

  // * Notification's functions
  Future<void> initLocalNotifications(
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
  ) async {
    var initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');
    var initializationSettingsIOS = IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    var initializationSettings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: selectNotification);
  }

  Future<void> loadDailyNotifications(
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
  ) async {
    TimeOfDay settingsTime =
        Provider.of<SettingsNotifier>(context, listen: false)
            .getLocalNotifTime();

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
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.showDailyAtTime(
      0,
      AppLocalizations.of(context).translate('dontForgetToAddYourTransactions'),
      null,
      time,
      platformChannelSpecifics,
    );
  }

  Future onDidReceiveLocalNotification(
    int id,
    String title,
    String body,
    String payload,
  ) async {
    // display a dialog with the notification details, tap ok to go to another page
    showDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(body),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            child: Text('Ok'),
            onPressed: () async {
              Navigator.of(context, rootNavigator: true).pop();
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DailyPage(),
                ),
              );
            },
          )
        ],
      ),
    );
  }

  Future selectNotification(String payload) async {
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
    }
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DailyPage()),
    );
  }
}
