// ignore_for_file: prefer_const_constructors, sort_child_properties_last, unrelated_type_equality_checks, use_build_context_synchronously, prefer_interpolation_to_compose_strings, library_private_types_in_public_api, prefer_typing_uninitialized_variables, non_constant_identifier_names

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:grayhatproject/chat_screens/friendlist.dart';
import 'package:grayhatproject/providers/auth_provider.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import '../common/colors.dart';
import '../common/theme_helper.dart';

import 'registration_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final double _headerHeight = 200;
  final _formKey = GlobalKey<FormState>();
  bool _obscureText = false;
  String? email;
  String? password;
  final _email = TextEditingController();
  final _password = TextEditingController();

  String redirectUrl = 'https://cognitiveitsolutions.ca/';
  String clientId = '778v2uycvu7iz5';
  String clientSecret = 'D2HFibr1oxqVXnIs';
  var response;
  static bool isGoogle = false;

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProviderCustom>(context);

    switch (authProvider.status) {
      case Status.authenticateError:
        Fluttertoast.showToast(msg: 'Sign in failed');
        break;
      case Status.authenticateCanceled:
        Fluttertoast.showToast(msg: 'Sign in cancelled');
        break;
      case Status.authenticated:
        Fluttertoast.showToast(msg: 'Sign in successful');
        break;
      default:
        break;
    }
    return Scaffold(
      backgroundColor: Mycolors().blue,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              alignment: Alignment(0, 0.5),
              height: _headerHeight,
              child: Text(
                "Welcome",
                style: TextStyle(color: Colors.white, fontSize: 50),
              ),
            ),
            SafeArea(
              child: Container(
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(50.0),
                    topLeft: Radius.circular(50.0),
                  ),
                ),
                padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                // margin: EdgeInsets.fromLTRB(
                //     20, 10, 20, 10), // This will be the login form
                child: Column(
                  children: [
                    Text(
                      'Sign in',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Signin into your account',
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(height: 30.0),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Container(
                            child: TextFormField(
                              controller: _email,
                              decoration: ThemeHelper().textInputDecoration(
                                'Email Address',
                                'Enter your email',
                                Icon(Icons.email_outlined),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
                              onSaved: (val) {
                                email = val;
                              },
                              keyboardType: TextInputType.emailAddress,
                            ),
                            decoration:
                                ThemeHelper().inputBoxDecorationShaddow(),
                          ),
                          SizedBox(height: 30.0),
                          Container(
                            child: TextFormField(
                              controller: _password,
                              obscureText: !_obscureText,
                              decoration: ThemeHelper().textInputDecoration(
                                'Password',
                                'Enter your password',
                                Icon(Icons.lock_outline),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _obscureText = !_obscureText;
                                    });
                                  },
                                  child: Icon(_obscureText
                                      ? Icons.visibility_off
                                      : Icons.visibility),
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter some text';
                                } else if (value.length < 6) {
                                  return 'Password be atleast 6 characters long';
                                }
                                return null;
                              },
                              onSaved: (val) {
                                password = val;
                              },
                            ),
                            decoration:
                                ThemeHelper().inputBoxDecorationShaddow(),
                          ),
                          SizedBox(height: 15.0),
                          Container(
                            margin: EdgeInsets.fromLTRB(10, 0, 10, 20),
                            alignment: Alignment.topRight,
                            child: GestureDetector(
                              onTap: () {
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //       builder: (context) =>
                                //           ForgotPasswordPage()),
                                // );
                              },
                              child: Text(
                                "Forgot your password?",
                                style: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            decoration:
                                ThemeHelper().buttonBoxDecoration(context),
                            child: ElevatedButton(
                              style: ThemeHelper().buttonStyle(Mycolors().blue),
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
                                child: Text(
                                  'Sign In'.toUpperCase(),
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();
                                  // CustomProgressDialogue.progressDialogue(
                                  //     context);
                                  bool isSuccess =
                                      await authProvider.handleCredentials(
                                          email: _email.text,
                                          password: _password.text);
                                  if (isSuccess) {
                                    // Navigator.of(context, rootNavigator: true)
                                    //     .pop('dialog');
                                    isGoogle = false;
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const FriendList()));
                                  }
                                }
                              },
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(10, 20, 10, 20),
                            //child: Text('Don\'t have an account? Create'),
                            child: Text.rich(TextSpan(children: [
                              TextSpan(text: "Don't have an account? "),
                              TextSpan(
                                text: 'Create',
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                RegistrationPage()));
                                  },
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue.shade700,
                                  // Theme.of(context)
                                  //     .colorScheme
                                  //     .secondary
                                ),
                              ),
                            ])),
                          ),
                          SizedBox(height: 20.0),
                          Text(
                            "Or create account using social media",
                            style: TextStyle(color: Colors.grey),
                          ),
                          SizedBox(height: 25.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () async {
                                  bool isSuccess =
                                      await authProvider.handleGoogleSignIn();
                                  if (isSuccess) {
                                    isGoogle = true;
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const FriendList()));
                                  }
                                },
                                icon: FaIcon(
                                  FontAwesomeIcons.googlePlus,
                                  size: 35,
                                  color: HexColor("#EC2D2F"),
                                ),
                              ),
                              SizedBox(
                                width: 30.0,
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: FaIcon(
                                  FontAwesomeIcons.facebook,
                                  size: 35,
                                  color: HexColor("#3E529C"),
                                ),
                              ),
                              SizedBox(
                                width: 30.0,
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: FaIcon(
                                  FontAwesomeIcons.linkedin,
                                  size: 28,
                                  color: HexColor("#0072b1"),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
