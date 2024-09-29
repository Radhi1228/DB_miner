import 'package:db_minor/screen/home/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/db_helper.dart';
import '../controller/like_controller.dart';

class LikeScreen extends StatefulWidget {
  const LikeScreen({super.key});

  @override
  State<LikeScreen> createState() => _LikeScreenState();
}

class _LikeScreenState extends State<LikeScreen> {
  likeController controller = Get.put(likeController());
  HomeController homeController = Get.put(HomeController());

  void initState() {
    // TODO: implement initState
    super.initState();
    controller.likeData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: homeController.isLight.value ? Colors.white:Colors.black.withOpacity(0.2),
      body: Column(
        children: [
          Obx(
            () => Expanded(
              child: ListView.builder(
                itemCount: controller.likelist.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      leading: Text("${controller.likelist[index].id}"),
                      title: Text(
                        "${controller.likelist[index].quotes}",
                        style: const TextStyle(fontSize: 18, fontFamily: "f6"),
                      ),
                      subtitle: Text(
                        "- ${controller.likelist[index].author}",
                        style: const TextStyle(fontSize: 18, fontFamily: "f6"),
                      ),
                      trailing: IconButton(
                        onPressed: () {
                          Get.defaultDialog(
                            title: "Delete Quote",
                            content: const Text("Are you sure want to delete?"),
                            actions: [
                              ElevatedButton(
                                onPressed: () {
                                  DBHelper.helper.deleteQuery(
                                      controller.likelist[index].id!);
                                  controller.likeData();
                                  Get.back();
                                },
                                child: const Text(
                                  "Yes",
                                  style: TextStyle(color: Colors.green),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Get.back();
                                },
                                child: const Text(
                                  "No",
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                            ],
                          );
                        },
                        icon: const Icon(Icons.delete),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
