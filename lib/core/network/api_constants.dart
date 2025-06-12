class ApiConstants {
  static const String apiBaseUrl =
      "http://furnitureecommerceapp.runasp.net/api/";

  static const String signUp = "Account/register";
  static const String login = "Account/login";
  static const String addShippingAddress =
      "ShippingAddresses/addShippingAddress";
  static const String getShippingAddress = "ShippingAddresses/allAddresses";
  static const String products = "Products/allProducts";

  static const String filterProducts = "Products/allProductsForCategry";
  static const String productDetails = "Products/id";
  static const String cart = "Cart/{productId}";
  static const String getCart = "Cart";
  static const String deleteCartItem = "Cart/{productId}";
  static const String profilePic = "Profile/UpdateProfileImage";
  static const String profile = "Profile/currentUser";

  static const String addReview = "Reviews";
  static const String getReviews = "Reviews/{productId}/reviews";
}
