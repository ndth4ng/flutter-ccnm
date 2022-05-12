import 'package:flutter/material.dart';
import 'package:flutter_thang/screens/authenticate/sign_up.dart';
import 'package:flutter_thang/screens/home/home.dart';
import 'package:flutter_thang/shared/constants.dart';

class SignIn extends StatefulWidget {
  static const routeName = '/sign-in';
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50],
      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
          reverse: true,
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
          children: [
            const Image(
              image: AssetImage('assets/logo.png'),
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    onChanged: (val) {
                      setState(() => email = val);
                    },
                    validator: (String? val) {
                      if (val != null && val.isEmpty) {
                        return "Enter email";
                      }
                      return null;
                    },
                    decoration: textInputDecoration.copyWith(
                        labelText: "Email",
                        hintText: "Enter your email",
                        suffixIcon: const Icon(Icons.account_circle)),
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
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (_) => const Home()));
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
                const Text("Do not have an account?"),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, SignUp.routeName);
                  },
                  child: const Text(
                    "Sign up now",
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            )
          ].reversed.toList(),
        ),
      ),
    );
  }
}
