import 'dart:ffi';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'firebase_options.dart';
import 'result_page.dart';

class SecondPage extends StatelessWidget {
  
  SecondPage(this.count);
  final int count;
  String result_word = '';

  @override
  Widget build(BuildContext context) {
    Firebase.initializeApp();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text('結果')
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('あなたの連打数は'),
            Text(
              '$count',
              style: const TextStyle(
                fontSize: 50
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                 /* FirebaseFirestore.instance
                    .collection('game_result2').add({
                      'score': count,
                    });*/
                //final our_result = FirebaseFirestore.instance.collection('game_result').snapshots();
                final our_results = await FirebaseFirestore.instance.collection("game_result2").get();
                bool Winer_flag = true;
                for (var result in our_results.docs) {
                  //if (count < result.data()){
                    //print(result.data());
                    Map<String, dynamic> maps = result.data();
                    int score = maps['score'];
                    //print(count);
                    if (count < score){
                      Winer_flag = false;
                    }
                }
                if(Winer_flag){
                  result_word = 'Winner!!';
                } else {
                  result_word = 'Lose....';
                }
                print(result_word);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ResultPage(result_word),
                  ),
                );
              },
              child: const Text('ホームへ戻る'),
            ),
            ElevatedButton(
              onPressed: (){
              },
              child: const Text('結果参照'),
            ),
          ]
        ),
      ),
    );
  }
}