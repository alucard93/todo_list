class Task {
  String title;
  String? description;
  bool isCompleted;
  bool isImportant;
  DateTime createdAt = DateTime.now();

  Task({required this.title, this.description, this.isImportant = false})
    : isCompleted = false,
      createdAt = DateTime.now();

  void changeStatus(bool status) {
    isCompleted = status;
  }

  void changeImportance() {
    isImportant = !isImportant;
  }
}
