import 'package:flutter/material.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:quiz_castle/elements/category.dart';
import 'package:quiz_castle/views/questions_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[300],
        title: const Text(
            "QuizCastle",
          style: TextStyle(
            fontSize: 23,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.list_alt),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => QuestionsPage()),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 30,
            left: 32,
            right: 32,
          ),
          child: Column(
            children: [
                  GradientText(
                    'Test your knowledge',
                    style: const TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                    ),
                    colors: const [
                      Colors.purple,
                      Colors.red,
                      Colors.purple,
                    ],
                  ),
              const SizedBox(
                height: 10,
              ),
                  const Text(
                    'Choose a category from below',
                    style: TextStyle(
                      fontSize: 17.0,
                      color: Colors.grey,
                    ),
                  ),
              const Divider(
                thickness: 2.0,
                height: 50.0,
              ),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 20,
                  shrinkWrap: true,
                  children: [
                    Category(
                      boxColor: Colors.red,
                      boxColorshade100: Colors.red.shade100,
                      genreName: 'General',
                      imagePath: 'lib/assets/general.png',
                      category: '9',
                    ),
                    Category(
                      boxColor: Colors.blue,
                      boxColorshade100: Colors.blue.shade100,
                      genreName: 'Math',
                      imagePath: 'lib/assets/math.png',
                      category: '19',
                    ),
                    Category(
                      boxColor: Colors.grey,
                      boxColorshade100: Colors.grey.shade100,
                      genreName: 'IT',
                      imagePath: 'lib/assets/IT.png',
                      category: '18',
                    ),
                    Category(
                      boxColor: Colors.green.shade400,
                      boxColorshade100: Colors.green.shade100,
                      genreName: 'Films',
                      imagePath: 'lib/assets/film.png',
                      category: '11',
                    ),
                    Category(
                      boxColor: Colors.yellow.shade800,
                      boxColorshade100: Colors.yellow.shade100,
                      genreName: 'Books',
                      imagePath: 'lib/assets/book.png',
                      category: '10',
                    ),
                    Category(
                      boxColor: Colors.purple.shade300,
                      boxColorshade100: Colors.purple.shade100,
                      genreName: 'History',
                      imagePath: 'lib/assets/history.png',
                      category: '23',
                    ),
                    Category(
                      boxColor: Colors.cyan,
                      boxColorshade100: Colors.cyan.shade100,
                      genreName: 'Sport',
                      imagePath: 'lib/assets/sport.png',
                      category: '21',
                    ),
                    Category(
                      boxColor: Colors.brown,
                      boxColorshade100: Colors.brown.shade100,
                      genreName: 'Animals',
                      imagePath: 'lib/assets/animal.png',
                      category: '27',
                    ),
                    Category(
                      boxColor: Colors.lightGreen,
                      boxColorshade100: Colors.lightGreenAccent.shade100,
                      genreName: 'Games',
                      imagePath: 'lib/assets/pad.png',
                      category: '15',
                    ),
                    Category(
                      boxColor: Colors.pink,
                      boxColorshade100: Colors.pink.shade100,
                      genreName: 'Politics',
                      imagePath: 'lib/assets/politics.png',
                      category: '24',
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
