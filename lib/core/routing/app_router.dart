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
import 'package:woodiex/featrues/home/data/models/product_details_response_model.dart';
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
          settings: settings,
        );
      case Routes.loginScreen:
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
          settings: settings,
        );
      case Routes.cartScreen:
        return MaterialPageRoute(
          builder: (_) => const CartScreen(),
          settings: settings,
        );
      case Routes.signUpScreen:
        return MaterialPageRoute(
          builder: (_) => const SignUpScreen(),
          settings: settings,
        );
      case Routes.appLayout:
        return MaterialPageRoute(
          builder: (_) => const AppLayout(),
          settings: settings,
        );
      case Routes.splashScreen:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
          settings: settings,
        );
      case Routes.myOrders:
        return MaterialPageRoute(
          builder: (_) => const MyOrdersScreen(),
          settings: settings,
        );
      case Routes.setteing:
        return MaterialPageRoute(
          builder: (_) => const SettingScreen(),
          settings: settings,
        );
      case Routes.paymentMethods:
        return MaterialPageRoute(
          builder: (_) => const PaymentMethodScreen(),
          settings: settings,
        );
      case Routes.myReviewsScreen:
        return MaterialPageRoute(
          builder: (_) => const MyReviewsScreen(),
          settings: settings,
        );
      case Routes.shippingAddreesScreen:
        return MaterialPageRoute(
          builder: (_) => const ShippingAddressScreen(),
          settings: settings,
        );
      case Routes.prodcutDetailsScreen:
        return CustomHeroPageRoute(
          page: ProductDetailsScreen(
            id: arguments as int,
          ),
          settings: settings,
        );
      case Routes.checkoutScreen:
        return MaterialPageRoute(
          builder: (_) => const CheckoutScreen(),
          settings: settings,
        );
      case Routes.checkoutSuccess:
        return MaterialPageRoute(
          builder: (_) => const CheckoutSuccess(),
          settings: settings,
        );
      case Routes.productReviewsScreen:
        return MaterialPageRoute(
          builder: (_) => ProductReviewsScreen(
            productDetails: arguments as ProductDetailsData?,
          ),
          settings: settings,
        );
      case Routes.addReviewScreen:
        return MaterialPageRoute(
          builder: (_) => AddReviewScreen(
            productDetails: arguments as ProductDetailsData?,
          ),
          settings: settings,
        );
      case Routes.addShippingAddressScreen:
        return MaterialPageRoute(
          builder: (_) => const AddShippingAddressScreen(),
          settings: settings,
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
          settings: settings,
        );
    }
  }
}
