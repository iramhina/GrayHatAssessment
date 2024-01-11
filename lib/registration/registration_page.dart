// ignore_for_file: unnecessary_new, prefer_const_literals_to_create_immutables, sort_child_properties_last, prefer_const_constructors, use_build_context_synchronously, non_constant_identifier_names, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_import

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:grayhatproject/chat_screens/friendlist.dart';
import '../common/colors.dart';
import '../common/theme_helper.dart';
import 'authentication.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _RegistrationPageState();
  }
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  bool checkedValue = false;
  bool checkboxValue = false;
  bool _obscureText = false;
  bool _obscureConfirmPass = false;

  String? email;
  String? password;
  String? confirm_password;
  String? name;
  String? contact;

  final _email = TextEditingController();
  final _name = TextEditingController();
  final _password = TextEditingController();
  final _confirm_password = TextEditingController();
  final _contact = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Mycolors().blue,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 150,
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: 30),
              child: Text(
                "Registration",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Colors.white),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(50.0),
                  topLeft: Radius.circular(50.0),
                ),
              ),
              padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
              alignment: Alignment.center,
              child: Column(
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          child: TextFormField(
                            controller: _name,
                            decoration: ThemeHelper().textInputDecoration(
                              'Your Full Name',
                              'Enter your first name',
                              Icon(Icons.person),
                            ),
                            onChanged: (val) {
                              name = _name.text;
                              debugPrint("Name value: " + name.toString());
                            },
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(height: 20.0),
                        Container(
                          child: TextFormField(
                            controller: _email,
                            decoration: ThemeHelper().textInputDecoration(
                              "E-mail address",
                              "Enter your email",
                              Icon(Icons.email_outlined),
                            ),
                            keyboardType: TextInputType.emailAddress,
                            validator: (val) {
                              if (!(val!.isNotEmpty) &&
                                  !RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
                                      .hasMatch(val)) {
                                return "Enter a valid email address";
                              }
                              return null;
                            },
                            onSaved: (val) {
                              email = val;
                            },
                            onChanged: (val) {
                              email = _email.text;
                              debugPrint("Email value: " + email.toString());
                            },
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(height: 20.0),
                        Container(
                          child: TextFormField(
                            controller: _contact,
                            decoration: ThemeHelper().textInputDecoration(
                                "Mobile Number",
                                "Enter your mobile number",
                                Icon(Icons.mobile_friendly)),
                            keyboardType: TextInputType.phone,
                            validator: (val) {
                              if (!(val!.isNotEmpty) &&
                                  !RegExp(r"^(\d+)*$").hasMatch(val)) {
                                return "Enter a valid phone number";
                              }
                              return null;
                            },
                            onChanged: (val) {
                              contact = _contact.text;
                              debugPrint("Contact: " + contact.toString());
                            },
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(height: 20.0),
                        Container(
                          child: TextFormField(
                            controller: _password,
                            obscureText: !_obscureText,
                            decoration: ThemeHelper().textInputDecoration(
                              "Password*",
                              "Enter your password",
                              Icon(Icons.lock_outline),
                              GestureDetector(
                                onTap: (() {
                                  setState(() {
                                    _obscureText = !_obscureText;
                                  });
                                }),
                                child: Icon(_obscureText
                                    ? Icons.visibility_off
                                    : Icons.visibility),
                              ),
                            ),
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "Please enter your password";
                              }
                              return null;
                            },
                            onSaved: (val) {
                              password = val;
                            },
                            onChanged: (val) {
                              password = _password.text;
                              debugPrint("Password: " + password.toString());
                            },
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(height: 20.0),
                        Container(
                          child: TextFormField(
                            controller: _confirm_password,
                            obscureText: !_obscureConfirmPass,
                            decoration: ThemeHelper().textInputDecoration(
                              "Confirm Password*",
                              "confirm your password",
                              Icon(Icons.lock_outline),
                              GestureDetector(
                                onTap: (() {
                                  setState(() {
                                    _obscureConfirmPass = !_obscureConfirmPass;
                                  });
                                }),
                                child: Icon(_obscureConfirmPass
                                    ? Icons.visibility_off
                                    : Icons.visibility),
                              ),
                            ),
                            validator: (val) {
                              debugPrint("Value: " + val.toString());
                              debugPrint("Password: " + password.toString());
                              if (val!.isEmpty) {
                                return "Please confirm your password";
                              } else if (val != password) {
                                return "Your password doesn't match";
                              }
                              return null;
                            },
                            onSaved: (val) {
                              confirm_password = val;
                            },
                            onChanged: (val) {
                              confirm_password = _confirm_password.toString();
                              debugPrint("Confirmed Password: " +
                                  confirm_password.toString());
                              // if (confirm_password != password) {
                              //   return "Password does not match";
                              // }
                              // return null;
                            },
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(height: 15.0),
                        FormField<bool>(
                          builder: (state) {
                            return Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Checkbox(
                                        value: checkboxValue,
                                        onChanged: (value) {
                                          setState(() {
                                            checkboxValue = value!;
                                            state.didChange(value);
                                          });
                                        }),
                                    Text(
                                      "I accept all terms and conditions.",
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ],
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    state.errorText ?? '',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color:
                                          Theme.of(context).colorScheme.error,
                                      fontSize: 12,
                                    ),
                                  ),
                                )
                              ],
                            );
                          },
                          validator: (value) {
                            if (!checkboxValue) {
                              return 'You need to accept terms and conditions';
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(height: 20.0),
                        Container(
                          decoration:
                              ThemeHelper().buttonBoxDecoration(context),
                          child: ElevatedButton(
                            style: ThemeHelper().buttonStyle(Mycolors().blue),
                            child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(40, 10, 40, 10),
                              child: Text(
                                "Register".toUpperCase(),
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                AuthenticationHelper()
                                    .signUp(email: email!, password: password!)
                                    .then((result) {
                                  if (result == null) {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => FriendList()));
                                  } else {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text(
                                        result,
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ));
                                  }
                                });
                              }
                            },
                          ),
                        ),
                        SizedBox(height: 20.0),
                        Container(
                          margin: EdgeInsets.fromLTRB(10, 20, 10, 20),
                          child: Text.rich(TextSpan(children: [
                            TextSpan(text: "Already have an account? "),
                            TextSpan(
                              text: 'Sign in',
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pop(context);
                                },
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Mycolors().blue,
                                // Theme.of(context).colorScheme.secondary
                              ),
                            ),
                          ])),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
