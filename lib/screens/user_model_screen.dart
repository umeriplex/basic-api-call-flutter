import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/UserModel.dart';

class UserModelScreen extends StatefulWidget {
  const UserModelScreen({Key? key}) : super(key: key);

  @override
  State<UserModelScreen> createState() => _UserModelScreenState();
}

class _UserModelScreenState extends State<UserModelScreen> {
  List<UserModel> userList = [];

  Future<List<UserModel>> getUsers() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      for (Map i in data) {
        userList.add(UserModel.fromJson(i));
      }
      return userList;
    } else {
      return userList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('API Flutter'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
              child: FutureBuilder(
            future: getUsers(),
            builder: (context, AsyncSnapshot<List<UserModel>> snapshot) {
              if (!snapshot.hasData) {
                return const CircularProgressIndicator();
              } else {
                return ListView.builder(
                    itemCount: userList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 14.0,vertical: 4),
                        child: Card(
                          child: Column(
                            children: [
                              RowItem(
                                  name: 'Name',
                                  username: snapshot.data![index].name.toString()),
                              RowItem(
                                  name: 'User Name',
                                  username: snapshot.data![index].username.toString()),
                              RowItem(
                                  name: 'Address',
                                  username: snapshot.data![index].address!.street.toString()),
                              RowItem(
                                  name: 'Long',
                                  username: snapshot.data![index].address!.geo!.lng.toString()),
                              RowItem(
                                  name: 'Lat',
                                  username: snapshot.data![index].address!.geo!.lat.toString()),
                              RowItem(
                                  name: 'Company',
                                  username: snapshot.data![index].company!.name.toString()),
                            ],
                          ),
                        ),
                      );
                    });
              }
            },
          ))
        ],
      ),
    );
  }
}

class RowItem extends StatelessWidget {
  String name, username;

  RowItem({Key? key, required this.name, required this.username})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 14),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(name),
              Text(username),
            ],
          ),
          const SizedBox(height: 6,),
          Divider(
            height: 1,
            thickness: 1,
          ),
        ],
      ),
    );
  }
}
