import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:Orgit/API/groupAPI.dart';
import 'package:Orgit/models/groupDTO.dart';


class TestingPage extends StatefulWidget{
  @override
  State<TestingPage> createState() => _TestingPageState();
}

class _TestingPageState extends State<TestingPage> {
  // late Future<List<UserResponse>> users;
  // late Future<List<GroupResponse>> groups;
  @override
  void initState(){
    super.initState();
    // users = fetchUsers();
    // groups = fetchGroups();
  }


  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Testing Page'),
      ),
      body: Text('TESTING backend'),
    );
  }
}