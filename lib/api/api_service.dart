import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/login_model.dart';

class APIService {
  Future<LoginResponseModel> login(
      LoginRequestModel requestModel, BuildContext context) async {
    String email = requestModel.email;
    String password = requestModel.password;
    Uri baseUrl = Uri.parse('http://localhost:8080/data/$email/$password');

    try {
      final http.Response response = await http.get(baseUrl);
      if (response != null) {
        print('----------- ${response.body} -----------');
        showSnackBar(
          response.body,
          Colors.teal,
          context,
        );
      } else {
        showSnackBar(
          "Oops, Credentials not found! Try again",
          Colors.red,
          context,
        );
      }
    } catch (e) {
      print('${e.toString()} *****************');
      showSnackBar(
        "Something went wrong!",
        Colors.red,
        context,
      );
    }
    // Uri url = Uri.parse("http://localhost:8083/validate/");
    // print("1-----");
    // try {
    //   final response = await http.get(url);
    //   print("2-----");
    //   if (response.statusCode == 200 || response.statusCode == 400) {
    //     print("3-----");
    //     return LoginResponseModel.fromJson(
    //       json.decode(response.body),
    //     );
    //   } else {
    //     print("4-----");
    //     throw Exception('Failed to load data!');
    //   }
    // } catch (e) {
    //   print(
    //       '${e.toString()} ------------ api_service.dart/login()/line range: 0 - 100');
    // }
  }

  void showSnackBar(
    String content,
    Color color,
    BuildContext context,
  ) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        width: MediaQuery.of(context).size.width / 2,
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        content: Text(
          content,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
