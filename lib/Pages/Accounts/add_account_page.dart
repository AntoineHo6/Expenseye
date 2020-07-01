import 'package:Expenseye/Components/Global/bottom_nav_button.dart';
import 'package:Expenseye/Providers/Accounts/add_account_notifier.dart';
import 'package:Expenseye/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddAccountPage extends StatefulWidget {
  @override
  _AddAccountPageState createState() => _AddAccountPageState();
}

class _AddAccountPageState extends State<AddAccountPage> {
  final _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AddAccountNotifier(),
      child: Consumer<AddAccountNotifier>(
        builder: (context, model, child) => Scaffold(
          appBar: AppBar(
            title: Text('temporary'), // TODO: add legit title
          ),
          bottomNavigationBar: BottomAppBar(
            color: Colors.transparent,
            child: BottomNavButton(
              text: AppLocalizations.of(context).translate('addCaps'),
              onPressed: () => null,
            ),
          ),
          body: Text('allo'),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }
}
