import 'package:dio/dio.dart';
import '../network/dio_factory.dart';
import 'package:woodiex/core/network/api_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:woodiex/featrues/auth/sign_up/data/repos/sign_up_repo.dart';


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