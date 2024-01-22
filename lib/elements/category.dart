import 'package:flutter/material.dart';
import 'package:quiz_castle/views/category_page.dart';

class Category extends StatelessWidget {
  const Category({
    Key? key,
    required this.boxColor,
    required this.boxColorshade100,
    required this.genreName,
    required this.imagePath,
    required this.category,
  }) : super(key: key);
  final Color boxColor;
  final Color boxColorshade100;
  final String genreName;
  final String imagePath;
  final String category;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => CategoryPage(
                    gradColor: boxColor,
                    gradColorshade100: boxColorshade100,
                    imagePath: imagePath,
                    category: category,
                  )
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Container(
          padding: const EdgeInsets.only(left: 5),
          height: 200,
          width: 300,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32),
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                boxColorshade100,
                boxColor,
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0,2,0,0),
                child: Text(
                  genreName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              Image.asset(
                imagePath,
                height: 80,
                width: 100,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
