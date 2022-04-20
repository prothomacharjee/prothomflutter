import 'package:flutter/material.dart';
import 'package:prothomflutter/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'list_view_home.dart';

class ToDoList extends StatefulWidget {
  const ToDoList() : super();

  @override
  _ToDoListState createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  String? toDoText;
  String? username;
  SharedPreferences? sharedPreferences;


  TextEditingController textEditingControllerToDoText = TextEditingController();
  getSharedPref() async {
    sharedPreferences = await SharedPreferences.getInstance();
    toDoText = sharedPreferences?.getString("todotext");
    username = sharedPreferences?.getString("uname");
    textEditingControllerToDoText.text=toDoText??'';
    setState(() {

    });
  }

  @override
  void initState() {
    getSharedPref();
    super.initState();
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                 Center(
                  child: Text(
                    "Hello "+username.toString(),
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),

                // Text(
                //   "Write Your Task",
                //   style: TextStyle(fontSize: 20, color: Colors.grey.shade400),
                // ),

                TextField(
                  controller: textEditingControllerToDoText,
                  minLines: 2,
                  maxLines: 5,
                  keyboardType: TextInputType.multiline,
                  decoration: const InputDecoration(
                    hintText: 'Write Your Task',
                    hintStyle: TextStyle(
                        color: Colors.grey
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    ),
                  ),
                ),

                const SizedBox(
                  height: 15,
                ),
                GestureDetector(
                  onTap: () {
                    if (textEditingControllerToDoText.text.isNotEmpty) {
                      sharedPreferences?.setString(
                          "todotext", textEditingControllerToDoText.text);
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
                      "Save",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                GestureDetector(
                  onTap: () {
                    sharedPreferences?.remove('uname');
                    sharedPreferences?.remove('first');
                    sharedPreferences?.remove('todotext');
                    Navigator.of(context).push(
                          MaterialPageRoute(builder: (ctx) => LoginScreen()));

                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: size.height / 14,
                    width: size.width,
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(5)),
                    child: const Text(
                      "Log Out",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),


              ],
            ),
          ),
        ),
      ),
    );
  }
}
