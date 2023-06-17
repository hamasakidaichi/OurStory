import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'firebase_options.dart';



class SecondPage extends StatelessWidget {
  
  SecondPage(this.count);
  final String count;

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
              count,
              style: const TextStyle(
                fontSize: 50
              ),
            ),
            ElevatedButton(
              onPressed: (){
                  FirebaseFirestore.instance
                    .collection('game_result').add({
                      'score': count,
                    });
            },
            child: const Text('ホームへ戻る'),
            ),
          ]
        ),
      ),
    );
  }
}