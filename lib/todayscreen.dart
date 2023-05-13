import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:employee_attendance_app/model/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:intl/intl.dart';
import 'package:slide_to_act/slide_to_act.dart';

class TodayScreen extends StatefulWidget {
  const TodayScreen({Key? key}) : super(key: key);

  @override
  State<TodayScreen> createState() => _TodayScreenState();
}

class _TodayScreenState extends State<TodayScreen> {
  double screenHeight = 0;
  double screenWidth = 0;
  Color primary = const Color(0xffeef444c);

  @override
  Widget build(BuildContext context) {
    bool isKeyboardVisible =
        KeyboardVisibilityProvider.isKeyboardVisible(context);
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        body: SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.only(top: 32),
            child: Text(
              "Welcome,",
              style: TextStyle(
                color: Colors.black54,
                fontSize: screenWidth / 18,
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              "Employee ${User.userName}",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: screenWidth / 18,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.only(top: 24),
            child: Text(
              "Today's Status",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: screenWidth / 18,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 12, bottom: 30),
            height: 150,
            decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(2, 2),
                  )
                ],
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Check In",
                      style: TextStyle(
                          fontSize: screenWidth / 20,
                          color: Colors.black54,
                          fontWeight: FontWeight.normal),
                    ),
                    Text("09:30",
                        style: TextStyle(
                            fontSize: screenWidth / 18,
                            color: Colors.black,
                            fontWeight: FontWeight.bold)),
                  ],
                )),
                Expanded(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Check Out",
                        style: TextStyle(
                            fontSize: screenWidth / 20,
                            color: Colors.black54,
                            fontWeight: FontWeight.normal)),
                    Text("--/--",
                        style: TextStyle(
                            fontSize: screenWidth / 18,
                            color: Colors.black,
                            fontWeight: FontWeight.bold))
                  ],
                )),
              ],
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: RichText(
                text: TextSpan(
                    text: DateTime.now().day.toString(),
                    style: TextStyle(
                        color: primary,
                        fontSize: screenWidth / 16,
                        fontWeight: FontWeight.bold),
                    children: [
                  TextSpan(
                      text: DateFormat(' MMMM yyyy').format(DateTime.now()),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: screenWidth / 18,
                      ))
                ])),
          ),
          StreamBuilder(
              stream: Stream.periodic(const Duration(seconds: 1)),
              builder: (context, snapshot) {
                return Container(
                  alignment: Alignment.centerLeft,
                  child: RichText(
                      text: TextSpan(
                    text: DateFormat('hh:mm:ss  a').format(DateTime.now()),
                    style: TextStyle(
                        color: Colors.black54,
                        fontSize: screenWidth / 20,
                        fontWeight: FontWeight.normal),
                  )),
                );
              }),
          Container(
            margin: const EdgeInsets.only(top: 32),
            child: Builder(builder: (context) {
              final GlobalKey<SlideActionState> key = GlobalKey();
              return SlideAction(
                text: "Slide to Check Out",
                textStyle: TextStyle(
                  color: Colors.black54,
                  fontSize: screenWidth / 20,
                ),
                outerColor: Colors.white,
                innerColor: primary,
                key: key,
                onSubmit: () async {

                  //print(DateFormat('hh:mm').format(DateTime.now()));
                  QuerySnapshot snap = await FirebaseFirestore.instance
                      .collection("Employee")
                      .where('empId', isEqualTo: User.userName)
                      .get();

                  //print(snap.docs[0].id);

                  DocumentSnapshot snap2 = await FirebaseFirestore.instance
                      .collection("Employee")
                      .doc(snap.docs[0].id)
                      .collection("Record")
                      .doc(DateFormat('dd MMMM yyyy').format(DateTime.now()))
                      .get();

                  try {
                    String checkIn = snap2['checkIn'];
                    await FirebaseFirestore.instance
                        .collection("Employee")
                        .doc(snap.docs[0].id)
                        .collection("Record")
                        .doc(DateFormat('dd MMMM yyyy').format(DateTime.now()))
                        .update({
                      'checkIn' : checkIn,
                      'checkOut' : DateFormat('hh:mm:ss').format(DateTime.now()),
                    });
                    key.currentState!.reset();

                  } catch (e) {
                    await FirebaseFirestore.instance
                        .collection("Employee")
                        .doc(snap.docs[0].id)
                        .collection("Record")
                        .doc(DateFormat('dd MMMM yyyy').format(DateTime.now()))
                        .set({
                      'checkIn' : DateFormat('hh:mm:ss').format(DateTime.now()),
                    });
                    key.currentState!.reset();
                  }


                },
              );
            }),
          )
        ],
      ),
    ));
  }
}
