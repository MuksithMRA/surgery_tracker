import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surgery_tracker/providers/auth_provider.dart';
import 'package:surgery_tracker/widgets/custom_textfield.dart';
import 'package:surgery_tracker/widgets/util_widgets.dart';

import '../utils/screen_size.dart';

class VerificationPage extends StatefulWidget {
  final bool isFromRegister;
  const VerificationPage({super.key, this.isFromRegister = false});

  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  final GlobalKey<FormState> _verificationKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    Provider.of<AuthProvider>(context, listen: false).isVerificationCodeSent =
        false;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, auth, child) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(15.0),
              height: ScreenSize.height,
              child: Form(
                key: _verificationKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    UtilWidgets.logo(),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Account Verification for Registration",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    CustomTextField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Email Address Required";
                          }
                          return null;
                        },
                        isReadOnly: auth.isVerificationCodeSent,
                        hintText: 'Email Address'),
                    if (auth.isVerificationCodeSent)
                      Column(
                        children: [
                          const SizedBox(
                            height: 15,
                          ),
                          CustomTextField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Verification Code Required";
                                }
                                return null;
                              },
                              hintText: 'Verification Code'),
                        ],
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
                      onPressed: () {
                        if (_verificationKey.currentState!.validate()) {
                          auth.setIsVerificationEmailSent(
                              !auth.isVerificationCodeSent);
                        }
                      },
                      child: Text(
                        auth.isVerificationCodeSent
                            ? "Verify Account"
                            : "Send Verification Code",
                        style:
                            const TextStyle(fontSize: 17, color: Colors.white),
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
}
