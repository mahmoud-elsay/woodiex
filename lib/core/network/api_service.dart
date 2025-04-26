import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:woodiex/core/network/api_constants.dart';
import 'package:woodiex/featrues/auth/sign_up/data/models/sign_up_request_model.dart';
import 'package:woodiex/featrues/auth/sign_up/data/models/sign_up_response_model.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: ApiConstants.apiBaseUrl)
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @POST(ApiConstants.signUp)
  Future<SignUpResponseModel> signUp(
    @Body() SignUpRequestModel signUpRequestModel,
  );
}
