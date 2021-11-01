// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_app/main.dart';

class TabBarDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => TabBarDemoState();
}

class TabBarDemoState extends State<TabBarDemo> {
  @override
  Widget build(BuildContext context) {
    final tabs = [
      "Alle",
      "Freunde",
      "Familie",
      "Arbeit",
    ];
    final list = List<String>.generate(1337, (index) => "$index");

    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text("My Ultimate Chat"),
          bottom: TabBar(
            isScrollable: true,
            tabs: [
              for (final t in tabs)
                Tab(
                  text: t,
                )
            ],
          ),
        ),
        body: TabBarView(
          children: [
            for (final t in tabs)
              Center(child: ListView.builder(itemBuilder: (context, i) {
                return ListTile(
                  title: Text("$t - ${list[i]}"),
                );
              })),
          ],
        ),
        bottomNavigationBar: _MyAppBar(),
        floatingActionButton: FloatingActionButton(
          onPressed: _handleSubmitButton,
          child: Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }

  void _handleSubmitButton() {
    Navigator.of(context).push(_createRoute());
  }
}

Route<Object?> _createRoute() {
  return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => DrawerExample(
            restorationId: '0',
          ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        Animatable<Offset> animatible =
            Tween(begin: Offset(0.0, 1.0), end: Offset.zero)
                .chain(CurveTween(curve: Curves.ease));
        return SlideTransition(
          position: animation.drive(animatible),
          child: child,
        );
      });
}

class _MyAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Theme.of(context).colorScheme.secondary,
      shape: const CircularNotchedRectangle(),
      child: IconTheme(
        data: IconThemeData(
          color: Theme.of(context).colorScheme.onPrimary,
        ),
        child: Row(
          children: [
            IconButton(
                tooltip: "Menü öffnen",
                icon: const Icon(Icons.menu),
                onPressed: () => print("Open Menu Here")),
            Spacer(),
            IconButton(
                tooltip: "Suche",
                icon: const Icon(Icons.search),
                onPressed: () => print("Open Search Here")),
          ],
        ),
      ),
    );
  }
}
