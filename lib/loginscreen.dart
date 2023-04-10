import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

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
    bool isKeyboardVisible =
        KeyboardVisibilityProvider.isKeyboardVisible(context);

    TextEditingController idController = TextEditingController();
    TextEditingController passController = TextEditingController();

    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          isKeyboardVisible
              ? SizedBox(
                  height: screenHeight / 15,
                )
              : Container(
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
              margin: EdgeInsets.only(
                  top: screenHeight / 20, bottom: screenHeight / 20),
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
                feildInput("Enter Employee ID", idController, false),
                feildTitle("Password"),
                feildInput("Enter Password", passController, true),
                Container(
                  height: 60,
                  width: screenWidth,
                  decoration: BoxDecoration(
                      color: primary,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(30))),
                  child: Center(
                    child: Text(
                      "Login",
                      style: TextStyle(
                          fontSize: screenWidth / 20,
                          color: Colors.white,
                          letterSpacing: 2),
                    ),
                  ),
                )
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

  Widget feildInput(
      String hintText, TextEditingController controller, bool obsure) {
    return Container(
      width: screenWidth,
      margin: EdgeInsets.only(bottom: screenHeight / 30),
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
              obscureText: obsure,
            ),
          ))
        ],
      ),
    );
  }
}
