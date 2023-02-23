import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../main.dart';
import '../modal/user.dart';
import '../services/sign_in.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final LoginController _loginController = LoginController();
  bool _isLoading = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _signIn() async {
    setState(() {
      _isLoading = true;
    });
    final user =
        User(email: _emailController.text, password: _passwordController.text);
    final token = await _loginController.signIn(user, 'text');

    if (token != null) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const MainPage()),
        (Route<dynamic> route) => false,
      );
    } else {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid email or password')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.transparent,
    ));
    return Scaffold(
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 50.0),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 30.0),
                  child: Image.network(
                      'https://blogger.googleusercontent.com/img/a/AVvXsEhdOsFuVngageLIphCbJ2cXqgdfhifZMKj3l01OlrtPkN2g-UMW0yOEnWGr_p8bVZ7iMAqIFpmQ3zLH3XxyGq4_LxUFVsvaznnw4fBqP81B6MnmV2BFU0HK-ypuHxvGkrFdGjprTyW22c6ApXwg9ByNFdVjMyh9PHYSpf7SL27xS4K52br8R4LhV2h2rA=s1600'),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 20.0),
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        controller: _emailController,
                        cursorColor: Colors.black,
                        style: const TextStyle(color: Colors.black54),
                        decoration: const InputDecoration(
                          icon: Icon(Icons.email, color: Colors.black54),
                          hintText: "Email",
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black54),
                          ),
                          hintStyle: TextStyle(color: Colors.black54),
                        ),
                      ),
                      const SizedBox(height: 30.0),
                      TextFormField(
                        controller: _passwordController,
                        cursorColor: Colors.black,
                        obscureText: true,
                        style: const TextStyle(color: Colors.black54),
                        decoration: const InputDecoration(
                          icon: Icon(Icons.lock, color: Colors.black54),
                          hintText: "Password",
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black54),
                          ),
                          hintStyle: TextStyle(color: Colors.black54),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 40.0,
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  margin: const EdgeInsets.only(top: 15.0),
                  child: ElevatedButton(
                    onPressed: _emailController.text == '' ||
                            _passwordController.text == ''
                        ? null
                        : _signIn,
                    child: const Text(
                      'Sign In',
                      style: TextStyle(color: Colors.black54),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
