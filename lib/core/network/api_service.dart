import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:woodiex/core/network/api_constants.dart';
import 'package:woodiex/featrues/auth/login/data/models/login_request_model.dart';
import 'package:woodiex/featrues/auth/login/data/models/login_response_model.dart';
import 'package:woodiex/featrues/home/data/models/get_product_response_model.dart';
import 'package:woodiex/featrues/auth/sign_up/data/models/sign_up_request_model.dart';
import 'package:woodiex/featrues/auth/sign_up/data/models/sign_up_response_model.dart';
import 'package:woodiex/featrues/profile/shipinng_address/data/models/add_shipping_address_request_model.dart';
import 'package:woodiex/featrues/profile/shipinng_address/data/models/add_shipping_address_response_model.dart';
import 'package:woodiex/featrues/profile/shipinng_address/data/models/get_shipping_address_response_model.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: ApiConstants.apiBaseUrl)
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @POST(ApiConstants.signUp)
  Future<SignUpResponseModel> signUp(
    @Body() SignUpRequestModel signUpRequestModel,
  );

  @POST(ApiConstants.login)
  Future<LoginResponseModel> login(
    @Body() LoginRequestModel signUpRequestModel,
  );

  @POST(ApiConstants.addShippingAddress)
  Future<AddShippingAddressResponseModel> addShippingAddress(
    @Body() AddShippingAddressRequestModel requestModel,
    @Header('Authorization') String token,
  );

  @GET(ApiConstants.getShippingAddress)
  Future<GetShippingAddressResponseModel> getShippingAddress(
    @Header('Authorization') String token,
  );

  @GET(ApiConstants.products)
  Future<GetProductResponseModel> getProducts(
    @Header('Authorization') String token,
    @Query('pageIndex') int pageIndex,
  );
}