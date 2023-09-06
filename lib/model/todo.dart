// ignore_for_file: public_member_api_docs, sort_constructors_first
class ToDO {
  String id;
  String toDoText;
  bool isDone;
  ToDO({
    required this.id,
    required this.toDoText,
    this.isDone = false,
  });

  static List<ToDO> toDoList() {
    return [
      ToDO(id: "01", toDoText: "Drink Water", isDone: true),
      ToDO(id: "02", toDoText: "Go For a Run", isDone: true),
      ToDO(id: "03", toDoText: "Check Mail", isDone: false),
      ToDO(id: "04", toDoText: "Study"),
      ToDO(id: "05", toDoText: "Do CourseWork"),
    ];
  }
}
