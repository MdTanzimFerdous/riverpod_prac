import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class Todo {
  String id;
  String taskName;
  int taskPriorityLevel;
  String taskCategory;


  Todo({
    required this.id,
    required this.taskName,
    required this.taskPriorityLevel,
    required this.taskCategory,
  });


  factory Todo.fromJson(Map<String, dynamic> json){

    return Todo(
        id: json['id'],
        taskName: json['taskName'],
        taskPriorityLevel: json['taskPriorityLevel'],
        taskCategory: json['taskCategory'],
    );

  }

  Map<String, dynamic> toJson(){

    return {
      'id': this.id,
      'taskName': this.taskName,
      'taskPriorityLevel': this.taskPriorityLevel,
      'taskCategory': this.taskCategory,
    };

  }
}
