import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

  EmailData email = EmailData();

  AutovalidateMode _autoValidate = AutovalidateMode.disabled;

  String? _validateEmail(String? value) {
    final emailExp = RegExp(r'^[A-Za-z0-9.-]+@[A-Za-z0-9.-]+\.[a-zA-Z]+$');
    if (value!.isEmpty) {
      return "Email ist verpflichtend";
    }
    if (!emailExp.hasMatch(value)) {
      return "Ungültige Email";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        autovalidateMode: _autoValidate,
        key: _formKey,
        child: Scrollbar(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    icon: Icon(Icons.email),
                    hintText: 'Deine E-Mail-Adresse',
                    labelText: ' E-Mail-Adresse',
                  ),
                  onSaved: (value) => email.email = value!,
                  validator: (value) => _validateEmail(value),
                  keyboardType: TextInputType.emailAddress,
                  maxLength: 100,
                  maxLengthEnforcement: MaxLengthEnforcement.enforced,
                ),
                Center(
                  child: ElevatedButton(
                    child: Text("Sendem"),
                    onPressed: _handleSubmitButton,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleSubmitButton() {
    final form = _formKey.currentState;
    if (!form!.validate()) {
      _autoValidate = AutovalidateMode.always;
    } else {
      form.save();
      print(email.email);
    }
  }
}

class EmailData {
  String email = "";
}
