import 'package:flutter/material.dart';

class Inputfield extends StatefulWidget {
  const Inputfield({super.key});

  @override
  State createState() => InputfieldState();
}

class InputfieldState extends State {
  TextEditingController nametextEditingController = TextEditingController();
  TextEditingController jersytextEditingController = TextEditingController();
  TextEditingController picturetextEditingController = TextEditingController();

  String playername = "";
  String playerjersyno = "";
  String playerpicture = "";

  List<Map> playerinformation = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 62, 39, 103),
        title: const Text(
          "Player Information",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextField(
              controller: nametextEditingController,
              decoration: InputDecoration(
                label: const Text(
                  "Enter Player Name",
                  style: TextStyle(
                    color: Colors.black38,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                prefix: Icon(Icons.task_alt),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.deepOrange, width: 2),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextField(
              controller: jersytextEditingController,
              decoration: InputDecoration(
                label: const Text(
                  "Enter Player Jersy No",
                  style: TextStyle(
                    color: Colors.black38,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                prefix: Icon(Icons.task_alt),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.deepOrange, width: 2),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextField(
              controller: picturetextEditingController,
              decoration: InputDecoration(
                label: const Text(
                  "Enter Player Picture Link",
                  style: TextStyle(
                    color: Colors.black38,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                prefix: Icon(Icons.task_alt),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.deepOrange, width: 2),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              height: 50,
              width: double.infinity,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: const Color.fromARGB(255, 62, 39, 103),
              ),
              child: GestureDetector(
                onTap: () {
                  playername = nametextEditingController.text;
                  playerjersyno = jersytextEditingController.text;
                  playerpicture = picturetextEditingController.text;

                  if (playername.isEmpty &&
                      playerjersyno.isEmpty &&
                      playerpicture.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        duration: Duration(milliseconds: 1000),
                        backgroundColor: Color.fromARGB(255, 62, 39, 103),
                        content: Row(
                          children: [
                            Icon(
                              Icons.sentiment_dissatisfied,
                              color: Colors.white,
                            ),
                            SizedBox(width: 10),
                            const Text(
                              "Please Enter Player Information",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  } else {
                    Map playerinfo = {
                      "playername": playername,
                      "playerjersy": playerjersyno,
                      "playerpicture": playerpicture,
                    };
                    playerinformation.add(playerinfo);
                    nametextEditingController.clear();
                    jersytextEditingController.clear();
                    picturetextEditingController.clear();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Color.fromARGB(255, 62, 39, 103),
                        duration: Duration(milliseconds: 1000),
                        content: Row(
                          children: [
                            Icon(
                              Icons.sentiment_dissatisfied,
                              color: Colors.white,
                            ),
                            SizedBox(width: 10),
                            const Text(
                              "Information Added Successfully",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                    setState(() {});
                  }
                },
                child: const Text(
                  "Add Player Information",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 40),
          Expanded(
            child: ListView.builder(
              physics: ScrollPhysics(),
              shrinkWrap: true,
              itemCount: playerinformation.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Expanded(
                    child: Container(
                      height: 110,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 4,
                            offset: Offset(2, 2),
                          ),
                        ],
                        border: Border.all(
                          color: const Color.fromARGB(255, 62, 39, 103),
                        ),
                        color: const Color.fromARGB(255, 62, 39, 103),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            SizedBox(width: 5),
                            Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(
                                    playerinformation[index]['playerpicture'],
                                  ),
                                  fit: BoxFit.cover,
                                ),
                                color: Colors.amber,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(100),
                                ),
                              ),
                            ),
                            SizedBox(width: 15),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 2),
                                    Text(
                                      "Player Name : ${playerinformation[index]['playername']}",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "Player Jersy no : ${playerinformation[index]['playerjersy']}",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(width: 60),
                            GestureDetector(
                              onTap: () {
                                playerinformation.removeAt(index);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    duration: Duration(milliseconds: 1000),
                                    backgroundColor: Color.fromARGB(
                                      255,
                                      62,
                                      39,
                                      103,
                                    ),
                                    content: Row(
                                      children: [
                                        Icon(
                                          Icons.emoji_emotions,
                                          color: Colors.white,
                                        ),
                                        SizedBox(width: 10),
                                        const Text(
                                          "Information Deleted Successfully",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                                setState(() {});
                              },
                              child: Icon(
                                Icons.delete_outline_outlined,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
