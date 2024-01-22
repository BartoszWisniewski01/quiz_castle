import 'package:flutter/material.dart';
import 'package:quiz_castle/database_helper.dart';

class QuestionsPage extends StatefulWidget {
  const QuestionsPage({super.key});

  @override
  _QuestionsPageState createState() => _QuestionsPageState();
}

class _QuestionsPageState extends State<QuestionsPage> {
  late Future<List<Map<String, dynamic>>> questions;

  @override
  void initState() {
    super.initState();
    refreshQuestions();
  }

  void refreshQuestions() {
    setState(() {
      questions = DatabaseHelper.instance.queryAllRows();
    });
  }

  void deleteQuestion(int id) async {
    await DatabaseHelper.instance.delete(id);
    refreshQuestions();
  }

  void deleteAllQuestions() async {
    await DatabaseHelper.instance.deleteAll();
    refreshQuestions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("History"),
        backgroundColor: Colors.blueGrey[300],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder<List<Map<String, dynamic>>>(
                future: questions,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        var question = snapshot.data![index];
                        return Card(
                          elevation: 4,
                          child: ListTile(
                            leading: Icon(Icons.question_answer, color: Colors.blueGrey),
                            title: Text(question['question'], style: const TextStyle(fontWeight: FontWeight.bold)),
                            subtitle: Text('Answer: ${question['answer']}'),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () => deleteQuestion(question['id']),
                            ),
                          ),
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return const Center(child: Text('An error occurred'));
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: ElevatedButton(
                onPressed: deleteAllQuestions,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.red,
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                ),
                child: const Text("Delete All", style: TextStyle(fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
