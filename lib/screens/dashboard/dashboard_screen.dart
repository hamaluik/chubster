import 'package:chubster/components/navbar.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Dashboard"),
        ),
        bottomNavigationBar: NavBar(
          screen: Screen.dashboard,
        ));
  }
}
