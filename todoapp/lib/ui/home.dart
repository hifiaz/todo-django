import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';
import 'package:todoapp/service/models/todo_model.dart';
import 'package:todoapp/service/todo_service.dart';
import 'package:todoapp/ui/add.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
      ),
      body: Watch((context) {
        final tasks = todoService.tasks;
        if (tasks.value.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (tasks.value.value == null) {
          return const Center(child: Text('No Tasks'));
        }

        if (tasks.value.hasError) {
          return Center(child: Text(tasks.value.error.toString()));
        }

        return ListView.builder(
            itemCount: tasks.value.value?.length,
            itemBuilder: (context, index) {
              final Todo todo = todoService.tasks.value.value![index];
              return ListTile(
                title: Text(
                  todo.title,
                  style: todo.completed
                      ? const TextStyle(
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough)
                      : null,
                ),
                subtitle: Text(
                  todo.description ?? '',
                  style: todo.completed
                      ? const TextStyle(
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough)
                      : null,
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () {
                        todoService.deleteTask(id: todo.id!);
                      },
                      icon: const Icon(Icons.delete),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => Add(todo: todo)),
                        );
                      },
                      icon: const Icon(Icons.edit),
                    ),
                  ],
                ),
                onTap: () {
                  todoService.updateTask(
                    id: todo.id!,
                    post: todo.copyWith(
                      completed: !todo.completed,
                      updated: DateTime.now(),
                    ),
                  );
                },
              );
            });
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const Add()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
