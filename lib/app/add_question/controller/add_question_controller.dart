import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widget/show_dialouge.dart';

class AddQuestionController extends GetxController {
  TextEditingController questionController = TextEditingController();
  TextEditingController optioncontroller1 = TextEditingController();
  TextEditingController optioncontroller2 = TextEditingController();
  TextEditingController optioncontroller3 = TextEditingController();
  TextEditingController optioncontroller4 = TextEditingController();
  TextEditingController correctAnswerController = TextEditingController();

  late String selectedField1 = ""; // Value for the first dropdown
  late String selectedField2 = ""; // Value for the second dropdown
  late String selectedField3 = ""; // Value for the third dropdown

  List<String> field1Items = [
    'SSC',
    'HSC',
    'Admission'
  ]; // Items for the first dropdown
  List<String> field2Items = [
    'English',
    'Bangla',
    'Genaral math',
    'Physics',
    'Chemistry',
    'Biology',
    'Hiremath'
  ]; // Items for the second dropdown
  List<String> field3Items = [
    'chapter 1',
    'chapter 2',
    'chapter 3',
    'chapter 4',
    'chapter 5',
    'chapter 6',
    'chapter 7',
    'chapter 8',
    'chapter 9',
    'chapter 10',
    'chapter 11',
    'chapter 12'
  ];

  uploadQuestion(context) async {
    try {
      Map<String, dynamic> questionmap = {
        'category': selectedField1.toString(),
        'subject': selectedField2.toString(),
        'chapter': selectedField3.toString(),
        'question': questionController.text,
        'option1': optioncontroller1.text,
        'option2': optioncontroller2.text,
        'option3': optioncontroller3.text,
        'option4': optioncontroller4.text,
        'answer': correctAnswerController.text,
      };

      await FirebaseFirestore.instance
          .collection('question')
          .doc(selectedField1)
          .collection(selectedField2)
          .doc(selectedField3)
          .collection(selectedField3)
          .doc()
          .set(questionmap)
          .then((value) {
        questionController.clear();
        optioncontroller1.clear();
        optioncontroller2.clear();
        optioncontroller3.clear();
        optioncontroller4.clear();
        correctAnswerController.clear();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Data uploaded Sucessfully'),
            duration: Duration(seconds: 3), // Adjust as needed
          ),
        );
        showDialogs(context);
      });

      log('data uploaded');
    } catch (e) {
      log('Error is : $e');
    }
  }
}