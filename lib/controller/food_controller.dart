import 'dart:io';

import 'package:cafem/controller/Auth_controller.dart';
import 'package:cafem/main.dart';
import 'package:cafem/services/file_upload.dart';
import 'package:cafem/utility/scankbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class FoodController extends ChangeNotifier {
  static FoodController instance = FoodController.internal();
  FoodController.internal();
  factory FoodController() => instance;

  List<XFile> images = [];

  pickImage() async {
    List<XFile> images = await ImagePicker().pickMultiImage();
    this.images.addAll(images);
    notifyListeners();
  }

  removeImage(index) {
    images.removeAt(index);
    notifyListeners();
  }

  uploadImages() {
    List<String> urls = [];

    images.forEach((image) async {
      String? url = await FileUpload().upload(File(image.path));

      print(url);
      urls.add(url!);
    });

    return urls;
  }

  addFooditem({title, desc, price}) async {
    List<String?> url = await uploadImages();
    print(url);

    await FirebaseFirestore.instance.collection("FoodItems").add(
      {
        'title': title,
        'desc': desc,
        'price': price,
        'img': url,
        'uid': AuthController().uid
      },
    );
    displaySnackbar("Product Added SucCessfully", color: Colors.green);
  }

  fetchfooditem() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('FoodItems')
        .where('uid', isEqualTo: AuthController().uid)
        .get();

    snapshot.docs.forEach((doc) {
      logger.d(doc.data());
    });
  }
}
