import 'package:flutter/material.dart';
import 'package:flutter_thang/shared/constants.dart';

class SignUp extends StatefulWidget {
  // final Function toggleView;
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();

  String firstName = '';
  String lastName = '';
  String phone = '';
  String email = '';
  String password = '';
  String confirmPassword = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50],
      body: SafeArea(
        child: Center(
          child: ListView(
            shrinkWrap: true,
            padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
            children: [
              const Image(
                image: AssetImage('assets/logo.png'),
                height: 100.0,
              ),
              const SizedBox(height: 50.0),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Expanded(
                          child: TextFormField(
                            onChanged: (val) {
                              setState(() => firstName = val);
                            },
                            validator: (String? val) {
                              if (val != null && val.isEmpty) {
                                return "Enter first name";
                              }
                              return null;
                            },
                            decoration: textInputDecoration.copyWith(
                              labelText: "First name",
                              hintText: "Your first name",
                            ),
                          ),
                        ),
                        const SizedBox(width: 20.0),
                        Expanded(
                          child: TextFormField(
                            onChanged: (val) {
                              setState(() => lastName = val);
                            },
                            validator: (String? val) {
                              if (val != null && val.isEmpty) {
                                return "Enter your last name";
                              }
                              return null;
                            },
                            decoration: textInputDecoration.copyWith(
                              labelText: "Last name",
                              hintText: "Your last name",
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20.0),
                    TextFormField(
                      onChanged: (val) {
                        setState(() => email = val);
                      },
                      validator: (String? val) {
                        if (val != null && val.isEmpty) {
                          return "Enter your phone";
                        }
                        return null;
                      },
                      decoration: textInputDecoration.copyWith(
                        labelText: "Phone",
                        hintText: "Enter your phone",
                        suffixIcon: const Icon(Icons.phone),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    TextFormField(
                      onChanged: (val) {
                        setState(() => email = val);
                      },
                      validator: (String? val) {
                        if (val != null && val.isEmpty) {
                          return "Enter your email";
                        }
                        return null;
                      },
                      decoration: textInputDecoration.copyWith(
                        labelText: "Email",
                        hintText: "Enter your email",
                        suffixIcon: const Icon(Icons.email),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    TextFormField(
                      obscureText: true,
                      onChanged: (val) {
                        setState(() => password = val);
                      },
                      validator: (String? val) {
                        if (val != null && val.isEmpty) {
                          return "Enter password";
                        }
                        return null;
                      },
                      decoration: textInputDecoration.copyWith(
                        labelText: "Password",
                        hintText: "Enter your password",
                        suffixIcon: const Icon(Icons.key),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    TextFormField(
                      obscureText: true,
                      onChanged: (val) {
                        setState(() => password = val);
                      },
                      validator: (String? val) {
                        if (val != null && val.isEmpty) {
                          return "Enter password";
                        }
                        return null;
                      },
                      decoration: textInputDecoration.copyWith(
                        labelText: "Confirm password",
                        hintText: "Confirm password",
                        suffixIcon: const Icon(Icons.key),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // setState(() => loading = true);
                          // dynamic result =
                          //     await _auth.signInWithEmailAndPassword(email, password);
                          // if (result is String) {
                          //   setState(() {
                          //     error = result;
                          //     loading = false;
                          //   });
                          // } else {
                          //   print(email + '-' + password);
                          // }
                          print('sign in');
                        }
                      },
                      child: const Text(
                        'Sign in',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account?"),
                  TextButton(
                    onPressed: () {
                      // widget.toggleView();
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Sign in",
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
