import 'package:Expenseye/Components/Global/my_drawer.dart';
import 'package:Expenseye/Resources/Strings.dart';
import 'package:flutter/material.dart';

class DailyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 150,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                child: Container(
                  child: Text('adsa', style: TextStyle(fontSize: 50)),
                  padding: EdgeInsets.only(top: 100),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              <Widget>[
                Text('allo', style: TextStyle(fontSize: 100)),
                Text('allo', style: TextStyle(fontSize: 100)),
                Text('allo', style: TextStyle(fontSize: 100)),
                Text('allo', style: TextStyle(fontSize: 100)),
                Text('allo', style: TextStyle(fontSize: 100)),
                Text('allo', style: TextStyle(fontSize: 100)),
                Text('allo', style: TextStyle(fontSize: 100)),
                Text('allo', style: TextStyle(fontSize: 100)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
