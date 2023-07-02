import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:surgery_tracker/providers/auth_provider.dart';

import '../models/error_model.dart';
import '../utils/screen_size.dart';
import '../utils/utils.dart';
import '../widgets/loader_overlay.dart';
import '../widgets/util_widgets.dart';
import 'login.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _specializationController =
      TextEditingController();
  late AuthProvider pAuth;

  @override
  void initState() {
    super.initState();
    pAuth = context.read<AuthProvider>();
    Future.delayed(Duration.zero, () => initialize());
  }

  initialize() async {
    await LoadingOverlay.of(context).during(pAuth.getCurentUserModel());
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _specializationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Profile"),
            actions: [
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
                    bool isLoggedOut = await LoadingOverlay.of(context)
                        .during(pAuth.signOut());
                    if (mounted) {
                      if (isLoggedOut) {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const LoginScreen()));
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
          body: SingleChildScrollView(
            child: SizedBox(
              width: ScreenSize.width,
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    profilePicWidget(context),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "${authProvider.appUser.firstName} ${authProvider.appUser.lastName}",
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: ScreenSize.height * 0.08,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          ExpansionTile(
                            tilePadding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 5),
                            leading: const Icon(Icons.person_rounded),
                            title: Text(
                              authProvider.appUser.firstName,
                              style: const TextStyle(fontSize: 18),
                            ),
                            subtitle: const Text("First Name"),
                            trailing: const Icon(Icons.edit),
                            children: [
                              TextFormField(
                                controller: _firstNameController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "First Name Required";
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    onPressed: () async {
                                      if (_firstNameController
                                          .text.isNotEmpty) {
                                        pAuth.setFirstName(
                                            _firstNameController.text.trim());
                                        await updateProfile();
                                        _firstNameController.clear();
                                      }
                                    },
                                    icon: const Icon(Icons.send),
                                  ),
                                  hintText: 'First Name',
                                  filled: true,
                                  fillColor: Colors.grey.shade200,
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                          ExpansionTile(
                            tilePadding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 5),
                            leading: const Icon(Icons.person_rounded),
                            title: Text(
                              authProvider.appUser.lastName,
                              style: const TextStyle(fontSize: 18),
                            ),
                            subtitle: const Text("Last Name"),
                            trailing: const Icon(Icons.edit),
                            children: [
                              TextFormField(
                                controller: _lastNameController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Last Name Required";
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    onPressed: () async {
                                      if (_lastNameController.text.isNotEmpty) {
                                        pAuth.setLastName(
                                            _lastNameController.text.trim());
                                        await updateProfile();
                                        _lastNameController.clear();
                                      }
                                    },
                                    icon: const Icon(Icons.send),
                                  ),
                                  hintText: 'Last Name',
                                  filled: true,
                                  fillColor: Colors.grey.shade200,
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                          ExpansionTile(
                            tilePadding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 5),
                            leading: const Icon(Icons.masks_rounded),
                            title: Text(
                              authProvider.appUser.specialization,
                              style: const TextStyle(fontSize: 18),
                            ),
                            subtitle: const Text("Speciality"),
                            trailing: const Icon(Icons.edit),
                            children: [
                              TextFormField(
                                controller: _specializationController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Speciality Required";
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    onPressed: () async {
                                      if (_specializationController
                                          .text.isNotEmpty) {
                                        pAuth.setSpecialization(
                                            _specializationController.text
                                                .trim());
                                        await updateProfile();
                                        _specializationController.clear();
                                      }
                                    },
                                    icon: const Icon(Icons.send),
                                  ),
                                  hintText: 'Enter Speciality',
                                  filled: true,
                                  fillColor: Colors.grey.shade200,
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Stack profilePicWidget(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          radius: 62,
          child: Hero(
            tag: 'doctor_profile',
            child: CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage(pAuth.appUser.profileImage),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: GestureDetector(
            onTap: () async {
              await imageSourceOptionsDialog(context);
            },
            child: const CircleAvatar(
              child: Icon(
                Icons.camera_alt,
                size: 25,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<dynamic> imageSourceOptionsDialog(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (_) {
        return Container(
          height: ScreenSize.height * 0.22,
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Choose Image source",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.close_rounded,
                    ),
                  )
                ],
              ),
              ListTile(
                onTap: () async {
                  await showPreviewDialog(ImageSource.camera);
                },
                leading: const Icon(
                  Icons.camera_alt_rounded,
                ),
                title: const Text("Take a photo"),
              ),
              ListTile(
                onTap: () async {
                  await showPreviewDialog(ImageSource.gallery);
                },
                leading: const Icon(
                  Icons.image_rounded,
                ),
                title: const Text("Choose from Gallery"),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget imagePreviewDialog() {
    return AlertDialog(
      title: const Text("Image Preview"),
      content: CircleAvatar(
        radius: 80,
        backgroundImage: Image.file(
          Provider.of<AuthProvider>(context, listen: true).tempProfilePic!,
          fit: BoxFit.cover,
        ).image,
      ),
      actions: [
        ElevatedButton(
          onPressed: () async {
            await LoadingOverlay.of(context).during(pAuth.setProfileImage());
            if (mounted) {
              Navigator.pop(context);
            }
          },
          child: const Text("Set as Profile picture"),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("Close"),
        ),
      ],
    );
  }

  Future<void> updateProfile() async {
    if (mounted) {
      bool isSuccess =
          await LoadingOverlay.of(context).during(pAuth.updateProfile());
      if (mounted) {
        if (isSuccess) {
          UtilWidgets.showSnackBar(
              context, "Profile Updated SuccessFully", false);
        } else {
          UtilWidgets.showSnackBar(context, ErrorModel.errorMessage, true);
        }
      }
    }
  }

  showPreviewDialog(ImageSource source) async {
    await Utils.pickImage(source, context);
    if (mounted) {
      Navigator.pop(context);
      if (pAuth.tempProfilePic != null) {
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (_) => imagePreviewDialog(),
        );
      }
    }
  }
}
