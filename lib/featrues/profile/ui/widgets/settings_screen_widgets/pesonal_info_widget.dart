import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:woodiex/core/theming/colors.dart';
import 'package:woodiex/core/theming/styles.dart';
import 'package:woodiex/core/helpers/spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PersonalInfoWidget extends StatefulWidget {
  const PersonalInfoWidget({super.key});

  @override
  State<PersonalInfoWidget> createState() => _PersonalInfoWidgetState();
}

class _PersonalInfoWidgetState extends State<PersonalInfoWidget> {
  String _name = 'Mostfa Naf3';
  String _email = 'mostfa.naf3@gmail.com';

  // TextControllers for input fields in the dialog
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  // Function to show edit dialog
  void _showEditDialog() {
    // Set initial text for controllers
    _nameController.text = _name;
    _emailController.text = _email;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Edit Information',
          style: Fonts.secondaryGreyNunitoSansBold18,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Cancel',
                style: TextStyle(color: ColorsManager.secondaryGrey)),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _name = _nameController.text;
                _email = _emailController.text;
              });
              Navigator.of(context).pop();
            },
            child:
                Text('Save', style: TextStyle(color: ColorsManager.mainBlack)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              'Personal Information',
              style:
                  Fonts.secondaryGreyNunitoSansBold18.copyWith(fontSize: 16.sp),
            ),
            const Spacer(),
            GestureDetector(
              onTap: _showEditDialog,
              child: SvgPicture.asset(
                'assets/svgs/edit_icon.svg',
                color: ColorsManager.secondaryGrey,
              ),
            ),
          ],
        ),
        verticalSpace(25),
        _buildInfoContainer('Name', _name),
        verticalSpace(15),
        _buildInfoContainer('Email', _email),
      ],
    );
  }

  Widget _buildInfoContainer(String label, String value) {
    return Container(
      width: 335.w,
      height: 64.h,
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: Fonts.nunitoSansRegular14.copyWith(fontSize: 12.sp),
          ),
          verticalSpace(5),
          Text(
            value,
            style: Fonts.blacknNnitoSansBold18.copyWith(fontSize: 14.sp),
          ),
        ],
      ),
    );
  }
}
