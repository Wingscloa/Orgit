import 'dart:ffi';

import 'package:my_awesome_namer/models/user_model.dart';
import 'package:my_awesome_namer/models/response_model.dart';
import 'package:retrofit/http.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';
import 'package:retrofit/call_adapter.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: 'http://192.168.35.188:8000/')
abstract class RestClient {
  factory RestClient(Dio dio) = _RestClient;

  @GET('/User')
  Future<ApiResponseUsers> getUsers();

  @GET('/UserByUId/{useruid}')
  Future<ApiResponseUser> getUserByUid(@Path() String useruid);

  @POST('/User')
  Future<defaultResponse> createUser(
      @Body() Map<String, dynamic> userAddSchema);

  @PUT('/User')
  Future<defaultResponse> updateProfile(@Body() Map<String, dynamic> detail);

  // Email
  @GET('/EmailExists/{email}')
  Future<boolResponse> doesEmailExists(@Path() String email);
}

// flutter pub run build_runner build
