import 'package:woodiex/core/di/di.dart';
import 'package:woodiex/core/network/api_error_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:woodiex/core/helpers/shared_pref_helper.dart';
import 'package:woodiex/featrues/home/data/models/product_details_response_model.dart';
import 'package:woodiex/featrues/home/logic/product_details_notifier/product_details_states.dart';

part 'product_details_notifier.g.dart';

@riverpod
class ProductDetailsNotifier extends _$ProductDetailsNotifier {
  ProductDetailsData? _productDetails;

  @override
  ProductDetailsState build() => const ProductDetailsInitial();

  Future<void> fetchProductDetails(int id) async {
    print('Fetching product details for id: $id');
    state = ProductDetailsLoading(_productDetails ??
        ProductDetailsData(
          id: 0,
          name: '',
          imageUrl: '',
          description: '',
          price: 0.0,
          reviewsCount: 0,
          reveiewAverageRating: 0.0,
          reviews: [],
        ));

    final token = await SharedPrefHelper.getUserToken();
    print('Token retrieved: $token');
    if (token.isEmpty) {
      print('Token is empty, setting error state');
      state = ProductDetailsError(
          ApiErrorModel(message: 'User not logged in', statusCode: 401));
      return;
    }

    final result = await ref
        .read(productDetailsRepoProvider)
        .getProductDetails('Bearer $token', id);
    print('API response: $result');

    result.when(
      success: (response) {
        print('Success, product details retrieved');
        _productDetails = response.data;
        state = ProductDetailsSuccess(_productDetails!);
      },
      failure: (error) {
        print('Failure, error: ${error.message}');
        state = ProductDetailsError(error);
      },
    );
  }

  Future<void> clearProductDetails() async {
    print('Clearing product details');
    _productDetails = null;
    state = const ProductDetailsInitial();
  }
}
