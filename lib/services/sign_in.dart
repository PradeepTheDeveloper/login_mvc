import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../modal/user.dart';

class LoginController {
  Future<String?> signIn(User user, String text) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map data = {'email': user.email, 'password': user.password};
    var jsonResponse = null;
    var response =
        await http.post(Uri.parse('https://reqres.in/api/login'), body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      if (jsonResponse != null) {
        sharedPreferences.setString("token", jsonResponse['token']);
        return jsonResponse['token'];
      }
    } else {
      print(response.body);
      return null;
    }
    return null;
  }
}
