import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'second_page.dart';
import 'dart:async';
import 'firebase_options.dart';

void main() async{  
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 77, 207, 196)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  int _timer = 10;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  void initState() {
    super.initState();
    // 1. Timer.periodic : 新しい繰り返しタイマーを作成します
    // 1秒ごとに _counterを1ずつ足していく
    Timer.periodic(
      // 第一引数：繰り返す間隔の時間を設定
      const Duration(seconds: 1),
      // 第二引数：その間隔ごとに動作させたい処理を書く
      (Timer timer) {
        if (_timer < 1){
          timer.cancel();
          FirebaseFirestore.instance
            .collection('game_result2').add({
            'score': _counter,
          });
          Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SecondPage(_counter),
                  //fullscreenDialog: true,
                ),
              );
        } else{
          _timer--;
          setState(() {});
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("残り"),
            Text(
              _timer.toString(),
              style: TextStyle(
                fontSize: 50
              ),
            ),
            Text(""),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(""),
            ElevatedButton(child: Text('連打!!'),onPressed: _incrementCounter,)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
              //ボタン押したときに呼ばれる処理を書く
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SecondPage(_counter),
                  //fullscreenDialog: true,
                ),
              );
        },
      ),
    );
  }
}


