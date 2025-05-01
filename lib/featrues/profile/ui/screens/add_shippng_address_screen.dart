import 'package:flutter/material.dart';
import 'package:woodiex/core/helpers/spacing.dart';
import 'package:woodiex/core/widgets/backble_top_bar.dart';

class AddShippngAddressScreen extends StatelessWidget {
  const AddShippngAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          BackableTopBar(
            screenTitle: 'Add Shipping Address',
          ),
          verticalSpace(15),
        ],
      ),
    );
  }
}
