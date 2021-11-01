import 'package:flutter/material.dart';

import './Tabbar.dart';
import './inputs.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: InputDemo()
        //TabBarDemo() // DrawerExample(
        // restorationId: '0',
        //  ), // MyHomePage(title: 'Flutter Demo Home Page'),
        );
  }
}

class DrawerExample extends StatefulWidget {
  const DrawerExample({Key? key, required this.restorationId})
      : super(key: key);
  final String restorationId;

  @override
  State<StatefulWidget> createState() => _DrawerExampleState();
}

class _DrawerExampleState extends State<DrawerExample> with RestorationMixin {
  final RestorableInt _currentIndex = RestorableInt(0);

  @override
  Widget build(BuildContext context) {
    final drawerElements = ListView(
      children: [
        UserAccountsDrawerHeader(
          accountName: Text("Mr. Phil"),
          accountEmail: Text("Danke fürs Zusehen :)"),
          currentAccountPicture: const CircularProgressIndicator(
            backgroundColor: Colors.black,
          ),
        ),
        ListTile(
          title: Text("Dashboard"),
          onTap: () {
            print("Tapped");
          },
        ),
        Divider(),
        ListTile(
          title: Text("Impressum"),
        ),
      ],
    );
    var bottomNavBarItems = const [
      BottomNavigationBarItem(icon: Icon(Icons.account_box), label: 'Account'),
      BottomNavigationBarItem(icon: Icon(Icons.access_alarm), label: 'Alarm'),
      BottomNavigationBarItem(icon: Icon(Icons.last_page), label: 'Last Page'),
    ];
    return Scaffold(
        appBar: AppBar(
          title: Text("Nav Bar Example"),
          actions: [
            PopupMenuButton(
                padding: EdgeInsets.zero,
                onSelected: (value) => print(value),
                itemBuilder: (context) => <PopupMenuEntry<String>>[
                      const PopupMenuItem<String>(
                          value: "Teilen",
                          child: ListTile(
                            leading: Icon(Icons.share),
                            title: Text("Teilen"),
                          )),
                      const PopupMenuDivider(),
                      const PopupMenuItem(
                          value: "Logout",
                          child: ListTile(
                            leading: Icon(Icons.logout),
                            title: Text("Logout"),
                          )),
                    ])
          ],
        ),
        body: Center(
          child: InkWell(
            onTap: () {
              print("Inkwell");
            },
            child: Center(
                child: _MyBottomNavView(
                    key: UniqueKey(),
                    item: bottomNavBarItems[_currentIndex.value])),
          ),
        ),
        drawer: Drawer(
          child: drawerElements,
        ),
        bottomNavigationBar: BottomNavigationBar(
          showUnselectedLabels: false,
          items: bottomNavBarItems,
          currentIndex: _currentIndex.value,
          onTap: (index) {
            setState(() {
              _currentIndex.value = index;
            });
          },
        ));
  }

  @override
  String? get restorationId => widget.restorationId;

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_currentIndex, 'bottom_navigation_tab_index');
  }
}

class _MyBottomNavView extends StatelessWidget {
  _MyBottomNavView({Key? key, required this.item}) : super(key: key);

  final BottomNavigationBarItem item;
  @override
  Widget build(BuildContext context) {
    return Text(item.label as String);
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final items = List<String>.generate(20, (i) => "Eintrag ${i + 1}");

  @override
  Widget build(BuildContext context) {
    const title = 'Delete Me';
    return MaterialApp(
      title: title,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Scaffold(
        appBar: AppBar(
          title: const Text(title),
        ),
        body: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return Dismissible(
              key: Key(item),
              child: ListTile(title: Text('$item')),
              background: Container(
                color: Colors.red,
                child: const Icon(Icons.delete),
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 30),
              ),
              secondaryBackground: Container(
                color: Colors.green,
                child: const Icon(Icons.save),
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(right: 30),
              ),
              onDismissed: (direction) {
                setState(() {
                  items.removeAt(index);
                });
                String msg = "";
                if (direction == DismissDirection.startToEnd) {
                  msg = "deleted";
                } else if (direction == DismissDirection.endToStart) {
                  msg = "saved";
                }
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("$item $msg."),
                ));
              },
            );
          },
        ),
      ),
    );
  }
}
