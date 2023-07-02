import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:surgery_tracker/models/error_model.dart';
import 'package:surgery_tracker/models/surgery_model.dart';
import 'package:surgery_tracker/providers/auth_provider.dart';
import 'package:surgery_tracker/providers/surgery_provider.dart';
import 'package:surgery_tracker/utils/screen_size.dart';
import 'package:surgery_tracker/screens/login.dart';
import 'package:surgery_tracker/screens/profile.dart';
import 'package:surgery_tracker/widgets/loader_overlay.dart';
import 'package:surgery_tracker/widgets/util_widgets.dart';

import '../widgets/custom_textfield.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  late AuthProvider pAuth;
  late SurgeryProvider pSurgery;

  @override
  void initState() {
    super.initState();
    pAuth = Provider.of<AuthProvider>(context, listen: false);
    pSurgery = Provider.of<SurgeryProvider>(context, listen: false);
    Future.delayed(Duration.zero, () async {
      await initialize();
    });
  }

  Future<void> initialize() async {
    LoadingOverlay overlay = LoadingOverlay.of(context);
    await overlay.during(pAuth.getCurentUserModel());
    bool isSuccess = await overlay.during(pSurgery.getAllSurgeries());
    if (!isSuccess && mounted) {
      UtilWidgets.showSnackBar(context, ErrorModel.errorMessage, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.white,
        onPressed: () {
          showDialog(
            context: context,
            useSafeArea: true,
            barrierDismissible: false,
            builder: (_) => addSurgery(),
          );
        },
        icon: const Icon(
          Icons.add,
          color: Colors.blue,
        ),
        label: const Text(
          "Add Surgery",
          style: TextStyle(
              color: Colors.blue, fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
      appBar: AppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Surgery Tracker",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            Text(
              "Track your surgeries in one place",
              style: TextStyle(fontSize: 12),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const ProfileScreen(),
                ),
              );
            },
            icon: Hero(
              tag: 'doctor_profile',
              child: CircleAvatar(
                foregroundColor: Theme.of(context).primaryColor,
                backgroundImage: NetworkImage(
                    context.watch<AuthProvider>().appUser.profileImage),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all(
                  Colors.black,
                ),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
              onPressed: () async {
                bool isLoggedOut =
                    await LoadingOverlay.of(context).during(pAuth.signOut());
                if (mounted) {
                  if (isLoggedOut) {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (_) => const LoginScreen()));
                  } else {
                    UtilWidgets.showSnackBar(
                        context, ErrorModel.errorMessage, true);
                  }
                }
              },
              child: const Row(
                children: [
                  Icon(Icons.logout),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Log out",
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      body: Consumer<SurgeryProvider>(builder: (context, surgery, child) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Flexible(
                    child: TextField(
                      onChanged: (value) {
                        pSurgery.searchSurgries(
                          value.trim().toLowerCase(),
                        );
                      },
                      decoration: InputDecoration(
                        suffixIcon: const Icon(Icons.search),
                        hintText: 'Enter Name, BHT or Surgery Name',
                        filled: true,
                        fillColor: Colors.grey.shade200,
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      if (surgery.searchResult.isNotEmpty)
                        ...List.generate(
                          surgery.searchResult.length + 1,
                          (index) {
                            if (index == surgery.searchResult.length) {
                              return SizedBox(
                                height: ScreenSize.height * 0.06,
                              );
                            }
                            SurgeryModel surgeryModel =
                                surgery.searchResult[index];
                            return Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  width: ScreenSize.width,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5),
                                        child: Row(
                                          children: [
                                            cardSubItem(
                                              "Consultant Name",
                                              surgeryModel.consultantName,
                                              width: ScreenSize.width * 0.8,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5),
                                        child: Row(
                                          children: [
                                            cardSubItem(
                                              "Date",
                                              DateFormat.yMMMd()
                                                  .format(surgeryModel.date!),
                                            ),
                                            cardSubItem(
                                                "Done By", surgeryModel.doneBy),
                                            cardActionButton("E", surgeryModel),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5),
                                        child: Row(
                                          children: [
                                            cardSubItem("Surgery",
                                                surgeryModel.surgeryName),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            cardSubItem(
                                                "BHT", surgeryModel.bht),
                                            cardActionButton("D", surgeryModel),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            );
                          },
                        )
                      else
                        const Center(
                          child: Text("No Surgeries Found"),
                        )
                    ],
                  ),
                ),
              ),
            )
          ],
        );
      }),
    );
  }

  Widget cardActionButton(String action, SurgeryModel model) {
    IconData icon = Icons.edit;
    String text = "Edit";
    Color color = const Color(0xfff39c12);
    if (action == "D") {
      icon = Icons.delete;
      text = "Delete";
      color = const Color(0xffe74c3c);
    }
    return ElevatedButton(
      style: ButtonStyle(
        padding: MaterialStateProperty.all(
            const EdgeInsets.symmetric(horizontal: 10)),
        fixedSize: MaterialStateProperty.all(Size(ScreenSize.width * 0.25, 40)),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        backgroundColor: MaterialStateProperty.all(
          color,
        ),
        foregroundColor: MaterialStateProperty.all(
          Colors.white,
        ),
      ),
      onPressed: () {
        if (action == "D") {
          showDialog(
              context: context,
              builder: (_) {
                return AlertDialog(
                  title: const Text("Delete Surgery"),
                  content: const Text(
                      "Are you sure you want to delete this surgery?"),
                  actions: [
                    TextButton(
                      child: const Text('Yes'),
                      onPressed: () async {
                        if (mounted) {
                          bool isSuccess = await LoadingOverlay.of(context)
                              .during(pSurgery.deleteSurgery(model.documentID));
                          if (mounted) {
                            pSurgery.setSurgery(SurgeryModel());
                            if (isSuccess) {
                              Navigator.pop(context);
                              UtilWidgets.showSnackBar(
                                  context, "Deleted Successfully", false);
                            } else {
                              Navigator.pop(context);
                              UtilWidgets.showSnackBar(
                                  context, ErrorModel.errorMessage, false);
                            }
                          }
                        }
                      },
                    ),
                    TextButton(
                      child: const Text('No'),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                );
              });
        } else {
          showDialog(
            context: context,
            builder: (context) => addSurgery(surgery: model),
          );
        }
      },
      child: Row(
        children: [
          Icon(
            icon,
            size: 19,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(text),
        ],
      ),
    );
  }

  Widget cardSubItem(String title, String subtitle, {double? width}) {
    TextStyle titleStyle = const TextStyle(
        color: Colors.white, fontSize: 12, fontWeight: FontWeight.w300);
    TextStyle subTitleStyle = const TextStyle(
      color: Colors.white,
      fontSize: 16,
    );
    return SizedBox(
      width: width ?? ScreenSize.width * 0.3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: titleStyle,
          ),
          Text(
            subtitle,
            style: subTitleStyle,
          ),
        ],
      ),
    );
  }

  Widget addSurgery({SurgeryModel? surgery}) {
    if (surgery != null) {
      pSurgery.setSurgery(surgery);
    }
    return AlertDialog(
      scrollable: true,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${surgery == null ? 'Add' : 'Update'} Your Surgery Record",
            style: const TextStyle(
              fontSize: 25,
            ),
          ),
          Text(
            "Please ${surgery == null ? 'fill' : 'update'} the form below",
            style: const TextStyle(fontSize: 14, color: Colors.grey),
          ),
        ],
      ),
      content: Form(
        key: _key,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: ScreenSize.height * 0.03,
            ),
            CustomTextField(
              hintText: 'Surgery Name',
              initialValue: surgery?.surgeryName,
              onChange: (value) => pSurgery.setSurgeryName(value),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Surgery Name Required";
                }
                return null;
              },
            ),
            const SizedBox(
              height: 15,
            ),
            CustomTextField(
              hintText: 'BHT Number',
              initialValue: surgery?.bht,
              onChange: (value) => pSurgery.setBHTNumber(value),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "BHT Number Required";
                }
                return null;
              },
            ),
            const SizedBox(
              height: 15,
            ),
            CustomTextField(
              hintText: 'Consultant Name',
              initialValue: surgery?.consultantName,
              onChange: (value) => pSurgery.setConsultantName(value),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Consultant Name Required";
                }
                return null;
              },
            ),
            const SizedBox(
              height: 15,
            ),
            CustomTextField(
              initialValue: surgery?.doneBy,
              hintText: 'Consultant Specialization',
              onChange: (value) => pSurgery.setConsultantSpecialization(value),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Consultant Specialization Required";
                }
                return null;
              },
            ),
          ],
        ),
      ),
      actions: [
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
              if (surgery != null) {
                bool isSuccess = await LoadingOverlay.of(context)
                    .during(pSurgery.editSurgery());
                if (isSuccess && mounted) {
                  _key.currentState!.reset();
                  pSurgery.setSurgery(SurgeryModel());
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => const Home()));
                  UtilWidgets.showSnackBar(
                      context, "Surgery Updated Successfully", false);
                }
              } else {
                bool isSuccess = await LoadingOverlay.of(context)
                    .during(pSurgery.saveSurgery());
                if (isSuccess && mounted) {
                  _key.currentState!.reset();
                  pSurgery.setSurgery(SurgeryModel());
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => const Home()));
                  UtilWidgets.showSnackBar(
                      context, "Surgery Added Successfully", false);
                } else {
                  UtilWidgets.showSnackBar(
                      context, ErrorModel.errorMessage, true);
                }
              }
            }
          },
          child: const Text(
            "Submit Record",
            style: TextStyle(fontSize: 17, color: Colors.white),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        OutlinedButton(
          style: ButtonStyle(
              side: MaterialStateProperty.all(
                const BorderSide(color: Colors.blue),
              ),
              fixedSize: MaterialStateProperty.all(
                Size(
                  ScreenSize.width,
                  ScreenSize.height * 0.065,
                ),
              )),
          onPressed: () {
            Navigator.pop(context);
            _key.currentState!.reset();
          },
          child: const Text(
            "Cancel",
            style: TextStyle(fontSize: 17, color: Colors.blue),
          ),
        )
      ],
    );
  }
}
