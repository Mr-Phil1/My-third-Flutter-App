import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
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
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
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
          title: Text(title),
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
                String msg="";
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
