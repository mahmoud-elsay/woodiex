import 'package:flutter/material.dart';
import 'package:woodiex/core/theming/colors.dart';

class CustomSwitch extends StatefulWidget {
  const CustomSwitch({super.key});

  @override
  _CustomSwitchState createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch> {
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: () {
            setState(() {
              isSwitched = !isSwitched;
            });
          },
          child: AnimatedContainer(
            duration: Duration(milliseconds: 200),
            width: 40,
            height: 24,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: isSwitched ? ColorsManager.green : Colors.grey[400],
            ),
            child: Stack(
              children: [
                AnimatedPositioned(
                  duration: Duration(milliseconds: 200),
                  curve: Curves.easeIn,
                  left: isSwitched ? 16 : 0,
                  right: isSwitched ? 0 : 16,
                  child: Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
