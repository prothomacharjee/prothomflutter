import 'package:flutter/material.dart';
import 'package:prothomflutter/list_view_home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen() : super();

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  int? first;
  SharedPreferences? sharedPreferences;
  TextEditingController textEditingControllerUser = TextEditingController();
  TextEditingController textEditingControllerPass = TextEditingController();

  getSharedPref() async {
    sharedPreferences = await SharedPreferences.getInstance();
    first = sharedPreferences?.getInt("first");

    if (first == 1) {
      Navigator.of(context).push(
          MaterialPageRoute(builder: (ctx) => ListViewHome()));
      print(sharedPreferences?.getInt("first"));
      print(sharedPreferences?.getString("uname"));
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Welcome",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Sign in Continue",
                  style: TextStyle(fontSize: 20, color: Colors.grey.shade400),
                ),
                Center(
                  child: Image.asset(
                    'assets/images/login.png',
                    width: 150,
                    height: 150,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextField(
                  controller: textEditingControllerUser,
                  decoration: InputDecoration(
                      labelText: "User ID",
                      labelStyle:
                      TextStyle(fontSize: 15, color: Colors.grey.shade400),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextField(
                  controller: textEditingControllerPass,
                  obscureText: true,
                  decoration: InputDecoration(
                      labelText: "Password",
                      labelStyle:
                      TextStyle(fontSize: 15, color: Colors.grey.shade400),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
                const SizedBox(
                  height: 5,
                ),
                const Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    "Forget Password",
                    style:
                    TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                GestureDetector(
                  onTap: () {
                    if (textEditingControllerUser.text.isNotEmpty &&
                        textEditingControllerPass.text.isNotEmpty) {
                      sharedPreferences?.setInt("first", 1);
                      sharedPreferences?.setString(
                          "uname", textEditingControllerUser.text);
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (ctx) => ListViewHome()));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Fill The Form Correctly")));
                    }
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: size.height / 14,
                    width: size.width,
                    decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(5)),
                    child: const Text(
                      "Login ",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      "I m new Users ",
                      style:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Sign In",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    getSharedPref();
    super.initState();
  }
}
