import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final Color secondryTextColor = Color(0xFFFFC107);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BMI Calculator',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black,
        brightness: Brightness.light,
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFF455A64),
        ),
        textTheme: GoogleFonts.latoTextTheme(
          TextTheme(
            bodyText2: TextStyle(fontSize: 15, color: secondryTextColor),
            bodyText1: TextStyle(
                fontWeight: FontWeight.w900, color: secondryTextColor),
          ),
        ),
        primarySwatch: Colors.blue,
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _weightController = TextEditingController();

  TextEditingController _heightController = TextEditingController();

  double _bmiResult = 0;

  String _textResult = '';

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final SizedBox sizedBox1 = SizedBox(
      height: 50,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('BMI Calculator'),
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: textTheme.bodyText1!.color,
          fontSize: 25,
        ),
      ),
      body: Column(
        children: [
          sizedBox1,
          Text(
            'Please enter the weight as decimal',
            style: TextStyle(
                color: Theme.of(context).textTheme.bodyText1!.color,
                fontSize: 20),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 25, 30, 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 90,
                  width: 110,
                  child: TextField(
                    controller: _heightController,
                    style: TextStyle(
                        color: textTheme.bodyText1!.color, fontSize: 25),
                    decoration: InputDecoration(
                        hintText: 'Height',
                        hintStyle: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: textTheme.bodyText1!.color)),
                  ),
                ),
                Container(
                  height: 90,
                  width: 110,
                  child: TextField(
                    controller: _weightController,
                    style: TextStyle(
                        color: textTheme.bodyText1!.color, fontSize: 25),
                    decoration: InputDecoration(
                        hintText: 'Weight',
                        hintStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            color:
                                Theme.of(context).textTheme.bodyText1!.color)),
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
            ),
            onPressed: () {
              double height = double.parse(_heightController.text);
              double weight = double.parse(_weightController.text);
              setState(() {
                _bmiResult = weight / (height * height);
                if (_bmiResult > 25) {
                  _textResult = 'You are over Weight !';
                } else if (_bmiResult >= 18.5 && _bmiResult <= 25) {
                  _textResult = 'HOORAA FIT !';
                } else {
                  _textResult = 'You are under weight';
                }
              });
            },
            child: Text(
              'Calculate',
              style: TextStyle(color: textTheme.bodyText1!.color, fontSize: 25),
            ),
          ),
          sizedBox1,
          Text(
            _bmiResult.toString(),
            style: TextStyle(color: textTheme.bodyText1!.color, fontSize: 25),
          ),
          sizedBox1,
          Visibility(
            visible: _textResult.isNotEmpty,
            child: Text(
              _textResult,
              style: TextStyle(color: textTheme.bodyText1!.color, fontSize: 25),
            ),
          ),
          sizedBox1,
          RightBar(barWidth: 40),
          RightBar(barWidth: 100),
          RightBar(barWidth: 60),
          LeftBar(barWidth: 45),
          LeftBar(barWidth: 55)
        ],
      ),
    );
  }
}

class RightBar extends StatelessWidget {
  final double barWidth;
  const RightBar({super.key, required this.barWidth});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, bottom: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            height: 26,
            width: barWidth,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20)),
                color: Theme.of(context).textTheme.bodyText1!.color),
          ),
        ],
      ),
    );
  }
}

class LeftBar extends StatelessWidget {
  final double barWidth;
  const LeftBar({super.key, required this.barWidth});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 26,
            width: barWidth,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
                color: Theme.of(context).textTheme.bodyText1!.color),
          ),
        ],
      ),
    );
  }
}
