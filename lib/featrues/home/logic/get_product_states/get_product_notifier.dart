import 'package:woodiex/core/di/di.dart';
import 'package:woodiex/core/network/api_error_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:woodiex/core/helpers/shared_pref_helper.dart';
import 'package:woodiex/featrues/home/data/models/get_product_response_model.dart';
import 'package:woodiex/featrues/home/data/models/filter_product_model.dart'
    as filter;
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
    print('Fetching products, page: $_currentPage');
    _currentPage = 1;
    _hasReachedMax = false;
    _allProducts = [];

    state = const GetProductLoading([]);

    final token = await SharedPrefHelper.getUserToken();
    print('Token retrieved: $token');
    if (token.isEmpty) {
      print('Token is empty, setting error state');
      state = GetProductError(
          ApiErrorModel(message: 'User not logged in', statusCode: 401));
      return;
    }

    final result = await ref
        .read(getProductRepoProvider)
        .getProducts('Bearer $token', _currentPage);
    print('API response: $result');

    result.when(
      success: (response) {
        print('Success, products count: ${response.data.length}');
        _cacheProductIds(response.data);

        _allProducts = response.data;
        _currentPage++;
        _hasReachedMax =
            response.data.isEmpty; // Only set to true if no data is returned
        print('Has reached max after fetch: $_hasReachedMax');

        state = GetProductSuccess(_allProducts);
      },
      failure: (error) {
        print('Failure, error: ${error.message}');
        state = GetProductError(error);
      },
    );
  }

  Future<void> loadMoreProducts() async {
    print(
        'Loading more products, page: $_currentPage, hasReachedMax: $_hasReachedMax');
    if (_hasReachedMax) return;

    state = GetProductLoading(_allProducts);

    final token = await SharedPrefHelper.getUserToken();
    if (token.isEmpty) {
      state = GetProductError(
          ApiErrorModel(message: 'User not logged in', statusCode: 401));
      return;
    }

    final result = await ref
        .read(getProductRepoProvider)
        .getProducts('Bearer $token', _currentPage);
    print('API response for load more: $result');

    result.when(
      success: (response) {
        print('Load more success, new products count: ${response.data.length}');
        _allProducts.addAll(response.data);
        _currentPage++;
        _hasReachedMax =
            response.data.isEmpty; // Only set to true if no data is returned
        print('Has reached max after load more: $_hasReachedMax');

        state = GetProductLoadMoreSuccess(_allProducts, _hasReachedMax);
      },
      failure: (error) {
        print('Load more failure, error: ${error.message}');
        state = GetProductError(error);
      },
    );
  }

  void checkAndLoadMore(int index) {
    print(
        'Checking load more at index: $index, hasReachedMax: $_hasReachedMax, total products: ${_allProducts.length}');
    if (index >= _allProducts.length - 5 && !_hasReachedMax) {
      loadMoreProducts();
    }
  }

  Future<void> fetchFilteredProducts(String category) async {
    print('Fetching filtered products for category: $category');
    state = GetProductFilterLoading(_allProducts);

    final token = await SharedPrefHelper.getUserToken();
    print('Token retrieved for filter: $token');
    if (token.isEmpty) {
      print('Token is empty, setting error state for filter');
      state = GetProductError(
          ApiErrorModel(message: 'User not logged in', statusCode: 401));
      return;
    }

    final result = await ref
        .read(getProductRepoProvider)
        .getFilteredProducts('Bearer $token', category);
    print('API response for filter: $result');

    result.when(
      success: (response) {
        print('Filter success, products count: ${response.data.length}');
        _allProducts = response.data
            .map((filterProduct) => ProductData(
                  id: filterProduct.id,
                  imageUrl: filterProduct.imageUrl,
                  name: filterProduct.name,
                  price: filterProduct.price,
                ))
            .toList(); // Convert filter.ProductData to ProductData
        state = GetProductFilterSuccess(_allProducts);
      },
      failure: (error) {
        print('Filter failure, error: ${error.message}');
        state = GetProductError(error);
      },
    );
  }

  Future<void> _cacheProductIds(List<ProductData> products) async {
    final List<String> productIds =
        products.map((product) => product.id.toString()).toList();
    final String idsString = productIds.join(',');
    print('Caching product IDs: $idsString');
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
