import 'package:flutter/material.dart';
import 'package:test_fltter_app/second_page.dart';

class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ファースト')
      ),
      body: Center(
        child:  
          Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const TextField(
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
              ),
            ),
    
               ElevatedButton(
              onPressed: (){
              //ボタン押したときに呼ばれる処理を書く
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SecondPage('abcd'),
                  //fullscreenDialog: true,
                ),
              );
              },
            child: const Text('次の画面へ'),
            ),
          ]
        ),
      ),
    );
  }
}