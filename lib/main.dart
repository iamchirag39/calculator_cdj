import 'package:calculater/colors.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(myapp());
}

class myapp extends StatelessWidget {
  const myapp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: homepage(),
    );
  }
}

class homepage extends StatefulWidget {
  const homepage({Key? key}) : super(key: key);

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  //variables
  double firstnum = 0.0;
  double secondnum = 0.0;
  var input = '';
  var output = '';
  var opration = '';

  var hideinput = false;
  var outputsize = 34.0;

  onbuttonclick(value) {
    // if value is av
    if (value == "AC") {
      input = '';
      output = '';
    } else if (value == "<") {
      if (input.isNotEmpty) {
        input = input.substring(0, input.length - 1);
      }
    } else if (value == "=") {
      if (input.isNotEmpty) {
        var userinput = input;
        userinput = input.replaceAll("x", "*");
        Parser p = Parser();
        Expression expression = p.parse(userinput);
        ContextModel cm = ContextModel();
        var finalval = expression.evaluate(EvaluationType.REAL, cm);
        output = finalval.toString();
        if (output.endsWith(".0")) {
          output = output.substring(0, output.length - 2);
        }
        input = output;
        hideinput = true;
        outputsize = 52;
      }
    } else {
      input = input + value;

      hideinput = false;
      outputsize = 34;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
              child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  hideinput ? '' : input,
                  style: TextStyle(fontSize: 48, color: Colors.white),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  output,
                  style: TextStyle(
                      fontSize: outputsize,
                      color: Colors.white.withOpacity(0.7)),
                ),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          )),

          //button area
          Row(
            children: [
              button(
                  text: "AC", buttonbgcolor: opratorcolor, tcolor: orangecolor),
              button(
                  text: "<", buttonbgcolor: opratorcolor, tcolor: orangecolor),
              button(text: "", buttonbgcolor: Colors.transparent),
              button(
                  text: "/", buttonbgcolor: opratorcolor, tcolor: orangecolor)
            ],
          ),
          Row(
            children: [
              button(text: "7"),
              button(text: "8"),
              button(
                text: "9",
              ),
              button(
                  text: "x", buttonbgcolor: opratorcolor, tcolor: orangecolor)
            ],
          ),
          Row(
            children: [
              button(text: "4"),
              button(text: "5"),
              button(
                text: "6",
              ),
              button(
                  text: "-", buttonbgcolor: opratorcolor, tcolor: orangecolor)
            ],
          ),
          Row(
            children: [
              button(text: "1"),
              button(text: "2"),
              button(
                text: "3",
              ),
              button(
                  text: "+", buttonbgcolor: opratorcolor, tcolor: orangecolor)
            ],
          ),
          Row(
            children: [
              button(
                  text: "%", buttonbgcolor: opratorcolor, tcolor: orangecolor),
              button(text: "0"),
              button(
                text: ".",
              ),
              button(text: "=", buttonbgcolor: orangecolor)
            ],
          ),
        ],
      ),
    );
  }

  Widget button({text, tcolor = Colors.white, buttonbgcolor = buttoncolor}) {
    return Expanded(
        child: Container(
            margin: EdgeInsets.all(8),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    padding: EdgeInsets.all(22),
                    primary: buttonbgcolor),
                onPressed: () => onbuttonclick(text),
                child: Text(
                  text,
                  style: TextStyle(
                      fontSize: 18, color: tcolor, fontWeight: FontWeight.bold),
                ))));
  }
}
