import 'package:flutter/material.dart';
import 'package:woodiex/core/routing/routes.dart';
import 'package:woodiex/featrues/layout/app_layout.dart';
import 'package:woodiex/featrues/splash/splash_screen.dart';
import 'package:woodiex/featrues/auth/login/ui/login_screen.dart';
import 'package:woodiex/featrues/cart/ui/screens/cart_screen.dart';
import 'package:woodiex/featrues/onboarding/onboarding_screen.dart';
import 'package:woodiex/featrues/auth/sign_up/ui/sign_up_screen.dart';
import 'package:woodiex/featrues/cart/ui/screens/checkout_screen.dart';
import 'package:woodiex/featrues/cart/ui/screens/checkout_success.dart';
import 'package:woodiex/featrues/home/ui/screens/add_review_screen.dart';
import 'package:woodiex/featrues/profile/orders/ui/my_orders_screen.dart';
import 'package:woodiex/featrues/profile/reviews/ui/my_reviews_screen.dart';
import 'package:woodiex/featrues/home/ui/screens/product_reviews_screen.dart';
import 'package:woodiex/featrues/home/ui/screens/product_details_screen.dart';
import 'package:woodiex/featrues/profile/profile/ui/screens/setting_screen.dart';
import 'package:woodiex/featrues/profile/profile/ui/screens/payment_method_screen.dart';
import 'package:woodiex/featrues/profile/shipinng_address/ui/shipping_address_screen.dart';
import 'package:woodiex/featrues/profile/shipinng_address/ui/add_shippng_address_screen.dart';
import 'package:woodiex/featrues/home/ui/widgets/product_details_screen_widget/animation_transtion.dart';

class AppRouter {
  Route generateRoute(RouteSettings settings) {
    final arguments = settings.arguments;

    switch (settings.name) {
      case Routes.onBoardingScreen:
        return MaterialPageRoute(
          builder: (_) => const OnboardingScreen(),
        );
      case Routes.loginScreen:
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
        );
      case Routes.cartScreen:
        return MaterialPageRoute(
          builder: (_) => const CartScreen(),
        );
      case Routes.signUpScreen:
        return MaterialPageRoute(
          builder: (_) => const SignUpScreen(),
        );
      case Routes.appLayout:
        return MaterialPageRoute(
          builder: (_) => const AppLayout(),
        );
      case Routes.splashScreen:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
        );
      case Routes.myOrders:
        return MaterialPageRoute(
          builder: (_) => const MyOrdersScreen(),
        );
      case Routes.setteing:
        return MaterialPageRoute(
          builder: (_) => const SettingScreen(),
        );
      case Routes.paymentMethods:
        return MaterialPageRoute(
          builder: (_) => const PaymentMethodScreen(),
        );
      case Routes.myReviewsScreen:
        return MaterialPageRoute(
          builder: (_) => const MyReviewsScreen(),
        );
      case Routes.shippingAddreesScreen:
        return MaterialPageRoute(
          builder: (_) => const ShippingAddressScreen(),
        );
      case Routes.prodcutDetailsScreen:
        // Enhanced hero route with proper settings
        return CustomHeroPageRoute(
          page: ProductDetailsScreen(
            id: arguments as int,
          ),
          settings: settings, // Pass settings for proper route handling
        );
      case Routes.checkoutScreen:
        return MaterialPageRoute(
          builder: (_) => const CheckoutScreen(),
        );
      case Routes.checkoutSuccess:
        return MaterialPageRoute(
          builder: (_) => const CheckoutSuccess(),
        );
      case Routes.productReviewsScreen:
        return MaterialPageRoute(
          builder: (_) => const ProductReviewsScreen(),
        );
      case Routes.addShippingAddressScreen:
        return MaterialPageRoute(
          builder: (_) => const AddShippingAddressScreen(),
        );
      case Routes.addReviewScreen:
        return MaterialPageRoute(
          builder: (_) => const AddReviewScreen(),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
