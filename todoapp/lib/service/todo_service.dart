import 'package:signals/signals_flutter.dart';
import 'package:todoapp/service/api_service.dart';
import 'package:todoapp/service/models/todo_model.dart';

final todoService = TodoService();

class TodoService {
  late final tasks = futureSignal(() => getTaks(), autoDispose: false);
  final task = asyncSignal<Todo?>(AsyncState.data(null));
  final taskAddOrEdit = asyncSignal<Todo?>(AsyncState.data(null));
  final delete = asyncSignal<void>(AsyncState.data(null));

  Future<List<Todo>?> getTaks() async {
    final result = await RestClient().getTasks();
    return result;
  }

  Future<void> getTask({required int id}) async {
    task.value = AsyncState.loading();
    try {
      final result = await RestClient().getTask(id);
      task.value = AsyncState.data(result);
    } catch (e, st) {
      task.value = AsyncState.error(e, st);
    }
  }

  Future<void> createTask({required Todo post}) async {
    taskAddOrEdit.value = AsyncState.loading();
    try {
      final result = await RestClient().createTask(post);

      taskAddOrEdit.value = AsyncState.data(result);
      tasks.refresh();
    } catch (e, st) {
      taskAddOrEdit.value = AsyncState.error(e, st);
    }
  }

  Future<void> updateTask({required int id, required Todo post}) async {
    taskAddOrEdit.value = AsyncState.loading();
    try {
      print('errorini ori ${post.toJson()}');
      final result = await RestClient().updateTask(id, post);
      print('errorini $result');
      taskAddOrEdit.value = AsyncState.data(result);
      tasks.refresh();
    } catch (e, st) {
      print('errorini bener ${st.toString()}');
      taskAddOrEdit.value = AsyncState.error(e, st);
    }
  }

  Future<void> deleteTask({required int id}) async {
    delete.value = AsyncState.loading();
    try {
      await RestClient().deleteTask(id);
      delete.value = AsyncState.data(null);
      tasks.refresh();
    } catch (e, st) {
      delete.value = AsyncState.error(e, st);
    }
  }
}
