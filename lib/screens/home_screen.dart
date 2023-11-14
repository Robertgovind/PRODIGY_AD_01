import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/back.webp'), fit: BoxFit.cover),
        ),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 35),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(width: 1),
          ),
          child: Container(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        hideInput ? '' : input,
                        textAlign: TextAlign.right,
                        style: const TextStyle(
                            fontSize: 45,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      Text(
                        output,
                        style: TextStyle(
                            fontSize: outputSize,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ButtonContainer(
                            text: 'AC',
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          ButtonContainer(
                            text: '<',
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          ButtonContainer(
                            text: '%',
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          ButtonContainer(
                            text: '/',
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ButtonContainer(
                            text: '7',
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          ButtonContainer(
                            text: '8',
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          ButtonContainer(
                            text: '9',
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          ButtonContainer(
                            text: '*',
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ButtonContainer(
                            text: '4',
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          ButtonContainer(
                            text: '5',
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          ButtonContainer(
                            text: '6',
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          ButtonContainer(
                            text: '-',
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ButtonContainer(
                            text: '1',
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          ButtonContainer(
                            text: '2',
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          ButtonContainer(
                            text: '3',
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          ButtonContainer(
                            text: '+',
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ButtonContainer(
                            text: '0',
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          ButtonContainer(
                            text: '00',
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          ButtonContainer(
                            text: '.',
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          ButtonContainer(
                            text: '=',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  double? firstNumber;
  double? secondNumber;
  var input = "";
  var output = "";
  var operation = "";

  var hideInput = false;
  var outputSize = 35.0;
  onClick(value) {
    if (value == "AC") {
      input = "";
      output = "";
    } else if (value == "<") {
      if (input.isNotEmpty) {
        input = input.substring(0, input.length - 1);
      }
    } else if (value == "=") {
      if (input.isNotEmpty) {
        var userInput = input;
        userInput = input.replaceAll("x", "*");
        Parser p = Parser();
        Expression exp = p.parse(userInput);
        ContextModel cm = ContextModel();
        var finalValue = exp.evaluate(EvaluationType.REAL, cm);
        output = finalValue.toString();
        if (output.endsWith(".1")) {
          output = output.substring(0, output.length - 2);
        }
        input = output;
        hideInput = true;
        outputSize = 56.0;
      }
    } else {
      input = input + value;
      hideInput = false;
      outputSize = 35.0;
    }

    setState(() {});
  }

  Widget ButtonContainer({required text}) {
    return GestureDetector(
      onTap: () {
        onClick(text);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.blue,
        ),
        height: 75,
        width: 75,
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
                fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
