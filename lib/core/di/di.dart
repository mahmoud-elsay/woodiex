import 'package:dio/dio.dart';
import '../network/dio_factory.dart';
import 'package:woodiex/core/network/api_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:woodiex/featrues/cart/data/repos/cart_repo.dart';
import 'package:woodiex/featrues/home/data/repo/reviews_repo.dart';
import 'package:woodiex/featrues/home/data/repo/get_product_repo.dart';
import 'package:woodiex/featrues/auth/login/data/repo/login_repo.dart';
import 'package:woodiex/featrues/profile/orders/data/repo/order_repo.dart';
import 'package:woodiex/featrues/home/data/repo/product_details_repo.dart';
import 'package:woodiex/featrues/profile/orders/data/repos/order_repo.dart';
import 'package:woodiex/featrues/auth/sign_up/data/repos/sign_up_repo.dart';
import 'package:woodiex/featrues/profile/profile/data/repos/profile_repo.dart';
import 'package:woodiex/featrues/profile/reviews/data/repo/my_reviews_repo.dart';
import 'package:woodiex/featrues/profile/shipinng_address/data/repos/shipping_address_repo.dart';

part 'di.g.dart';

@riverpod
Dio dio(Ref ref) {
  return DioFactory.getDio();
}

@riverpod
ApiService apiService(Ref ref) {
  return ApiService(ref.read(dioProvider));
}

@riverpod
SignUpRepo signUpRepo(Ref ref) {
  return SignUpRepo(ref.read(apiServiceProvider));
}

@riverpod
LoginRepo loginRepo(Ref ref) {
  return LoginRepo(ref.read(apiServiceProvider));
}

@riverpod
ShippingAddressRepo shippingAddressRepo(Ref ref) {
  return ShippingAddressRepo(ref.read(apiServiceProvider));
}

@riverpod
GetProductRepo getProductRepo(Ref ref) {
  return GetProductRepo(ref.read(apiServiceProvider));
}

@riverpod
ProductDetailsRepo productDetailsRepo(Ref ref) {
  return ProductDetailsRepo(ref.read(apiServiceProvider));
}

@riverpod
CartRepo cartRepo(Ref ref) {
  return CartRepo(ref.read(apiServiceProvider));
}

@riverpod
ProfileRepo profileRepo(Ref ref) {
  return ProfileRepo(ref.read(apiServiceProvider));
}

@riverpod
ReviewsRepo reviewsRepo(Ref ref) {
  return ReviewsRepo(ref.read(apiServiceProvider));
}

@riverpod
MyReviewsRepo myReviewsRepo(Ref ref) {
  return MyReviewsRepo(ref.read(apiServiceProvider));
}
@riverpod
OrderRepo orderRepo(Ref ref) {
  return OrderRepo(ref.read(apiServiceProvider));
}