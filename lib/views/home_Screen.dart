import 'dart:io';
import 'dart:math';

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
              onPressed: () {},
              icon: Icon(
                Icons.shopping_cart_outlined,
                color: Colors.white,
              )),
          IconButton(
            onPressed: () {
              AuthController().signOut();
            },
            icon: Icon(
              Icons.logout,
              color: Colors.white,
            ),
          ),
        ],
        title: Text(
          "Maharaja Chinese",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        child: Icon(
          Icons.add,
          color: Colors.black,
        ),
        onPressed: () {
          openAddFoodBottomSheet(context);
        },
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        width: double.infinity,
        child: Consumer<FoodController>(builder: (context, controller, _) {
          return Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: controller.FoodItems.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      height: 100.h,
                      width: 120.w,
                      child: Image.network(
                        controller.FoodItems[index]['img'][0].toString(),
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            controller.FoodItems[index]['title'],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            controller.FoodItems[index]['desc'],
                            maxLines: 2,
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                  text: controller.FoodItems[index]['price'],
                                  style: TextStyle(color: Colors.black)),
                              TextSpan(
                                  text: "₹",
                                  style: TextStyle(color: Colors.black))
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.add_shopping_cart,
                              color: Colors.blue,
                            ))
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        }),
      ),
      // bottomNavigationBar: BottomAppBar(
      //   color: Colors.blue,
      //   height: 50,
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       Text(
      //         "Continue to Cart",
      //         style: TextStyle(color: Colors.white, fontSize: 16.sp),
      //       ),
      //       SizedBox(
      //         width: 10.w,
      //       ),
      //       Icon(
      //         Icons.shopping_cart_checkout_outlined,
      //         color: Colors.white,
      //       )
      //     ],
      //   ),
      // )
    );
  }
}
