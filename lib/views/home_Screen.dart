import 'dart:io';

import 'package:cafem/consts/customtextfeild.dart';
import 'package:cafem/controller/Auth_controller.dart';
import 'package:cafem/controller/food_controller.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey<FormState> formkey = GlobalKey();

  openAddFoodBottomSheet(context) {
    TextEditingController titlefeild = TextEditingController();
    TextEditingController desfeild = TextEditingController();
    TextEditingController pricefeild = TextEditingController();

    FoodController().images = [];

    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(16),
        width: double.infinity,
        child: SingleChildScrollView(
          child: Form(
            key: formkey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "ADD NEW FOOD ITEM",
                  style:
                      TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Consumer<FoodController>(
                  builder: (context, controller, _) {
                    return controller.images.isEmpty
                        ? GestureDetector(
                            onTap: () {
                              FoodController().pickImage();
                            },
                            child: DottedBorder(
                              radius: Radius.circular(12),
                              borderType: BorderType.RRect,
                              child: Container(
                                width: double.infinity,
                                height: 200.h,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 65.h,
                                    ),
                                    Icon(Icons.upload_file),
                                    Text("Upload Food Images")
                                  ],
                                ),
                              ),
                            ),
                          )
                        : Container(
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            height: 200,
                            child: PageView(
                              children: List.generate(
                                controller.images.length + 1,
                                (index) => index == controller.images.length
                                    ? GestureDetector(
                                        onTap: () {
                                          FoodController().pickImage();
                                        },
                                        child: DottedBorder(
                                          radius: Radius.circular(12),
                                          borderType: BorderType.RRect,
                                          child: Container(
                                            width: double.infinity,
                                            height: 200.h,
                                            child: Column(
                                              children: [
                                                SizedBox(
                                                  height: 65.h,
                                                ),
                                                Icon(Icons.upload_file),
                                                Text("Upload Food Images")
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                    : Stack(
                                        alignment: Alignment.topRight,
                                        children: [
                                          Positioned.fill(
                                            child: Image.file(
                                              File(controller
                                                  .images[index].path),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              controller.removeImage(index);
                                            },
                                            child: CircleAvatar(
                                              child: Icon(Icons.close),
                                            ),
                                          )
                                        ],
                                      ),
                              ),
                            ),
                          );
                  },
                ),
                SizedBox(
                  height: 8.h,
                ),
                customTextFiled(
                    hinttext: "Food Title",
                    controller: titlefeild,
                    required: true),
                SizedBox(
                  height: 8.h,
                ),
                customTextFiled(
                    hinttext: "Food Description",
                    controller: desfeild,
                    required: true),
                SizedBox(
                  height: 8.h,
                ),
                customTextFiled(
                    hinttext: "Food Prie",
                    controller: pricefeild,
                    required: true),
                SizedBox(
                  height: 15.h,
                ),
                SizedBox(
                  height: 45.h,
                  width: double.infinity,
                  child: FilledButton(
                    style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Colors.blue)),
                    onPressed: () {
                      if (formkey.currentState!.validate()) {
                        FoodController().addFooditem(
                            title: titlefeild.text,
                            desc: desfeild.text,
                            price: pricefeild.text);
                        GoRouter.of(context).pop();
                      }
                    },
                    child: Text("Add Product"),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).viewInsets.bottom)
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    FoodController().fetchfooditem();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            onPressed: () {
              AuthController().signOut();
            },
            icon: Icon(
              Icons.logout,
              color: Colors.white,
              size: 30,
            ),
          ),
        ],
        title: Text(
          "Maharaja Chinese",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white70,
        child: Icon(
          Icons.add,
          color: Colors.black,
        ),
        onPressed: () {
          openAddFoodBottomSheet(context);
        },
      ),
    );
  }
}
