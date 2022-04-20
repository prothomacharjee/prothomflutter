import 'package:flutter/material.dart';
import 'package:prothomflutter/login_screen.dart';
import 'package:prothomflutter/to_do.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ListViewHome extends StatefulWidget {
  @override
  State<ListViewHome> createState() => _ListViewHomeState();
}

class _ListViewHomeState extends State<ListViewHome> {
  TextEditingController textEditingController = TextEditingController();
  TextEditingController textEditingControllerSubmit = TextEditingController();
  SharedPreferences? sharedPreference;
  late int arrayIndex = 3;
  String? username;
  String? submitText;

  List titles = ["List 1", "List 2", "List 3"];

  List subtitles = [
    "Here is list 1 subtitle",
    "Here is list 2 subtitle",
    "Here is list 3 subtitle"
  ];

  // List icons = [Icons.person_remove_alt_1_rounded, Icons.access_alarm, Icons.access_time];

  getSharedPref() async {
    sharedPreference = await SharedPreferences.getInstance();
    username = sharedPreference?.getString("uname");
    submitText = sharedPreference?.getString("submitText");
    setState(() {});
  }

  addNewItem() {
    int xx = arrayIndex + 1;
    titles.add("List " + xx.toString());
    subtitles.add("Here is list " + xx.toString() + " subtitle ");
    arrayIndex++;

    setState(() {});
  }

  removeNewItem(index) {
    titles.removeAt(index);
    subtitles.removeAt(index);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            Text(
              "Hello " + username.toString(),
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 450,
              child: ListView.separated(
                  shrinkWrap: false,
                  separatorBuilder: (BuildContext context, int index) =>
                      const Divider(),
                  itemCount: titles.length,
                  itemBuilder: (context, index) {
                    return Card(
                        child: ListTile(
                      title: Text(titles[index]),
                      subtitle: Text(subtitles[index]),
                      leading: const CircleAvatar(
                          backgroundImage:
                              AssetImage("assets/images/product.jpg")),
                      trailing: Column(
                        children: [
                          GestureDetector(
                              onTap: () {
                                textEditingController.text = titles[index];
                                openDialog(index,titles[index]);
                              },
                              child: const Icon(
                                Icons.edit,
                                color: Colors.red,
                              )),
                          GestureDetector(
                              onTap: () {
                                removeNewItem(index);
                              },
                              child: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              )),
                        ],
                      ),
                      // trailing: GestureDetector(
                      //     onTap: () {
                      //       removeNewItem(index);
                      //     },
                      //     child: const Icon(
                      //       Icons.delete,
                      //       color: Colors.red,
                      //     ))
                    ));
                  }),
            ),
            FloatingActionButton(
              onPressed: addNewItem,
              child: Icon(Icons.add),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (ctx) => ToDoList()));
              },
              child: Container(
                alignment: Alignment.center,
                height: 100,
                width: 200,
                decoration: BoxDecoration(
                    color: Colors.indigo,
                    borderRadius: BorderRadius.circular(5)),
                child: const Text(
                  "Open To Do List ",
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
                sharedPreference?.remove('uname');
                sharedPreference?.remove('first');
                sharedPreference?.remove('todotext');
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (ctx) => LoginScreen()));
              },
              child: Container(
                alignment: Alignment.center,
                height: 100,
                width: 200,
                decoration: BoxDecoration(
                    color: Colors.red, borderRadius: BorderRadius.circular(5)),
                child: const Text(
                  "Log Out",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future openDialog(index, text) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Change List Name"),
          content: TextField(
            controller: textEditingController,
            decoration: const InputDecoration(
              hintText: 'Edit List Name',
              hintStyle: TextStyle(color: Colors.grey),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
              ),
            ),
          ),
          actions: [GestureDetector(
            onTap: () {
              sharedPreference?.setString("submitText", textEditingController.text);
              submit(index);
            },
            child: Container(
              alignment: Alignment.center,
              height: 50,
              width: 200,
              decoration: BoxDecoration(
                  color: Colors.indigo,
                  borderRadius: BorderRadius.circular(5)),
              child: const Text(
                "Submit",
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          )],
        ),
      );

  submit(index) {
      titles[index]=sharedPreference?.getString("submitText");
      setState(() {

      });
      Navigator.of(context).pop();
  }

  @override
  void initState() {
    getSharedPref();
    //addNewItem();
    super.initState();
  }
}
