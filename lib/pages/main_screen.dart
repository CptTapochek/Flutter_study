import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({required Key? key}) : super(key: key);

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
      body: Column(
        children: [
          Text('Main Screen', style: TextStyle(color: Colors.white),),
          ElevatedButton(onPressed: (){
            Navigator.pushNamedAndRemoveUntil(context, '/task_list', (route) => false);
          }, child: Text('Next'))
        ],
      ),
    );
  }

}