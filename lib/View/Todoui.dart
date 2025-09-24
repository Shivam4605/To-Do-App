import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:msh_checkbox/msh_checkbox.dart';
import 'package:todo_app/Database/database.dart';
import 'package:todo_app/Model/TodoModel.dart';
import 'package:todo_app/View/completed_task_page.dart';

class Todo extends StatefulWidget {
  const Todo({super.key});

  @override
  State createState() => _TodoState();
}

class _TodoState extends State with SingleTickerProviderStateMixin {
  List<Todomodel> tasklist = [];
  bool iscompletedcheckbox = false;
  int selectedindex = 0;

  late AnimationController bottomSheetBarAnimation;
  TextEditingController titletextEditingController = TextEditingController();
  TextEditingController descriptiontextEditingController =
      TextEditingController();
  TextEditingController datetextEditingController = TextEditingController();

  Color containercolors(int checkcontainerindex) {
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

  @override
  void initState() {
    super.initState();
    bottomSheetBarAnimation = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 350),
    );
    getdata();
  }

  void getdata() async {
    List<Map> element = await HelperDatabase().getTodoData();
    for (int i = 0; i < element.length; i++) {
      var list = element[i];
      Todomodel todo = Todomodel(
        id: list['id'],
        date: list['date'] ?? "",
        description: list['description'] ?? "",
        title: list['title'] ?? "",
        iscompletedcheckbox: list['iscompletedcheckbox'] == 1,
      );
      tasklist.add(todo);
    }
    log("in List : $element");
    log("in for loop : $iscompletedcheckbox");
    setState(() {});
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
        obj.iscompletedcheckbox = iscompletedcheckbox;
        HelperDatabase().updatedata(obj.updateTomap());
        log("in edit check box : $iscompletedcheckbox");
      } else {
        var newTodo = Todomodel(
          date: datetextEditingController.text,
          description: descriptiontextEditingController.text,
          title: titletextEditingController.text,
          iscompletedcheckbox: iscompletedcheckbox,
        );
        tasklist.add(newTodo);
        HelperDatabase().insertData(newTodo.insertTomap());
        log("insert check box : $iscompletedcheckbox");
      }
      clearController();
      Navigator.of(context).pop();
      setState(() {});
    }
  }

  // this method is used to clear the text controller after date inserted
  void clearController() {
    titletextEditingController.clear();
    descriptiontextEditingController.clear();
    datetextEditingController.clear();
  }

  // this Method is the floating Action Button is Tap then Call the showBottomsheetBar Method
  Widget floatingAction() {
    return FloatingActionButton.extended(
      backgroundColor: const Color(0xFF008B94),
      onPressed: () {
        showBottomSheetBar(false);
      },
      elevation: 12,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: const Color(0xFF008B94)),
        borderRadius: BorderRadius.circular(70),
      ),
      icon: Icon(Icons.add, color: Colors.white, size: 25),
      label: Text(
        "Add To-Do",
        style: GoogleFonts.quicksand(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  //  this method is used to show the Bottom sheet after click the floating action button
  void showBottomSheetBar(bool isEdit, [Todomodel? obj]) {
    showModalBottomSheet(
      transitionAnimationController: bottomSheetBarAnimation,
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 5),
              GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Container(
                  height: 5,
                  width: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.black38,
                  ),
                ),
              ),
              SizedBox(height: 20),
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
              SizedBox(height: 10),
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
              SizedBox(height: 10),
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
              SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: GestureDetector(
                      onTap: () {
                        if (isEdit) {
                          submitbutton(true, obj);
                        } else {
                          submitbutton(false);
                        }
                      },
                      child: Container(
                        height: 50,
                        width: 320,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: const Color(0xFF02A7B1),
                        ),
                        child: Text(
                          "Submit",
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 50),
            ],
          ),
        );
      },
    ).whenComplete(() {
      clearController();
    });
    bottomSheetBarAnimation.upperBound;
  }

  // Main build Method for design the structure of perticuler screen

  @override
  Widget build(BuildContext context) {
    log("IN Build Method");
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: AppBar(
        backgroundColor: const Color(0xFF02A7B1),
        title: Row(
          children: [
            Image.asset("assets/images/appbarimage.png"),
            SizedBox(width: 15),
            Text(
              "To-do Iist",
              style: GoogleFonts.quicksand(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 26,
              ),
            ),
            SizedBox(width: 50),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    List<Todomodel> completedtask = [];
                    for (int i = 0; i < tasklist.length; i++) {
                      if (tasklist[i].iscompletedcheckbox) {
                        completedtask.add(tasklist[i]);
                        log("completed : $completedtask");
                      }
                      setState(() {});
                    }
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return CompletedTaskPage(
                            completedtask: completedtask,
                            onUpdate: () {
                              setState(() {});
                            },
                          );
                        },
                      ),
                    );
                  },
                  child: Container(
                    height: 40,
                    width: 145,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          blurStyle: BlurStyle.outer,
                          color: Colors.grey,
                          blurRadius: 2,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.black26,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Completed Task",
                          style: GoogleFonts.quicksand(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        SizedBox(width: 5),
                        Icon(
                          Icons.arrow_forward_ios_outlined,
                          size: 12,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: tasklist.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          selectedindex = index;
          return Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 15, right: 15, top: 20),
                child: Container(
                  height: 190,
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
                    color: containercolors(index),
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
                              child: Column(
                                children: [
                                  SizedBox(height: 10),
                                  Container(
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
                                      child: Image.asset(
                                        "assets/images/keepimage.jpg",
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 15),
                                  Text(
                                    tasklist[index].iscompletedcheckbox
                                        ? "Completed"
                                        : "Pending",
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w500,
                                      color:
                                          tasklist[index].iscompletedcheckbox
                                              ? Colors.green
                                              : const Color.fromARGB(
                                                255,
                                                202,
                                                45,
                                                34,
                                              ),
                                    ),
                                  ),
                                ],
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
                                MSHCheckbox(
                                  size: 20,
                                  value: tasklist[index].iscompletedcheckbox,
                                  onChanged: (selected) async {
                                    tasklist[index].iscompletedcheckbox =
                                        selected;
                                    log("selected : $selected");
                                    await HelperDatabase().updatedata(
                                      tasklist[index].updateTomap(),
                                    );
                                    setState(() {});
                                    log(
                                      "in task list : ${tasklist[index].iscompletedcheckbox}",
                                    );
                                    log(
                                      "[log] Checkbox updated in DB => ${tasklist[index].updateTomap()}",
                                    );
                                  },
                                  colorConfig:
                                      MSHColorConfig.fromCheckedUncheckedDisabled(
                                        checkedColor: Colors.green,
                                        uncheckedColor: Colors.grey,
                                      ),
                                ),
                                SizedBox(width: 8),
                                GestureDetector(
                                  onTap: () {
                                    titletextEditingController.text =
                                        tasklist[index].title;
                                    descriptiontextEditingController.text =
                                        tasklist[index].description;
                                    datetextEditingController.text =
                                        tasklist[index].date;
                                    setState(() {});
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
                int id = tasklist[showdialogindex].id!;
                tasklist.removeAt(showdialogindex);
                HelperDatabase().deletedata(id);
                Navigator.of(context).pop();
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
