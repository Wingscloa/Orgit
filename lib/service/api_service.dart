import 'package:my_awesome_namer/models/user_model.dart';
import 'package:retrofit/http.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/error_logger.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: 'http://192.168.0.81:8000/')
abstract class ApiService {
  factory ApiService(Dio dio) = _ApiService;

  @GET('User')
  Future<List<UserModel>> getUsers();
}

// flutter pub run build_runner build
