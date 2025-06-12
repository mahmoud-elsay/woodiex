import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:woodiex/core/helpers/spacing.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woodiex/core/widgets/backble_top_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:woodiex/core/animations/custom_loading_animation.dart';
import 'package:woodiex/featrues/profile/reviews/logic/my_reviews_notifier.dart';
import 'package:woodiex/featrues/profile/reviews/ui/widgets/my_reviews_list_view.dart';
import 'package:woodiex/core/helpers/shared_pref_helper.dart'; // Import SharedPrefHelper
import 'package:woodiex/featrues/profile/reviews/data/models/my_reviews_response_model.dart';

class MyReviewsScreen extends ConsumerStatefulWidget {
  const MyReviewsScreen({super.key});

  @override
  _MyReviewsScreenState createState() => _MyReviewsScreenState();
}

class _MyReviewsScreenState extends ConsumerState<MyReviewsScreen> {
  @override
  void initState() {
    super.initState();
    _fetchReviews();
  }

  Future<void> _fetchReviews() async {
    final token = await SharedPrefHelper.getUserToken();
    if (token.isNotEmpty) {
      ref.read(myReviewsNotifierProvider.notifier).getMyReviews();
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please log in to view your reviews')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(myReviewsNotifierProvider);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            children: [
              Row(
                children: [
                  BackableTopBar(screenTitle: 'My Reviews'),
                  const Spacer(),
                  SvgPicture.asset('assets/svgs/search.svg'),
                ],
              ),
              verticalSpace(20),
              Expanded(
                child: state.when(
                  initial: () => const Center(child: CustomLoadingWidget()),
                  loading: (data) => data != null
                      ? _buildContent(data)
                      : const Center(child: CustomLoadingWidget()),
                  success: (data) => data != null
                      ? _buildContent(data)
                      : const Center(child: Text('No reviews available')),
                  error: (error) => Center(
                    child: Text(
                      error.message ?? 'Failed to load reviews',
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent(MyReviewsResponseModel data) {
    return MyReviewsListView(data: data);
  }
}
