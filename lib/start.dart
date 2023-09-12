import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';


class Start extends StatefulWidget {
  const Start({super.key});

  @override
  State<Start> createState() => _StartState();
}

class _StartState extends State<Start> {
  static String primer = "";
  static int answer = 0;
  static int opt1 = 0;
  static int opt2 = 0;
  static List shuffle =[];

  @override
  void initState() {
    List temp = _generatePrimer();
    primer = temp[0];
    answer = int.parse(temp[1]);
    genOpt();
    shuffle = _getShuffle();
    super.initState();
  }

  static genOpt() {
    opt1 = Random().nextInt(27000) + 1000;
    opt2 = Random().nextInt(320000) + 1000;
  }

  String getTime() {
    var now = DateTime.now().toLocal();
    DateFormat inputFormat = DateFormat('HH:mm:ss');
    var current = inputFormat.format(now);
    return current;
  }

  List<String> _generatePrimer() {
    List actions = ["+", "-", "*"];
    String primer = "";
    int ans = 0;
    String d = actions[Random().nextInt(3)];
    if (d == "+") {
      int a = Random().nextInt(10000) + 1000;
      int b = Random().nextInt(10000) + 1000;
      ans = a + b;
      primer = "$a + $b";
    } else if (d == "-") {
      int a = Random().nextInt(10000) + 5000;
      int b = Random().nextInt(5000) + 1000;
      ans = a - b;
      primer = "$a - $b";
    } else {
      int a = Random().nextInt(1000) + 20;
      int b = Random().nextInt(1000) + 21;
      ans = a * b;
      primer = "$a * $b";
    }
    return [primer, ans.toString()];
  }

  @override
  Widget build(BuildContext context) {
    Timer.periodic(const Duration(seconds: 1), (Timer t) => setState(() {}));
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Column(
          children: [
            const Padding(padding: EdgeInsets.only(top: 100)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  getTime(),
                  style: const TextStyle(fontSize: 50),
                ),
              ],
            ),
            const Padding(padding: EdgeInsets.only(top: 150)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "$primer = ?",
                  style: const TextStyle(fontSize: 30),
                ),
              ],
            ),
            const Padding(padding: EdgeInsets.only(top: 50)),
            if (shuffle[0] == 1)
              _getInc1()
            else if (shuffle[0] == 0)
              _getCorrect()
            else if (shuffle[0] == 2)
              _getInc2()
            ,
            const Padding(padding: EdgeInsets.only(top: 50)),
            if (shuffle[1] == 1)
              _getInc1()
            else if (shuffle[1] == 0)
              _getCorrect()
            else if (shuffle[1] == 2)
              _getInc2()
            ,
            const Padding(padding: EdgeInsets.only(top: 30)),
            if (shuffle[2] == 1)
              _getInc1()
            else if (shuffle[2] == 0)
              _getCorrect()
            else if (shuffle[2] == 2)
                _getInc2()
            ,
          ],
        ),
      ),
    );
  }

  _getCorrect() {
    return TextButton(onPressed: () {
      exit(0);
    }, child: Text(answer.toString(),style: const TextStyle(fontSize: 30)));
  }
  _getInc1(){
    return TextButton(onPressed: (){
      Fluttertoast.showToast(
          msg: "Неверный ответ!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.deepOrange,
          textColor: Colors.white,
          fontSize: 16.0);
    }, child: Text(opt1.toString(),style: const TextStyle(fontSize: 30)));
  }
  _getInc2(){
    return TextButton(onPressed: (){
      Fluttertoast.showToast(
          msg: "Неверный ответ!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.deepOrange,
          textColor: Colors.white,
          fontSize: 16.0);
    }, child: Text(opt2.toString(),style: const TextStyle(fontSize: 30)));
  }

  _getShuffle(){
    int a = Random().nextInt(3);
    int b = -1;
    int c = -1;
    while ((b == a || b == c) || b < 0){
      b = Random().nextInt(3);
    }
    while ((c == a || c == b) || c < 0){
      c = Random().nextInt(3);
    }
    return [a,b,c];
  }
}
