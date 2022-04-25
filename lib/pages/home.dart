import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class Home extends StatefulWidget {
  const Home({required Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String userTask = '';
  List taskList = [];

  void initFireBase() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  }

  @override
  void initState() {
    super.initState();
    initFireBase();
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
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('items').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
          return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (BuildContext context, int index){
                return Dismissible(
                  key: Key(snapshot.data!.docs[index].id),
                  child: Card(
                      child: ListTile(
                        title: Text(snapshot.data!.docs[index].get('item')),
                        trailing: IconButton(icon: Icon(Icons.delete, color: Colors.deepOrangeAccent,), onPressed: () {
                          FirebaseFirestore.instance.collection('items').doc(snapshot.data!.docs[index].id).delete();
                        },),
                      )
                  ),
                  onDismissed: (direction){
                    FirebaseFirestore.instance.collection('items').doc(snapshot.data!.docs[index].id).delete();
                  },
                );
              }
          );
        },

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
                  FirebaseFirestore.instance.collection('items').add({'item': userTask});
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