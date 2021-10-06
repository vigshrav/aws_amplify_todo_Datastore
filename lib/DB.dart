import 'package:amplify_flutter/amplify.dart';
import 'package:aws_amplify_todo/models/ToDoList.dart';

class DBServices {

  Future fetchAllToDo() async {
    try {
    List<ToDoList> todoList = await Amplify.DataStore.query(ToDoList.classType);
    return todoList;
    } catch (e) {
    print("Could not query DataStore: " + e.toString());
    }
  }

  Future createToDo(title) async {
    final item = ToDoList(
      title: title,
      isComplete: false,
      //dueDt: TemporalDate(DateTime.now())
    );
    await Amplify.DataStore.save(item);
  }

  Future updateToDo(ToDoList todo, bool isComplete) async {
    final updateToDo = todo.copyWith(
      isComplete: isComplete,
      //dueDt: TemporalDate.fromString(dueDt)
    );
    await Amplify.DataStore.save(updateToDo);
  }

  Future deleteToDo(ToDoList todo) async {
    await Amplify.DataStore.delete(todo);
  }

}