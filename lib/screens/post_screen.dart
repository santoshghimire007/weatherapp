import 'package:api_send_data/models/user_model.dart';
import 'package:api_send_data/services/send_service.dart';
import 'package:flutter/material.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  State<PostScreen> createState() => _MyAppState();
}

class _MyAppState extends State<PostScreen> {
  UserModel? _user;

  TextEditingController nameController = TextEditingController();
  TextEditingController jobController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('POST API'),
      ),
      body: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  hintText: 'Enter Name',
                ),
              ),
              TextField(
                controller: jobController,
                decoration: const InputDecoration(hintText: 'Enter Job'),
              ),
              const SizedBox(
                height: 15,
              ),
              ElevatedButton(
                onPressed: () async {
                  UserModel userData = UserModel(
                      name: nameController.text, job: jobController.text);
                  final UserModel user = await createUser(userData: userData);
                  setState(() {
                    _user = user;
                  });
                },
                child: const Text('POST'),
              ),
              const SizedBox(height: 10),
              if (_user != null) Card(child: Text(_user!.name))
            ],
          )),
    );
  }
}
