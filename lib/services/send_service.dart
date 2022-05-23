import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:api_send_data/models/user_model.dart';

Future<UserModel> createUser({required UserModel userData}) async {
  final http.Response response = await http.post(
      Uri.parse('https://reqres.in/api/users'),
      body: userData.toPostUserData());
  if (response.statusCode == 201) {
    return UserModel.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('error');
  }
}
