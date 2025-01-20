import 'dart:typed_data';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:my_awesome_namer/models/user_model.dart';
import 'package:my_awesome_namer/models/response_model.dart';
import 'package:my_awesome_namer/service/api_service.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class Test extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff1D1E22),
        centerTitle: true,
        title: const Text('Retrofit test'),
      ),
      body: InkWell(
        onTap: _emailTest,
        child: Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.black,
          ),
          child: Center(
            child: Text(
              'Test API',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _testAPIGet() async {
    final logger = Logger();
    final dio = Dio();
    dio.options.headers['Demo-testovani'] = 'Demo testing';
    final client = RestClient(dio);

    final response = await client.getUsers();

    logger.i(response.detail[0].nickname);
  }

  // bytes ==> base64 vzdy
  // vzdy zkontrolovat zda konvertace modelu do JSNU je spravna, jinak se odesle s
  //jinym klicem a jinou hodnotu, neprojde validaci pres Pydantic schema
  void _testAPIPost() async {
    // Sample data
    final logger = Logger();

    final dio = Dio();
    dio.options.headers['Demo-testovani'] = 'Demo testing';
    final client = RestClient(dio);

    userAddSchema user = userAddSchema(
        useruid: 'dartTest',
        firstname: 'dartTest',
        lastactive: DateTime.now(),
        nickname: 'dartTest',
        email: 'dartTest@gmail.com',
        profileicon: Uint8List.fromList([0, 1, 2, 3]),
        telephonenumber: '704167980',
        telephoneprefix: '123',
        birthday: DateTime.now(),
        lastname: 'Eder');

    print(user.toJson());

    client.createUser(user.toJson());
  }

  void _emailTest() async {
    final dio = Dio();

    final client = RestClient(dio);

    boolResponse bool = await client.doesEmailExists("dawdawdaw@example.com");

    print(bool.detail);
  }
}
