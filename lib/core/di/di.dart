import 'package:dio/dio.dart';
import '../network/dio_factory.dart';
import 'package:woodiex/core/network/api_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:woodiex/featrues/auth/login/data/repo/login_repo.dart';
import 'package:woodiex/featrues/auth/sign_up/data/repos/sign_up_repo.dart';
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
