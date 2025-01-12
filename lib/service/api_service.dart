import 'package:my_awesome_namer/models/user_model.dart';
import 'package:retrofit/http.dart';
import 'package:dio/dio.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: 'http://127.0.0.1:8000/')
abstract class ApiService {
  factory ApiService(Dio dio) = _ApiService;

  @GET('Users')
  Future<UserModel> getUsers();
}

// flutter pub run build_runner build