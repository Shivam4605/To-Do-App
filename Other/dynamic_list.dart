import 'dart:developer';

import 'package:flutter/material.dart';

class DynamicList extends StatefulWidget {
  const DynamicList({super.key});

  @override
  State createState() => _DynamicListState();
}

class _DynamicListState extends State {
  List postlist = [];

  @override
  Widget build(BuildContext context) {
    log("Build called");
    return Scaffold(
      appBar: AppBar(
        title: const Text("dynamic list"),
        backgroundColor: Colors.deepOrange,
      ),
      body: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: postlist.length,
        itemBuilder: (BuildContext context, int index) {
          log("list index : $index");
          return contantent(index);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Map postdata = {
            "profileimage":
                "https://t3.ftcdn.net/jpg/02/43/12/34/360_F_243123463_zTooub557xEWABDLk0jJklDyLSGl2jrr.jpg",
            "name": "Shivam",
            "location": "pune",
            "postimage":
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQoFRQjM-wM_nXMA03AGDXgJK3VeX7vtD3ctA&s",
            "islike": false,
            "isbookmark": false,
          };
          log("postindex : ${postlist.length}");
          postlist.add(postdata);
          setState(() {});
        },
        child: Icon(Icons.add, color: Colors.black, size: 30),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget contantent(int currentpostindex) {
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
                      postlist[currentpostindex]['profileimage'],
                    ),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                ),
              ),
              Column(
                children: [
                  Text(
                    postlist[currentpostindex]['name'],
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    postlist[currentpostindex]['location'],
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
                image: NetworkImage(postlist[currentpostindex]['postimage']),
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
                  GestureDetector(
                    onTap: () {
                      if (postlist[currentpostindex]['islike'] == true) {
                        postlist[currentpostindex]['islike'] = false;
                      } else {
                        postlist[currentpostindex]['islike'] = true;
                      }
                      setState(() {});
                    },

                    child: Icon(
                      postlist[currentpostindex]['islike']
                          ? Icons.favorite
                          : Icons.favorite_border_outlined,
                      color:
                          postlist[currentpostindex]['islike']
                              ? Colors.red
                              : Colors.black,
                    ),
                  ),
                  SizedBox(width: 12),
                  Icon(Icons.message_outlined),
                  SizedBox(width: 12),
                  Icon(Icons.share_outlined),
                  SizedBox(width: 12),
                ],
              ),
              GestureDetector(
                onTap: () {
                  if (postlist[currentpostindex]['isbookmark'] == true) {
                    postlist[currentpostindex]['isbookmark'] = false;
                  } else {
                    postlist[currentpostindex]['isbookmark'] = true;
                  }
                  setState(() {});
                },
                child: Icon(
                  postlist[currentpostindex]['isbookmark']
                      ? Icons.bookmark_add
                      : Icons.bookmark_add_outlined,
                  color:
                      postlist[currentpostindex]['isbookmark']
                          ? Colors.deepOrange
                          : Colors.black,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
