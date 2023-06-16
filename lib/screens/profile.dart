import 'package:flutter/material.dart';
import 'package:surgery_tracker/utils/screen_size.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                const CircleAvatar(
                  radius: 62,
                  child: Hero(
                    tag: 'doctor_profile',
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage: AssetImage('assets/doctor_avatar.jpg'),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Dr. John Doe",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                        leading: const Icon(Icons.pages_rounded),
                        title: const Text(
                          "4545451",
                          style: TextStyle(fontSize: 18),
                        ),
                        subtitle: const Text("Doctor ID"),
                        trailing: const Icon(Icons.edit),
                        children: [
                          TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Doctor ID Required";
                              }
                              return null;
                            },
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.send),
                              ),
                              hintText: 'Enter Doctor ID',
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
                        title: const Text(
                          "John Doe",
                          style: TextStyle(fontSize: 18),
                        ),
                        subtitle: const Text("Full Name"),
                        trailing: const Icon(Icons.edit),
                        children: [
                          TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Full Name Required";
                              }
                              return null;
                            },
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.send),
                              ),
                              hintText: 'Enter Full Name',
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
                        title: const Text(
                          "VOG",
                          style: TextStyle(fontSize: 18),
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
  }
}
