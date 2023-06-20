import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surgery_tracker/models/error_model.dart';
import 'package:surgery_tracker/screens/home.dart';
import 'package:surgery_tracker/screens/register.dart';
import 'package:surgery_tracker/widgets/custom_textfield.dart';
import 'package:surgery_tracker/widgets/loader_overlay.dart';
import 'package:surgery_tracker/widgets/util_widgets.dart';

import '../providers/auth_provider.dart';
import '../utils/screen_size.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  late AuthProvider pAuth;

  @override
  void initState() {
    super.initState();
    pAuth = Provider.of<AuthProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: _key,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              UtilWidgets.logo(),
              const SizedBox(
                height: 25,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.0),
                child: Text(
                  "Login to continue",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              CustomTextField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Email Address Required";
                  }
                  return null;
                },
                onChange: (value) {
                  pAuth.setEmail(value);
                },
                hintText: 'Email Address',
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Password Required";
                  }
                  return null;
                },
                obsecureText: true,
                hintText: 'Password',
                onChange: (value) {
                  pAuth.setPassword(value);
                },
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blue),
                    fixedSize: MaterialStateProperty.all(
                      Size(
                        ScreenSize.width,
                        ScreenSize.height * 0.065,
                      ),
                    )),
                onPressed: () async {
                  if (_key.currentState!.validate()) {
                    bool isSuccess =
                        await LoadingOverlay.of(context).during(pAuth.login());
                    if (isSuccess && mounted) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const Home(),
                        ),
                      );
                    } else {
                      UtilWidgets.showSnackBar(
                          context, ErrorModel.errorMessage, true);
                    }
                  }
                },
                child: const Text(
                  "Login",
                  style: TextStyle(fontSize: 17, color: Colors.white),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              RichText(
                  text: TextSpan(
                children: [
                  const TextSpan(
                    text: "Don't have an account? ",
                    style: TextStyle(color: Colors.black),
                  ),
                  const WidgetSpan(
                      child: SizedBox(
                    width: 2,
                  )),
                  TextSpan(
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const RegisterScreen(),
                          ),
                        );
                      },
                    text: "Register",
                    style: const TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
