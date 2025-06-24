import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:woodiex/core/network/api_constants.dart';
import 'package:woodiex/featrues/home/data/models/filter_product_model.dart';
import 'package:woodiex/featrues/cart/data/models/get_cart_response_model.dart';
import 'package:woodiex/featrues/home/data/models/add_review_request_model.dart';
import 'package:woodiex/featrues/auth/login/data/models/login_request_model.dart';
import 'package:woodiex/featrues/home/data/models/add_review_response_model.dart';
import 'package:woodiex/featrues/auth/login/data/models/login_response_model.dart';
import 'package:woodiex/featrues/home/data/models/get_product_response_model.dart';
import 'package:woodiex/featrues/cart/data/models/add_product_response_model.dart';
import 'package:woodiex/featrues/home/data/models/get_reviews_response_model.dart';
import 'package:woodiex/featrues/auth/sign_up/data/models/sign_up_request_model.dart';
import 'package:woodiex/featrues/auth/sign_up/data/models/sign_up_response_model.dart';
import 'package:woodiex/featrues/home/data/models/product_details_response_model.dart';
import 'package:woodiex/featrues/cart/data/models/delete_cart_item_response_model.dart';
import 'package:woodiex/featrues/profile/orders/data/models/get_order_response_model.dart';
import 'package:woodiex/featrues/profile/orders/data/models/post_order_response_model.dart';
import 'package:woodiex/featrues/profile/reviews/data/models/my_reviews_response_model.dart';
import 'package:woodiex/featrues/profile/profile/data/models/update_profile_image_response.dart';
import 'package:woodiex/featrues/profile/profile/data/models/get_profile_info_response_model.dart';
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

  @GET(ApiConstants.filterProducts)
  Future<FilterProductModel> getFilterProducts(
    @Header('Authorization') String token,
    @Query('categories') String categories,
  );

  @GET(ApiConstants.productDetails)
  Future<ProductDetailsResponseModel> getProductDetails(
    @Header('Authorization') String token,
    @Query('id') int id,
  );

  @POST(ApiConstants.cart)
  Future<AddProductResponseModel> addToCart(
    @Path('productId') int productId,
    @Query('quantity') int quantity,
    @Header('Authorization') String token,
  );

  @GET(ApiConstants.getCart)
  Future<GetCartResponseModel> getCart(
    @Header('Authorization') String token,
  );

  @DELETE(ApiConstants.deleteCartItem)
  Future<DeleteCartItemResponseModel> deleteCartItem(
    @Path('productId') int productId,
    @Header('Authorization') String token,
  );

  @PUT('${ApiConstants.profilePic}')
  @MultiPart()
  Future<UpdateProfileImageResponse> updateProfileImage(
    @Header('Authorization') String token,
    @Body() FormData formData,
  );

  @GET(ApiConstants.profile)
  Future<GetProfileInfoResponseModel> getProfileInfo(
    @Header('Authorization') String token,
  );

  @POST(ApiConstants.addReview)
  Future<AddReviewResponseModel> addReview(
    @Body() AddReviewRequestModel requestModel,
    @Header('Authorization') String token,
  );

  @GET(ApiConstants.getReviews)
  Future<GetReviewsResponseModel> getReviews(
    @Path('productId') int productId,
    @Header('Authorization') String token,
  );

  @GET(ApiConstants.getMyReviews)
  Future<MyReviewsResponseModel> getMyReviews(
    @Header('Authorization') String token,
  );

  @POST(ApiConstants.postOrder)
  Future<PostOrderResponseModel> postOrder(
    @Query('deliveryMethodId') int deliveryMethodId,
    @Header('Authorization') String token,
  );

  @GET(ApiConstants.getOrders)
  Future<GetOrderResponseModel> getOrders(
    @Header('Authorization') String token,
  );
}
