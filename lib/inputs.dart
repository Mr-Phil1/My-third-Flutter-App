import 'package:flutter/material.dart';

class InputDemo extends StatelessWidget {
  const InputDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Inputs"),
      ),
      body: MyInputDemo(),
    );
  }
}

class MyInputDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyInputDemoState();
}

class MyInputDemoState extends State<MyInputDemo> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Scrollbar(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    icon: const Icon(Icons.email),
                    hintText: 'Deine E-Mail-Adresse',
                    labelText: ' E-Mail-Adresse',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
