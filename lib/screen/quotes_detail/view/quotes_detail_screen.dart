import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/db_helper.dart';
import '../../db_model/db_model.dart';
import '../../like/controller/like_controller.dart';

class QuotesDetailsScreen extends StatefulWidget {
  const QuotesDetailsScreen({super.key});

  @override
  State<QuotesDetailsScreen> createState() => _QuotesDetailsScreenState();
}

class _QuotesDetailsScreenState extends State<QuotesDetailsScreen> {
  List l1 = Get.arguments;
  likeController controller = Get.put(likeController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.likeData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("quotes"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              dbModel model = dbModel(
                quotes: l1[1],
                author: l1[0],
                name: l1[3],
              );
              DBHelper.helper.insertQuery(model);
              controller.likeData();
              Get.snackbar("Add to Favorite", "successfully");
            },
            icon: const Icon(Icons.favorite),
          ),
        ],
      ),
      body: Stack(
        children: [
          Image.asset(
            "${l1[2]}",
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText(
                      '${l1[1]}',
                      textStyle: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontFamily: "f6"),
                    ),
                  ],
                  isRepeatingAnimation: false,
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: AnimatedTextKit(
                    animatedTexts: [
                      TypewriterAnimatedText(
                        '- ${l1[0]}',
                        textStyle: const TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontFamily: "f6"),
                      ),
                    ],
                    isRepeatingAnimation: false,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
