import 'package:flutter/material.dart';
import 'package:test_fltter_app/second_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ResultPage extends StatelessWidget {
  ResultPage(this.result);
  final String result;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('結果発表')
      ),
      body: Center(
        child:  
          Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('結果'),            
            Text(
              result,
              style: TextStyle(
                fontSize: 70,
                color: Colors.red
              ),
            ),
    
            ElevatedButton(
              onPressed: (){
              },
              child: const Text('次の画面へ'),
            ),
          ]
        ),
      ),
    );
  }
}