import 'package:woodiex/core/di/di.dart';
import 'package:woodiex/core/network/api_error_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:woodiex/core/helpers/shared_pref_helper.dart';
import 'package:woodiex/featrues/home/data/models/get_product_response_model.dart';
import 'package:woodiex/featrues/home/logic/get_product_states/get_product_states.dart';

part 'get_product_notifier.g.dart';

@riverpod
class GetProductNotifier extends _$GetProductNotifier {
  int _currentPage = 1;
  bool _hasReachedMax = false;
  List<ProductData> _allProducts = [];

  @override
  GetProductState build() => const GetProductInitial();

  Future<void> fetchProducts() async {
    _currentPage = 1;
    _hasReachedMax = false;
    _allProducts = [];

    state = const GetProductLoading([]);

    final token = await SharedPrefHelper.getUserToken();
    if (token.isEmpty) {
      state = GetProductError(
          ApiErrorModel(message: 'User not logged in', statusCode: 401));
      return;
    }

    final result =
        await ref.read(getProductRepoProvider).getProducts(token, _currentPage);

    result.when(
      success: (response) {
        _cacheProductIds(response.data);

        _allProducts = response.data;
        _currentPage++;
        _hasReachedMax = response.data.isEmpty ||
            response.data.length < 10; // Adjust based on API page size

        state = GetProductSuccess(_allProducts);
      },
      failure: (error) {
        state = GetProductError(error);
      },
    );
  }

  Future<void> loadMoreProducts() async {
    if (_hasReachedMax) return;

    state = GetProductLoading(_allProducts);

    final token = await SharedPrefHelper.getUserToken();
    if (token.isEmpty) {
      state = GetProductError(
          ApiErrorModel(message: 'User not logged in', statusCode: 401));
      return;
    }

    final result =
        await ref.read(getProductRepoProvider).getProducts(token, _currentPage);

    result.when(
      success: (response) {
        _allProducts.addAll(response.data);
        _currentPage++;
        _hasReachedMax = response.data.isEmpty || response.data.length < 10;

        state = GetProductLoadMoreSuccess(_allProducts, _hasReachedMax);
      },
      failure: (error) {
        state = GetProductError(error);
      },
    );
  }

  void checkAndLoadMore(int index) {
    if (index >= _allProducts.length - 5 && !_hasReachedMax) {
      loadMoreProducts();
    }
  }

  Future<void> _cacheProductIds(List<ProductData> products) async {
    final List<String> productIds =
        products.map((product) => product.id.toString()).toList();
    final String idsString = productIds.join(',');
    await SharedPrefHelper.setData('cached_product_ids', idsString);
  }

  Future<List<String>> _getCachedProductIds() async {
    final String idsString =
        await SharedPrefHelper.getString('cached_product_ids');
    if (idsString.isEmpty) return [];
    return idsString.split(',');
  }

  Future<bool> isProductCached(String productId) async {
    final cachedIds = await _getCachedProductIds();
    return cachedIds.contains(productId);
  }

  Future<void> clearCachedProductIds() async {
    await SharedPrefHelper.removeData('cached_product_ids');
  }
}
