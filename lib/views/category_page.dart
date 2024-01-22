import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:quiz_castle/elements/answer.dart';
import 'package:http/http.dart' as http;
import 'package:quiz_castle/elements/data.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:sensors/sensors.dart';
import 'package:quiz_castle/database_helper.dart';

class CategoryPage extends StatefulWidget {
  CategoryPage({
    Key? key,
    required this.gradColor,
    required this.gradColorshade100,
    required this.imagePath,
    required this.category,
  }) : super(key: key);
  Color gradColor;
  Color gradColorshade100;
  String imagePath;
  String category;

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  String? questionData = '';
  String? answer = '';
  bool isLoading = true;

  void saveQuestionAndAnswer(String question, String answer) async {
    await DatabaseHelper.instance.insert({
      DatabaseHelper.columnQuestion: question,
      DatabaseHelper.columnAnswer: answer
    });
  }

  void fetchdata() async {
    http.Response response;
    response = await http.get(Uri.parse(
        'https://opentdb.com/api.php?amount=1&category=${widget.category}&type=boolean'));
    JsonData jsonData = JsonData.fromJson(json.decode(response.body));

    var unescape = HtmlUnescape();

    questionData = jsonData.results![0].question;
    questionData = unescape.convert(questionData!);
    answer = jsonData.results![0].correctAnswer;
    setState(() {
      isLoading = false;
    });
    saveQuestionAndAnswer(questionData!, answer!);
  }

  Color firstColor = Colors.white;
  Color secondColor = Colors.white;
  IconData firstIcon = Icons.question_mark_rounded;
  IconData secondIcon = Icons.question_mark_rounded;
  void changeColor() {
    setState(() {
      if (answer == 'True') {
        firstColor = Colors.green;
        secondColor = Colors.red;
        firstIcon = Icons.check;
        secondIcon = Icons.close_rounded;
      } else {
        firstColor = Colors.red;
        secondColor = Colors.green;
        firstIcon = Icons.close_rounded;
        secondIcon = Icons.check;
      }
    });
  }

  @override
  void initState() {
    setState(() {
      firstColor = widget.gradColor;
      secondColor = widget.gradColor;
    });
    fetchdata();
    super.initState();
    initShakeListener();
  }

  void initShakeListener() {
    accelerometerEvents.listen((AccelerometerEvent event) {
      if (isShake(event)) {
        setState(() {
          isLoading = true;
          firstColor = widget.gradColor;
          secondColor = widget.gradColor;
          firstIcon = Icons.question_mark_rounded;
          secondIcon = Icons.question_mark_rounded;
          fetchdata();
        });
      }
    });
  }
  double prevX = 0;
  double prevY = 0;
  double prevZ = 0;

  bool isShake(AccelerometerEvent event) {
    double shakeThreshold = 10;
    double x = event.x.abs();
    double y = event.y.abs();
    double z = event.z.abs();

    if (x == prevX && y == prevY && z == prevZ) {
      return false;
    }
    prevX = x;
    prevY = y;
    prevZ = z;

    return (x > shakeThreshold ||
        y > shakeThreshold ||
        z > shakeThreshold);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        child: Icon(
          Icons.arrow_right_alt,
          color: widget.gradColor,
        ),
        onPressed: () {
          setState(() {
            isLoading = true;
            firstColor = widget.gradColor;
            secondColor = widget.gradColor;
            firstIcon = Icons.question_mark_rounded;
            secondIcon = Icons.question_mark_rounded;
            fetchdata();
          });
        },
      ),
      body: Container(
        padding: const EdgeInsets.only(
          top: 100,
          left: 16,
          right: 16,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              widget.gradColor,
              widget.gradColorshade100,
            ],
          ),
        ),
        child: Column(
          children: [
            Center(
              child: Image.asset(
                widget.imagePath,
                height: 200,
                width: 200,
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            // Question
            Center(
              child: isLoading
                  ? const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    )
                  : Container(
                      padding: const EdgeInsets.only(
                        left: 8,
                      ),
                      child: Text(
                        questionData!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
            ),
            const SizedBox(
              height: 32,
            ),
            // options
            // option one
            GestureDetector(
              onTap: () {
                changeColor();
              },
              child: Answer(
                optionColor: widget.gradColor,
                optionValue: 'True',
                backColor: Colors.white,
                answerColor: firstColor,
                optionIcon: firstIcon,
              ),
            ),
            GestureDetector(
              onTap: () {
                changeColor();
              },
              child: Answer(
                optionColor: widget.gradColor,
                optionValue: 'False',
                backColor: Colors.white,
                answerColor: secondColor,
                optionIcon: secondIcon,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
