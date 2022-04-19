import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({required Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String userTask = '';
  List taskList = [];
  void initState() {
    super.initState();
    taskList.addAll(['Refactoring cod', 'check bug report', 'fix bugs']);
  }

  void _menuOpen() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (BuildContext context){
        return Scaffold(
          appBar: AppBar(title: Text('Menu'), backgroundColor: Colors.deepOrangeAccent,),
          body: Row(
            children: [
              ElevatedButton(onPressed: (){
                Navigator.pop(context);
                Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
              },
                  child: Text('On main page')),
              Padding(padding: EdgeInsets.only(left: 15)),
              Text('Poor menu')
            ],
          ),
        );
      })
    );
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
        actions: [
          IconButton(
            icon: Icon(Icons.menu_outlined),
            onPressed: _menuOpen,
          )
        ],
      ),
      body: ListView.builder(
        itemCount: taskList.length,
        itemBuilder: (BuildContext context, int index){
          return Dismissible(
            key: Key(taskList[index]),
            child: Card(
                child: ListTile(
                  title: Text(taskList[index]),
                  trailing: IconButton(icon: Icon(Icons.delete, color: Colors.deepOrangeAccent,), onPressed: () {
                    setState(() {
                      taskList.removeAt(index);
                    });
                  },),
                )
            ),
            onDismissed: (direction){
              /*if(direction == DismissDirection.end)*/
              setState(() {
                taskList.removeAt(index);
              });
            },
          );
        }
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepOrangeAccent,
        onPressed: () {
          showDialog(context: context, builder: (BuildeContext){
            return AlertDialog(
              title: Text('Add element'),
              content: TextField(
                onChanged: (String value){
                  userTask = value;
                },
              ),
              actions: [
                ElevatedButton(onPressed: (){
                  setState(() {
                    taskList.add(userTask);
                  });
                  Navigator.of(context).pop();
                }, child: Text('Add'))
              ],
            );
          });
        },
        child: Icon(Icons.add, color: Colors.white,),
      ),
    );
  }
}