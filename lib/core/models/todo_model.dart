class Todo {
  String id;
  String taskName;
  int taskPriorityLevel;
  String taskCategory;
  bool isFromAdmin;


  Todo({
    required this.id,
    required this.taskName,
    required this.taskPriorityLevel,
    required this.taskCategory,
    this.isFromAdmin=false
  });


  factory Todo.fromJson(Map<String, dynamic> json){
    return Todo(
        id: json['id'],
        taskName: json['taskName'],
        taskPriorityLevel: json['taskPriorityLevel'],
        taskCategory: json['taskCategory'],
      isFromAdmin: json['isFromAdmin'] ?? false
    );
  }

  Map<String, dynamic> toJson(){
    return {
      'id': this.id,
      'taskName': this.taskName,
      'taskPriorityLevel': this.taskPriorityLevel,
      'taskCategory': this.taskCategory,
      'isFromAdmin':this.isFromAdmin
    };
  }
}
