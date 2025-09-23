import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:msh_checkbox/msh_checkbox.dart';
import 'package:todo_app/Database/database.dart';
import 'package:todo_app/Model/TodoModel.dart';

class CompletedTaskPage extends StatefulWidget {
  final List<Todomodel> list;

  ///this function is used for the Rebuild the UI for parent Widgets[onUpdate]
  final VoidCallback onUpdate;
  const CompletedTaskPage({
    super.key,
    required this.list,
    required this.onUpdate,
  });

  @override
  State<CompletedTaskPage> createState() => _CompletedTaskPageState();
}

class _CompletedTaskPageState extends State<CompletedTaskPage> {
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF02A7B1),
        title: Row(
          children: [
            Text(
              "Completed Task",
              style: GoogleFonts.quicksand(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
          ],
        ),
      ),
      body: ListView.builder(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        itemCount: widget.list.length,
        itemBuilder: (context, index) {
          return Padding(
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
                                widget.list[index].iscompletedcheckbox
                                    ? "Completed"
                                    : "Pending",
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500,
                                  color:
                                      widget.list[index].iscompletedcheckbox
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
                                  widget.list[index].title,
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
                                      widget.list[index].description,
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
                    padding: EdgeInsets.only(right: 10, left: 10, bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.list[index].date,
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
                              value: widget.list[index].iscompletedcheckbox,
                              onChanged: (selected) async {
                                widget.list[index].iscompletedcheckbox =
                                    selected;
                                log("selected : $selected");
                                await HelperDatabase().updatedata(
                                  widget.list[index].updateTomap(),
                                );
                                widget.onUpdate();
                                setState(() {});
                              },
                              colorConfig:
                                  MSHColorConfig.fromCheckedUncheckedDisabled(
                                    checkedColor: Colors.green,
                                    uncheckedColor: Colors.grey,
                                  ),
                            ),
                            SizedBox(width: 5),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
