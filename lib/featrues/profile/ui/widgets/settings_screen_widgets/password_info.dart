import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:woodiex/core/theming/colors.dart';
import 'package:woodiex/core/theming/styles.dart';
import 'package:woodiex/core/helpers/spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PasswordInfo extends StatefulWidget {
  const PasswordInfo({super.key});

  @override
  State<PasswordInfo> createState() => _PasswordInfoState();
}

class _PasswordInfoState extends State<PasswordInfo> {
  String _password = 'yourpassword123';
  final TextEditingController _passwordController = TextEditingController();

  void _showPasswordEditDialog() {
    _passwordController.text = _password;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Edit Password',
          style: Fonts.nunitoSans18BoldSecondaryGrey,
        ),
        content: TextField(
          controller: _passwordController,
          obscureText: false,
          decoration: const InputDecoration(labelText: 'Password'),
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
                _password = _passwordController.text;
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
              'Password',
              style: Fonts.nunitoSans18BoldSecondaryGrey,
            ),
            const Spacer(),
            GestureDetector(
              onTap: _showPasswordEditDialog,
              child: SvgPicture.asset(
                'assets/svgs/edit_icon.svg',
                color: ColorsManager.secondaryGrey,
              ),
            ),
          ],
        ),
        verticalSpace(25),
        _buildPasswordContainer(),
      ],
    );
  }

  Widget _buildPasswordContainer() {
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
            'Password',
            style: Fonts.nunitoSans12RegularSecondaryGrey,
          ),
          verticalSpace(5),
          Text(
            '*****',
            style: Fonts.nunitoSans14BoldMainBlack,
          ),
        ],
      ),
    );
  }
}
