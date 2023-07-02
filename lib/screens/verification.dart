import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surgery_tracker/providers/auth_provider.dart';
import 'package:surgery_tracker/screens/login.dart';
import 'package:surgery_tracker/widgets/custom_textfield.dart';
import 'package:surgery_tracker/widgets/loader_overlay.dart';
import 'package:surgery_tracker/widgets/util_widgets.dart';

import '../models/auth_user.dart';
import '../utils/screen_size.dart';

class VerificationPage extends StatefulWidget {
  final bool isFromRegister;
  const VerificationPage({super.key, this.isFromRegister = false});

  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  final GlobalKey<FormState> _verificationKey = GlobalKey<FormState>();
  late AuthProvider pAuth;

  @override
  void initState() {
    super.initState();
    pAuth = Provider.of<AuthProvider>(context, listen: false);
    pAuth.setAuthUser(AuthUser());
  }

  @override
  void dispose() {
    pAuth.setAuthUser(AuthUser());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, auth, child) {
        return Scaffold(
          appBar: AppBar(),
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(15.0),
              height: ScreenSize.height * 0.8,
              child: Form(
                key: _verificationKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    UtilWidgets.logo(),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Account Verification for ${widget.isFromRegister ? 'Registration' : 'Recovery'}",
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    CustomTextField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Email Address Required";
                        } else if (!(value.contains('@') &&
                            value.contains('.'))) {
                          return "Invalid Email Address";
                        }
                        return null;
                      },
                      hintText: 'Email Address',
                      onChange: (value) => auth.setEmail(value),
                    ),
                    const SizedBox(
                      height: 20,
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
                        if (_verificationKey.currentState!.validate()) {
                          await LoadingOverlay.of(context)
                              .during(pAuth.forgetPassword(context));
                        }
                      },
                      child: const Text(
                        "Send Verification Email",
                        style: TextStyle(fontSize: 17, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget changePasswordDialog() {
    return AlertDialog(
      title: const Text("Change Password"),
      content: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomTextField(hintText: "New Password"),
          SizedBox(height: 15),
          CustomTextField(hintText: "Confirm Password"),
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: () {},
          child: const Text("Change Password"),
        ),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const LoginScreen(),
              ),
            );
          },
          child: const Text("Go back to login"),
        )
      ],
    );
  }
}
