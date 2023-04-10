import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  double screenHeight = 0;
  double screenWidth = 0;
  Color primary = const Color(0xFFEEF444C);

  @override
  Widget build(BuildContext context) {
    TextEditingController idController = TextEditingController();
    TextEditingController passController = TextEditingController();

    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Column(
        children: [
          Container(
            height: screenHeight / 2.5,
            width: screenWidth,
            decoration: BoxDecoration(
                color: primary,
                borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(50),
                    bottomLeft: Radius.circular(50))),
            child: Center(
              child: Icon(
                Icons.person,
                color: Colors.white,
                size: screenWidth / 5,
              ),
            ),
          ),
          Container(
              child: Text(
            "Login",
            style: TextStyle(fontSize: screenWidth / 12),
          )),
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.symmetric(horizontal: screenWidth / 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                feildTitle("Employee ID"),
                feildInput("Enter Employee ID",idController)
              ],
            ),
          )
        ],
      ),
    );
  }

  /* Reusable Widgets*/

  Widget feildTitle(String title) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Text(
        title,
        style: TextStyle(
          fontSize: screenWidth / 22,
        ),
      ),
    );
  }

  Widget feildInput(String hintText, TextEditingController controller) {
    return Container(
      width: screenWidth,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(12)),
          boxShadow: [
            BoxShadow(
                color: Colors.black26, blurRadius: 10, offset: Offset(2, 2))
          ]),
      child: Row(
        children: [
          Container(
            width: screenWidth / 8,
            //margin: const EdgeInsets.only(left: 10),
            child: Icon(
              Icons.person,
              color: primary,
              size: screenWidth / 15,
            ),
          ),
          Expanded(
              child: Padding(
            padding: EdgeInsets.only(right: screenWidth / 12),
            child: TextFormField(
              enableSuggestions: false,
              autocorrect: false,
              decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: screenHeight / 50),
                  border: InputBorder.none,
                  hintText: hintText),
              maxLines: 1,
            ),
          ))
        ],
      ),
    );
  }
}
