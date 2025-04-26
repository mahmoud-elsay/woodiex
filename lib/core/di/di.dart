import 'package:dio/dio.dart';
import '../network/dio_factory.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'di.g.dart';

@Riverpod(keepAlive: true)
Dio dio(DioRef ref) {
  return DioFactory.getDio();
}
