import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({required Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List taskList = [];
  void initState() {
    super.initState();
    taskList.addAll(['Refactoring cod', 'check bug report', 'fix bugs']);
  }

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text('Task list', style: TextStyle(
          fontSize: 20
        ),),
        centerTitle: true,
        backgroundColor: Colors.deepOrangeAccent,
      ),
      body: ListView.builder(
        itemCount: taskList.length,
        itemBuilder: (BuildContext contex, int index){
          return Dismissible(
            key: Key(taskList[index]),
            child: ListTile(title: Text(taskList[index]),)
          );
        }
      ),
    );
  }
}