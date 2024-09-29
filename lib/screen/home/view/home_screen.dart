
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/db_helper.dart';
import '../../../utils/share_helper.dart';
import '../../category_model/category_model.dart';
import '../controller/home_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeController controller = Get.put(HomeController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.quotesGetData();
    // controller.quotescategory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.black,
        title: const Text("Quotes"),
        centerTitle: true,
        actions: [
          PopupMenuButton(
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  onTap: () {
                    Get.toNamed('like');
                  },
                  child: const Text("Like"),
                ),
              ];
            },
          ),
          Obx(
            () => Switch(
              value: controller.isLight.value,
              onChanged: (value) {
                ShareHelper shr = ShareHelper.helper;
                shr.setTheme(value);
                controller.changeTheme();
              },
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Image.asset(controller.isLight.value ?
            ("assets/image/b2.jpeg")
            :("assets/image/b7.jpeg"),
            height: MediaQuery.sizeOf(context).height,
            width: MediaQuery.sizeOf(context).width,
            fit: BoxFit.cover,
          ),
          Column(
            children: [
              Expanded(
                child: Obx(
                  () => ListView.builder(
                    itemCount: controller.list.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Get.toNamed('detail',
                              arguments: controller.list[index]);
                        },
                        child: Container(
                          margin: const EdgeInsets.all(10),
                          height: 100,
                          padding: const EdgeInsets.all(20),
                          width: MediaQuery.sizeOf(context).width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.primaries[index].withOpacity(0.7)),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${controller.list[index].name}",
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22,
                                    fontFamily: "f6"),
                              ),
                              IconButton(
                                  onPressed: () {
                                    categoryModel model = categoryModel(
                                        name: controller.list[index].name);
                                    DBHelper.helper.insertCategory(model);
                                    controller.quotesCategory();
                                    Get.snackbar(
                                        "Add To Favorite Quotes", "successfully");
                                  },
                                  icon: const Icon(Icons.favorite)),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
