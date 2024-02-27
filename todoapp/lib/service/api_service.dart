import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:todoapp/helper/dio_helper.dart';
import 'package:todoapp/service/models/todo_model.dart';

part 'api_service.g.dart';

@RestApi()
abstract class RestClient {
  factory RestClient() => _RestClient(DioClient.instance.dio);

  @GET('/task-list')
  Future<List<Todo>> getTasks();

  @GET('/task-list/{id}')
  Future<Todo> getTask(@Path('id') int id);

  @POST('/task-create/')
  Future<Todo> createTask(@Body(nullToAbsent: true) Todo task);

  @POST('/task-update/{id}')
  Future<Todo> updateTask(@Path() int id, @Body() Todo task);

  @DELETE('/task-delete/{id}')
  Future<void> deleteTask(@Path() int id);
}
