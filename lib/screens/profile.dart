import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:surgery_tracker/providers/user_provider.dart';
import 'package:surgery_tracker/utils/screen_size.dart';
import 'package:surgery_tracker/utils/utils.dart';
import 'package:surgery_tracker/widgets/loader_overlay.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late UserProvider pUser;
  @override
  void initState() {
    super.initState();
    pUser = Provider.of<UserProvider>(context, listen: false);
    Future.delayed(Duration.zero, () => initialize());
  }

  initialize() async {
    await LoadingOverlay.of(context).during(pUser.getUser());
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, userProvider, child) {
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
                  onPressed: () {},
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
                      "${userProvider.user.firstName} ${userProvider.user.lastName}",
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
                              userProvider.user.firstName,
                              style: const TextStyle(fontSize: 18),
                            ),
                            subtitle: const Text("First Name"),
                            trailing: const Icon(Icons.edit),
                            children: [
                              TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "First Name Required";
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    onPressed: () {},
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
                              userProvider.user.lastName,
                              style: const TextStyle(fontSize: 18),
                            ),
                            subtitle: const Text("Last Name"),
                            trailing: const Icon(Icons.edit),
                            children: [
                              TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Last Name Required";
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    onPressed: () {},
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
                              userProvider.user.specialization,
                              style: const TextStyle(fontSize: 18),
                            ),
                            subtitle: const Text("Speciality"),
                            trailing: const Icon(Icons.edit),
                            children: [
                              TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Speciality Required";
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    onPressed: () {},
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
              backgroundImage: pUser.profilePic?.image,
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: GestureDetector(
            onTap: () async {
              showModalBottomSheet(
                  context: context,
                  builder: (_) {
                    return Container(
                      height: ScreenSize.height * 0.2,
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
                  });
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

  Widget imagePreviewDialog() {
    return AlertDialog(
      title: const Text("Image Preview"),
      content: CircleAvatar(
        radius: 80,
        backgroundImage: Provider.of<UserProvider>(context, listen: true)
            .tempProfilePic
            ?.image,
      ),
      actions: [
        ElevatedButton(
            onPressed: () {}, child: const Text("Set as Profile picture")),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("Close"),
        ),
      ],
    );
  }

  showPreviewDialog(ImageSource source) async {
    await Utils.pickImage(source, context);
    if (mounted) {
      Navigator.pop(context);
      if (pUser.tempProfilePic != null) {
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (_) => imagePreviewDialog(),
        );
      }
    }
  }
}
