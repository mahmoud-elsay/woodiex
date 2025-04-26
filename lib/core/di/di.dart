import 'package:dio/dio.dart';
import '../network/dio_factory.dart';
import 'package:woodiex/core/network/api_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'di.g.dart';

@Riverpod(keepAlive: true)
Dio dio(DioRef ref) {
  return DioFactory.getDio();
}

@Riverpod(keepAlive: true)
ApiService apiService(ApiServiceRef ref) {
  return ApiService(ref.read(dioProvider));
}
