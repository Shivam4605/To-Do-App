import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:list_view/Model/TodoModel.dart';

class Todo extends StatefulWidget {
  const Todo({super.key});

  @override
  State createState() => _TodoState();
}

class _TodoState extends State {
  List<Todomodel> tasklist = [];

  TextEditingController titletextEditingController = TextEditingController();
  TextEditingController descriptiontextEditingController =
      TextEditingController();
  TextEditingController datetextEditingController = TextEditingController();

  int selectcolorindex = 0;

  // this method is used to return the colors of containers

  Color containercolors1(int checkcontainerindex) {
    if (tasklist[checkcontainerindex].colorsindex == 0) {
      return Color(0xFFFAE8E8);
    } else if (tasklist[checkcontainerindex].colorsindex == 1) {
      return Color(0xFFE8EDFA);
    } else if (tasklist[checkcontainerindex].colorsindex == 2) {
      return Color(0xFFFAF9E8);
    } else if (tasklist[checkcontainerindex].colorsindex == 3) {
      return Color(0xFFFAE8FA);
    } else {
      return Color(0xFFFAE8E8);
    }
  }

  // this method is used to return the colors of containers

  Color containercolors2(int checkcontainerindex) {
    if (checkcontainerindex % 4 == 0) {
      return Color(0xFFFAE8E8);
    } else if (checkcontainerindex % 4 == 1) {
      return Color(0xFFE8EDFA);
    } else if (checkcontainerindex % 4 == 2) {
      return Color(0xFFFAF9E8);
    } else if (checkcontainerindex % 4 == 3) {
      return Color(0xFFFAE8FA);
    } else {
      return Color(0xFFFAE8E8);
    }
  }

  // this method is used to clear the text controller after date inserted

  void clearController() {
    titletextEditingController.clear();
    descriptiontextEditingController.clear();
    datetextEditingController.clear();
  }

  // this is used to add the user data into the card's after click into the submit button

  void submitbutton(bool isEdit, [Todomodel? obj]) {
    if (titletextEditingController.text.trim().isNotEmpty &&
        descriptiontextEditingController.text.trim().isNotEmpty &&
        datetextEditingController.text.trim().isNotEmpty) {
      if (isEdit) {
        obj!.title = titletextEditingController.text;
        obj.date = datetextEditingController.text;
        obj.description = descriptiontextEditingController.text;
        obj.colorsindex = selectcolorindex;
      } else {
        tasklist.add(
          Todomodel(
            colorsindex: selectcolorindex,
            date: datetextEditingController.text,
            description: descriptiontextEditingController.text,
            title: titletextEditingController.text,
          ),
        );
      }
      clearController();
      Navigator.of(context).pop();
      setState(() {});
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: Duration(seconds: 1),
          backgroundColor: const Color(0xFF008B94),
          content: Row(
            children: [
              Text(
                "Please Enter The Data",
                style: GoogleFonts.quicksand(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      );
      clearController();
      Navigator.of(context).pop();
    }
  }

  // this Method is the floating Action Button is Tap then Call the showBottomsheetBar Method

  Widget floatingAction() {
    return FloatingActionButton(
      backgroundColor: const Color(0xFF008B94),
      onPressed: () {
        showBottomSheetBar(false);
      },
      elevation: 12,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: const Color(0xFF008B94)),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Icon(Icons.add, color: Colors.white, size: 25),
    );
  }

  //  this method is used to show the Bottom sheet after click the floating action button

  void showBottomSheetBar(bool isEdit, [Todomodel? obj]) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Create To-Do ",
                style: GoogleFonts.quicksand(
                  color: Colors.black,
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5, right: 5, top: 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Title",
                      style: GoogleFonts.quicksand(
                        color: const Color(0xFF008B94),
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(height: 4),
                    TextField(
                      controller: titletextEditingController,
                      decoration: InputDecoration(
                        hintText: "Enter the title",
                        hintStyle: GoogleFonts.quicksand(
                          color: Colors.black87,
                          fontSize: 15,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(width: 2),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 2),
              Padding(
                padding: const EdgeInsets.only(left: 5, right: 5, top: 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Description",
                      style: GoogleFonts.quicksand(
                        color: const Color(0xFF008B94),
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(height: 4),
                    TextField(
                      controller: descriptiontextEditingController,
                      decoration: InputDecoration(
                        hintText: "Enter the Description",
                        hintStyle: GoogleFonts.quicksand(
                          color: Colors.black87,
                          fontSize: 15,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(width: 2),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 2),
              Padding(
                padding: const EdgeInsets.only(left: 5, right: 5, top: 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Date",
                      style: GoogleFonts.quicksand(
                        color: const Color(0xFF008B94),
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(height: 2),
                    TextField(
                      onTap: () async {
                        DateTime? pikdate = await showDatePicker(
                          context: context,
                          firstDate: DateTime(1950),
                          lastDate: DateTime(2050),
                        );
                        datetextEditingController.text = DateFormat.yMMMd()
                            .format(pikdate!);
                      },
                      controller: datetextEditingController,
                      decoration: InputDecoration(
                        hintText: "Enter the Date",
                        hintStyle: GoogleFonts.quicksand(
                          color: Colors.black87,
                          fontSize: 15,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(width: 2),
                        ),
                        suffixIcon: Icon(
                          Icons.calendar_month_outlined,
                          color: const Color(0xFF008B94),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.only(left: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Select To-do Color",
                      style: GoogleFonts.quicksand(
                        color: const Color(0xFF008B94),
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(
                          Color(0xFFFAE8E8),
                        ),
                        shadowColor: WidgetStatePropertyAll(Colors.black),
                      ),
                      onPressed: () {
                        selectcolorindex = 0;
                      },
                      child: Text(""),
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(
                          Color(0xFFE8EDFA),
                        ),
                        shadowColor: WidgetStatePropertyAll(Colors.black),
                      ),
                      onPressed: () {
                        selectcolorindex = 1;
                      },
                      child: Text(""),
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(
                          Color(0xFFFAF9E8),
                        ),
                        shadowColor: WidgetStatePropertyAll(Colors.black),
                      ),
                      onPressed: () {
                        selectcolorindex = 2;
                      },
                      child: Text(""),
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(
                          Color(0xFFFAE8FA),
                        ),
                        shadowColor: WidgetStatePropertyAll(Colors.black),
                      ),
                      onPressed: () {
                        selectcolorindex = 3;
                      },
                      child: Text(""),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.only(right: 5, left: 5, top: 2),
                child: SizedBox(
                  height: 50,
                  width: 350,
                  child: ElevatedButton(
                    onPressed: () {
                      if (isEdit) {
                        submitbutton(isEdit, obj);
                      } else {
                        submitbutton(isEdit);
                      }
                    },
                    style: ButtonStyle(
                      shape: WidgetStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      elevation: WidgetStatePropertyAll(10.0),
                      shadowColor: WidgetStatePropertyAll(Colors.black54),
                      backgroundColor: WidgetStatePropertyAll(
                        const Color(0xFF008B94),
                      ),
                    ),
                    child: Text(
                      "Submit",
                      style: GoogleFonts.quicksand(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 40),
            ],
          ),
        );
      },
    ).whenComplete(() {
      clearController();
    });
  }

  // Main build Method for design the structure of perticuler screen

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: AppBar(
        backgroundColor: const Color(0xFF02A7B1),
        title: Row(
          children: [
            SizedBox(width: 18),
            Text(
              "To-do Iist",
              style: GoogleFonts.quicksand(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 26,
              ),
            ),
            SizedBox(width: 145),
          ],
        ),
      ),
      body: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: tasklist.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 15, right: 15, top: 20),
                child: Container(
                  height: 180,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2.2,
                        blurRadius: 2.2,
                        offset: Offset(0, 2),
                      ),
                    ],
                    color: containercolors1(index),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 5),
                      Expanded(
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Container(
                                alignment: Alignment.center,
                                height: 62,
                                width: 62,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.3),
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                      offset: Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  // child: SvgPicture.asset(
                                  //   "assets/images/keepimage.jpg",
                                  // ),
                                  child: Image.asset(
                                    "assets/images/keepimage.jpg",
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 5),
                                    Text(
                                      tasklist[index].title,
                                      style: GoogleFonts.quicksand(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    SizedBox(height: 6),
                                    Column(
                                      children: [
                                        Text(
                                          tasklist[index].description,
                                          style: GoogleFonts.quicksand(
                                            color: Colors.black,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          right: 10,
                          left: 10,
                          bottom: 10,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              tasklist[index].date,
                              style: GoogleFonts.quicksand(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    titletextEditingController.text =
                                        tasklist[index].title;
                                    descriptiontextEditingController.text =
                                        tasklist[index].description;
                                    datetextEditingController.text =
                                        tasklist[index].date;
                                    setState(() {
                                      tasklist[index].colorsindex =
                                          selectcolorindex;
                                    });
                                    showBottomSheetBar(true, tasklist[index]);
                                    setState(() {});
                                  },
                                  child: SizedBox(
                                    height: 22,
                                    width: 22,
                                    child: Icon(
                                      Icons.edit,
                                      size: 19,
                                      color: const Color(0xFF008B94),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 15),
                                GestureDetector(
                                  onTap: () {
                                    showdialogbox(index);
                                  },
                                  child: SizedBox(
                                    height: 22,
                                    width: 22,
                                    child: Icon(
                                      Icons.delete_outline_outlined,
                                      size: 20,
                                      color: const Color(0xFF008B94),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),

      floatingActionButton: floatingAction(),
    );
  }

  // this method is used for the showing the alert dialog box to ask the To-Do are deleted or not

  Future showdialogbox(int showdialogindex) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "Confirm Deleted To-Do ?",
            style: GoogleFonts.quicksand(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          content: Text(
            "Are you sure you want to delete this To do Task ?",
            style: GoogleFonts.quicksand(
              color: Colors.black,
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
          actions: [
            ElevatedButton(
              style: ButtonStyle(
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    side: BorderSide(color: Colors.black12),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("No", style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            SizedBox(width: 5),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(
                  const Color(0xFF008B94),
                ),
              ),
              onPressed: () {
                tasklist.removeAt(showdialogindex);
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    duration: Duration(seconds: 1),
                    backgroundColor: const Color(0xFF008B94),
                    content: Row(
                      children: [
                        Icon(Icons.emoji_emotions, color: Colors.white),
                        SizedBox(width: 10),
                        Text(
                          "Data Deleted Successfully",
                          style: GoogleFonts.quicksand(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
                setState(() {});
              },
              child: const Text(
                "Yes",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
