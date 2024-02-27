import 'package:flutter/material.dart';
import 'package:todoapp/service/models/todo_model.dart';
import 'package:todoapp/service/todo_service.dart';

class Add extends StatefulWidget {
  final Todo? todo;
  const Add({super.key, this.todo});

  @override
  State<Add> createState() => _AddState();
}

class _AddState extends State<Add> {
  late Todo? todoData;
  TextEditingController _title = TextEditingController();
  TextEditingController _description = TextEditingController();

  @override
  void initState() {
    if (widget.todo != null) {
      todoData = widget.todo;
      _title = TextEditingController(text: widget.todo?.title ?? '');
      _description =
          TextEditingController(text: widget.todo?.description ?? '');
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: _title,
              decoration: const InputDecoration(hintText: 'Title'),
            ),
            TextField(
              controller: _description,
              decoration: const InputDecoration(hintText: 'Description'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (widget.todo != null) {
                  todoService.updateTask(
                    id: todoData!.id!,
                    post: todoData!.copyWith(
                      title: _title.text,
                      description: _description.text,
                      completed: false,
                      updated: DateTime.now()
                    ),
                  );
                } else {
                  todoService.createTask(
                    post: Todo(
                        title: _title.text,
                        description: _description.text,
                        completed: false),
                  );
                }
                Navigator.pop(context);
              },
              child: Text(widget.todo != null ? 'Edit' : 'Add'),
            )
          ],
        ),
      ),
    );
  }
}
