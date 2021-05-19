import 'package:amplify_flutter/amplify.dart';
import 'package:aws_amplify_todo/models/ToDoModel.dart';

class DBServices {

  Future fetchAllToDo() async {
    try {
    List<ToDoModel> todoList = await Amplify.DataStore.query(ToDoModel.classType);
    return todoList;
    } catch (e) {
    print("Could not query DataStore: " + e);
    }
  }

  Future createToDo(title) async {
    final item = ToDoModel(
      title: title,
      isComplete: false,
      //dueDt: TemporalDate(DateTime.now())
    );
    await Amplify.DataStore.save(item);
  }

  Future updateToDo(ToDoModel todo, bool isComplete) async {
    final updateToDo = todo.copyWith(
      isComplete: isComplete,
      //dueDt: TemporalDate.fromString(dueDt)
    );
    await Amplify.DataStore.save(updateToDo);
  }

  Future deleteToDo(ToDoModel todo) async {
    await Amplify.DataStore.delete(todo);
  }

}