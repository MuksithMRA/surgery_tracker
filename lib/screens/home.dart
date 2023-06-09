import 'package:flutter/material.dart';
import 'package:surgery_tracker/models/screen_size.dart';
import 'package:surgery_tracker/screens/profile.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.white,
        onPressed: () {
          showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              useSafeArea: true,
              builder: (_) => addSurgery());
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
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const ProfileScreen()));
            },
            icon: Hero(
              tag: 'doctor_profile',
              child: CircleAvatar(
                foregroundColor: Theme.of(context).primaryColor,
                backgroundImage: const AssetImage("assets/doctor_avatar.jpg"),
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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Flexible(
                  child: TextField(
                    decoration: InputDecoration(
                      suffixIcon: const Icon(Icons.search),
                      hintText: 'Enter Doctor ID or Surgery Name',
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
                    ...List.generate(
                      10,
                      (index) {
                        return Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              height: 200,
                              width: ScreenSize.width,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Icon(
                                          Icons.person,
                                          size: 95,
                                        ),
                                      ),
                                      Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 5),
                                            child: Row(
                                              children: [
                                                cardSubItem(
                                                    "Surgery", "TAH+BSO"),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                cardSubItem("BHT", "14289"),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 5),
                                            child: Row(
                                              children: [
                                                cardSubItem(
                                                    "Doctor ID", "451235"),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                cardSubItem("Doctor Name",
                                                    "Dr. John Doe"),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    child: Divider(
                                      height: 3,
                                      thickness: 0.5,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Row(
                                      children: [
                                        cardSubItem("Date", "2018-12-12"),
                                        cardSubItem("Done By", "VOG"),
                                        Flexible(
                                          child: ButtonBar(
                                            children: [
                                              InkWell(
                                                onTap: () {},
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.all(8),
                                                  decoration:
                                                      const ShapeDecoration(
                                                    color: Color(0xfff0ad4e),
                                                    shape: CircleBorder(
                                                      side: BorderSide(
                                                        color:
                                                            Colors.transparent,
                                                      ),
                                                    ),
                                                  ),
                                                  child: const Icon(
                                                    Icons.edit,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {},
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.all(8),
                                                  decoration:
                                                      const ShapeDecoration(
                                                    color: Colors.red,
                                                    shape: CircleBorder(
                                                      side: BorderSide(
                                                        color:
                                                            Colors.transparent,
                                                      ),
                                                    ),
                                                  ),
                                                  child: const Icon(
                                                    Icons.delete,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
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
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget cardSubItem(String title, String subtitle) {
    TextStyle titleStyle = const TextStyle(
        color: Colors.white, fontSize: 12, fontWeight: FontWeight.w300);
    TextStyle subTitleStyle = const TextStyle(
      color: Colors.white,
      fontSize: 16,
    );
    return SizedBox(
      width: ScreenSize.width * 0.27,
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

  Widget addSurgery() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
      height: ScreenSize.height * 0.9,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Form(
        key: _key,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: ScreenSize.height * 0.01),
            const Text(
              "Add Your Surgery Record",
              style: TextStyle(
                fontSize: 25,
              ),
            ),
            const Text(
              "Please fill the form below",
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            SizedBox(
              height: ScreenSize.height * 0.05,
            ),
            TextFormField(
              autofocus: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Surgery Name Required";
                }
                return null;
              },
              decoration: InputDecoration(
                hintText: 'Enter Surgery Name',
                filled: true,
                fillColor: Colors.grey.shade200,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "BHT Number Required";
                }
                return null;
              },
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Enter BHT Number',
                filled: true,
                fillColor: Colors.grey.shade200,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
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
              onPressed: () {
                if (_key.currentState!.validate()) {}
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
        ),
      ),
    );
  }
}
