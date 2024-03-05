import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static const String _title = 'Flutter Stateful Clicker Counter';
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // useMaterial3: true,
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.
  // This class is the configuration for the state.
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

final _formKey = GlobalKey<FormState>();
final TextEditingController _firstName = TextEditingController();
final TextEditingController _lastName = TextEditingController();
bool _isCheckedHiking = false;
bool _isCheckedCooking = false;
bool _isCheckedTraveling = false;
bool switchValue = false;

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _firstName,
              decoration: const InputDecoration(labelText: 'First Name'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "please enter your first name";
                }
                return null;
              },
            ),
            TextFormField(
              controller: _lastName,
              decoration: const InputDecoration(labelText: 'Last Name'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "please enter your last name";
                }
              },
            ),
            const SizedBox(
              height: 25,
            ),
            Container(
              child: const Text("Interest"),
            ),
            CheckboxListTile(
              value: _isCheckedHiking,
              title: const Text("Hiking"),
              onChanged: (value) {
                setState(() {
                  _isCheckedHiking = value!;
                });
              },
            ),
            CheckboxListTile(
              value: _isCheckedCooking,
              title: const Text("Cooking"),
              onChanged: (value) {
                setState(() {
                  _isCheckedCooking = value!;
                });
              },
            ),
            CheckboxListTile(
              value: _isCheckedTraveling,
              title: const Text("Traveling"),
              onChanged: (value) {
                setState(() {
                  _isCheckedTraveling = value!;
                });
              },
            ),
            const SizedBox(
              height: 25,
            ),
            SwitchListTile(
              value: switchValue,
              title: const Text("Montly Newsletter"),
              secondary: const Icon(Icons.notifications_active),
              onChanged: (value) {
                setState(() {
                  switchValue = value;
                });
              },
            ),
            const SizedBox(
              height: 25,
            ),
            ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Processing Data')),
                    );
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SecondRoute(
                                firstName: _firstName.text,
                                lastName: _lastName.text,
                                isCheckedHiking: _isCheckedHiking,
                                isCheckedCooking: _isCheckedCooking,
                                isCheckedTraveling: _isCheckedTraveling,
                              )),
                    );
                  }
                },
                child: const Text("Save")),
          ],
        ),
      ),
    );
  }
}

class SecondRoute extends StatelessWidget {
  String firstName;
  String lastName;
  bool? isCheckedHiking;
  bool? isCheckedCooking;
  bool? isCheckedTraveling;

  SecondRoute(
      {super.key,
      required this.firstName,
      required this.lastName,
      required this.isCheckedHiking,
      required this.isCheckedCooking,
      required this.isCheckedTraveling});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Route'),
      ),
      body: Center(
        child: Column(
          children: [
            Text("FIRST NAME : $firstName"),
            Text("LAST NAME : $lastName"),
            const Text("Interests: "),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(isCheckedHiking == true ? " Hiking" : ""),
                Text(isCheckedCooking == true ? " Cooking" : ""),
                Text(isCheckedTraveling == true ? " Traveling" : ""),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Go back!'),
            ),
          ],
        ),
      ),
    );
  }
}
