import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'Model.dart';


class RegisterPage extends StatefulWidget {
  RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  static const uri = "http://10.0.2.2:5000/user/register";
  User currentUser = null as User;
  static const formPadding = 20.0;
  static const fontSize = 20.0;
  var usernameError;
  var emailError;
  var passwordError;
  var confirmPasswordError;
  static BorderRadius buttonRadius = BorderRadius.circular(10);
  TextEditingController username = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();
  TextEditingController confirmPassword = new TextEditingController();

  @override
  Widget build(BuildContext context) {

    var screenSize = [
      MediaQuery.of(context).size.width,
      MediaQuery.of(context).size.height
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
            "Article - Register"
        ),
      ),
      body: SingleChildScrollView(

        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: MediaQuery.of(context).size.width,
            minHeight: MediaQuery.of(context).size.height,
          ),
          child: IntrinsicHeight(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Flexible(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(0, 20, 0, formPadding),
                      child: Text(
                        "Register Here",
                        style: TextStyle(
                          fontSize: fontSize,
                        ),
                      ),
                    )
                ),
                Flexible(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, formPadding),
                      child: Container(
                        width: screenSize[0] * 0.6,
                        child: TextField(
                          controller: username,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.person),
                            labelText: "Username",
                            errorText: usernameError,
                            alignLabelWithHint: false,
                          ),
                        ),
                      ),
                    )
                ),
                Flexible(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, formPadding),
                      child: Container(
                        width: screenSize[0] * 0.6,
                        child: TextField(
                          controller: email,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.email),
                              labelText: "Email",
                              errorText: emailError,
                              hintText: "someone@gmail.com"
                          ),
                        ),
                      ),
                    )
                ),
                Flexible(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, formPadding),
                      child: Container(
                        width: screenSize[0] * 0.6,
                        child: TextField(
                          controller: password,
                          obscureText: true,
                          enableSuggestions: false,
                          autocorrect: false,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.security),
                            errorText: passwordError,
                            labelText: "Password",
                          ),
                        ),
                      ),
                    )
                ),
                Flexible(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, formPadding),
                      child: Container(
                        width: screenSize[0] * 0.6,
                        child: TextField(
                          controller: confirmPassword,
                          obscureText: true,
                          enableSuggestions: false,
                          autocorrect: false,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.security),
                            errorText: confirmPasswordError,
                            labelText: "Confirm Password",
                          ),
                        ),
                      ),
                    )
                ),
                Flexible(
                    child: InkWell(
                      borderRadius: buttonRadius,
                      onTap: (){
                        setState(() {
                          validateOnSubmit(username, email, password, confirmPassword);
                        });
                      },
                      child: Ink(
                          width: 100,
                          height: 35,
                          decoration: BoxDecoration(
                            borderRadius: buttonRadius,
                            color: Colors.grey,
                          ),
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              "Register",
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          )
                      ),
                    )
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void validateOnSubmit(TextEditingController username, TextEditingController email, TextEditingController password, TextEditingController confirmPassword) {
    var error = [];
    // check mail
    if(!email.text.contains('@')){
      error.add("Invalid mail format");
      emailError = "Invalid mail format";
    }
    // check confirm password
    if(password.text != confirmPassword.text){
      error.add("Must equal to Password");
      confirmPasswordError = "Must equal to Password";
    }
    if (error.length == 0){
      emailError = null;
      confirmPasswordError = null;
      registerData(username.text, email.text, password.text);
    }
  }

  Future<void> registerData(String username, String email, String password) async {
    var url = Uri.parse(uri);
    var response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
        "username": username,
        "email": email,
        "password": password
        })
        );
    if (response.statusCode == 200) {
      Map<String, dynamic> dataResponse = json.decode(response.body);
      if(dataResponse["error"] == null){
        User currentUser = User.fromJson(json.decode(response.body));
        print(currentUser.email);
      }
      else{
        print(dataResponse["error"]);
      }
    }
  }
}