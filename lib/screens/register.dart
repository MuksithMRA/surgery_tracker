import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surgery_tracker/models/app_user.dart';
import 'package:surgery_tracker/models/error_model.dart';
import 'package:surgery_tracker/providers/auth_provider.dart';
import 'package:surgery_tracker/utils/screen_size.dart';
import 'package:surgery_tracker/screens/login.dart';
import 'package:surgery_tracker/widgets/custom_textfield.dart';
import 'package:surgery_tracker/widgets/loader_overlay.dart';
import 'package:surgery_tracker/widgets/util_widgets.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late AuthProvider pAuth;
  @override
  void initState() {
    super.initState();
    pAuth = Provider.of<AuthProvider>(context, listen: false);
    pAuth.setAppUser(AppUser());
  }

  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          children: [
            SizedBox(
              height: ScreenSize.height * 0.06,
            ),
            welcomeWidget(),
            SizedBox(
              height: ScreenSize.height * 0.06,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  key: _key,
                  child: Column(
                    children: [
                      CustomTextField(
                        prefixIcon: Icons.person_rounded,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "First Name Required";
                          }
                          return null;
                        },
                        onChange: (value) {
                          pAuth.setFirstName(value);
                        },
                        hintText: 'First Name',
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      CustomTextField(
                        prefixIcon: Icons.person_rounded,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Last Name Required";
                          }
                          return null;
                        },
                        onChange: (value) {
                          pAuth.setLastName(value);
                        },
                        hintText: 'Last Name',
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      CustomTextField(
                        prefixIcon: Icons.medication_rounded,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Specialization Required";
                          }
                          return null;
                        },
                        onChange: (value) {
                          pAuth.setSpecialization(value);
                        },
                        hintText: 'Specialization',
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      CustomTextField(
                        prefixIcon: Icons.mail_rounded,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Email Address Required";
                          } else if (!(value.contains('@') &&
                              value.contains('.'))) {
                            return "Invalid Email Address";
                          }
                          return null;
                        },
                        onChange: (value) {
                          pAuth.setEmail(value);
                        },
                        hintText: 'Email Address',
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      CustomTextField(
                        obsecureText: true,
                        prefixIcon: Icons.lock_open_rounded,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Password Required";
                          }
                          return null;
                        },
                        onChange: (value) {
                          pAuth.setPassword(value);
                        },
                        hintText: 'Password',
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      CustomTextField(
                        obsecureText: true,
                        prefixIcon: Icons.lock_rounded,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Confirm Password Required";
                          } else if (context
                                  .read<AuthProvider>()
                                  .user
                                  .password !=
                              value.trim()) {
                            return "Passwords do not match";
                          }
                          return null;
                        },
                        onChange: (value) {
                          pAuth.setConfirmPassword(value);
                        },
                        hintText: 'Confirm Password',
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.blue),
                            fixedSize: MaterialStateProperty.all(
                              Size(
                                ScreenSize.width,
                                ScreenSize.height * 0.065,
                              ),
                            )),
                        onPressed: () async {
                          if (_key.currentState!.validate()) {
                            bool isSuccess = await LoadingOverlay.of(context)
                                .during(pAuth.register(context));
                            if (isSuccess && mounted) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const LoginScreen(),
                                ),
                              );
                            } else {
                              UtilWidgets.showSnackBar(
                                  context, ErrorModel.errorMessage, true);
                            }
                          }
                        },
                        child: const Text(
                          "Register",
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
                            text: "Already have an account? ",
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
                                    builder: (_) => const LoginScreen(),
                                  ),
                                );
                              },
                            text: "Login",
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
            ),
          ],
        ),
      ),
    );
  }

  Row welcomeWidget() {
    return Row(
      children: [
        Flexible(flex: 1, child: UtilWidgets.flexibleLogo()),
        const SizedBox(
          width: 10,
        ),
        const Flexible(
          flex: 6,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Welcome to Surgery Tracker App",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                "Let's get started to track your surgeries.",
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
