import 'package:flutter/material.dart';

class StaticList extends StatefulWidget {
  const StaticList({super.key});

  @override
  State createState() => _StaticListState();
}

class _StaticListState extends State {
  bool isfavorite = false;
  bool isbookmark = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Static list"),
        backgroundColor: Colors.deepOrange,
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          contantent(),
          contantent(),
          contantent(),
          contantent(),
          contantent(),
          contantent(),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepOrange,
        onPressed: () {},
        child: Icon(Icons.add, color: Colors.black, size: 30),
      ),
    );
  }

  Widget contantent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.all(6.0),
          child: Row(
            children: [
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      "https://t3.ftcdn.net/jpg/02/43/12/34/360_F_243123463_zTooub557xEWABDLk0jJklDyLSGl2jrr.jpg",
                    ),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                ),
              ),
              Column(
                children: [
                  Text(
                    "Shivam",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Pune",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(6.0),
          child: Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQoFRQjM-wM_nXMA03AGDXgJK3VeX7vtD3ctA&s",
                ),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        SizedBox(height: 5),
        Padding(
          padding: const EdgeInsets.all(6.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.favorite_border_outlined),
                  SizedBox(width: 12),
                  Icon(Icons.message_outlined),
                  SizedBox(width: 12),
                  Icon(Icons.share_outlined),
                  SizedBox(width: 12),
                ],
              ),
              Icon(Icons.bookmark_add_outlined),
            ],
          ),
        ),
      ],
    );
  }
}
