class Task {
  String title;
  String? description;
  bool isCompleted;
  bool isImportant;

  Task({required this.title, this.description, this.isImportant = false})
    : isCompleted = false;

  void changeStatus(bool status) {
    isCompleted = status;
  }

  void changeImportance() {
    isImportant = !isImportant;
  }
}
