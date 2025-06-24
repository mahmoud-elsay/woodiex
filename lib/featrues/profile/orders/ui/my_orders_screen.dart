import 'package:flutter/material.dart';
import 'package:woodiex/core/theming/styles.dart';
import 'package:woodiex/core/theming/colors.dart';
import 'package:woodiex/core/helpers/spacing.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woodiex/core/widgets/backble_top_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:woodiex/core/animations/custom_loading_animation.dart';
import 'package:woodiex/featrues/profile/orders/logic/order_notifier.dart';
import 'package:woodiex/featrues/profile/orders/ui/widgets/order_filter.dart';
import 'package:woodiex/featrues/profile/orders/ui/widgets/orders_list_view.dart';

class MyOrdersScreen extends ConsumerStatefulWidget {
  const MyOrdersScreen({super.key});

  @override
  ConsumerState<MyOrdersScreen> createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends ConsumerState<MyOrdersScreen> {
  String selectedFilter = 'All';

  @override
  void initState() {
    super.initState();
    // Fetch orders when screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(orderNotifierProvider.notifier).getOrders();
    });
  }

  @override
  Widget build(BuildContext context) {
    final orderState = ref.watch(orderNotifierProvider);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            children: [
              BackableTopBar(screenTitle: 'My Orders'),
              verticalSpace(15),
              OrderFilter(
                selectedFilter: selectedFilter,
                onFilterChanged: (filter) {
                  setState(() {
                    selectedFilter = filter;
                  });
                },
              ),
              verticalSpace(15),
              Expanded(
                child: orderState.when(
                  initial: () => const Center(
                    child: CustomLoadingWidget(),
                  ),
                  loading: (data) => const Center(
                    child: CustomLoadingWidget(),
                  ),
                  postSuccess: (data) => const Center(
                    child: CustomLoadingWidget(),
                  ),
                  getSuccess: (data) {
                    if (data.data == null || data.data!.isEmpty) {
                      return _buildEmptyState();
                    }
                    return OrdersListView(
                      orders: data.data!,
                      selectedFilter: selectedFilter,
                    );
                  },
                  error: (error) => _buildErrorState(
                      error.message ?? 'An unknown error occurred'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_bag_outlined,
            size: 64.r,
            color: ColorsManager.secondaryGrey,
          ),
          verticalSpace(16),
          Text(
            'No Orders Found',
            style: Fonts.nunitoSans18SemiBoldMainBlack,
          ),
          verticalSpace(8),
          Text(
            'You haven\'t placed any orders yet.',
            style: Fonts.nunitoSans14RegularSecondaryGrey,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 64.r,
            color: Colors.red,
          ),
          verticalSpace(16),
          Text(
            'Error Loading Orders',
            style: Fonts.nunitoSans18SemiBoldMainBlack,
          ),
          verticalSpace(8),
          Text(
            message,
            style: Fonts.nunitoSans14RegularSecondaryGrey,
            textAlign: TextAlign.center,
          ),
          verticalSpace(16),
          ElevatedButton(
            onPressed: () {
              ref.read(orderNotifierProvider.notifier).getOrders();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorsManager.mainBlack,
              foregroundColor: Colors.white,
            ),
            child: Text('Retry'),
          ),
        ],
      ),
    );
  }
}
