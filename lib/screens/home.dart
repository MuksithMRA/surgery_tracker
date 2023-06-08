import 'package:flutter/material.dart';
import 'package:surgery_tracker/models/screen_size.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.white,
        onPressed: () {},
        icon: const Icon(Icons.add, color: Colors.blue),
        label: const Text(
          "Add Surgery",
          style: TextStyle(color: Colors.blue, fontSize: 18),
        ),
      ),
      appBar: AppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Surgery Track",
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
            onPressed: () {},
            icon: const Icon(Icons.person_2),
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
                                                cardSubItem("Done By", "VOG"),
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
}
